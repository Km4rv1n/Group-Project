package com.marvin.example.jobportal.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.method.configuration.EnableMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.servlet.util.matcher.MvcRequestMatcher;
import org.springframework.web.servlet.handler.HandlerMappingIntrospector;

@Configuration
@EnableMethodSecurity
public class WebSecurityConfig {

    @Autowired
    HandlerMappingIntrospector introspector;

    private UserDetailsService userDetailsService;

    @Bean
    protected SecurityFilterChain filterChain(HttpSecurity http, CustomAuthenticationSuccessHandler successHandler) throws Exception {
        http
                .authorizeHttpRequests(
                        auth -> auth
                                .requestMatchers(
                                        new MvcRequestMatcher(introspector, "/")
                                )
                                .authenticated()
                                .requestMatchers(new MvcRequestMatcher(introspector, "/recruiter/**")).hasRole("RECRUITER")

                                .anyRequest()
                                .permitAll()
                )
                .formLogin(
                        form ->
                                form.loginPage("/login")
                                        .successHandler(successHandler)
                                        .permitAll()
                )
                // provide logging out support
                .logout(
                        logout -> logout.permitAll()
                );
        return http.build();
    }

    @Bean
    public BCryptPasswordEncoder bCryptPasswordEncoder() {
        return new BCryptPasswordEncoder();
    }

    /**
     * Configure Spring Security to use our custom implementation of UserDetailsService with BCrypt encoder
     *
     * @param auth authentication manager builder
     * @throws Exception if an error occurs when adding UserDetailsService
     */
    public void configureGlobal(AuthenticationManagerBuilder auth) throws Exception {
        auth.userDetailsService(userDetailsService).passwordEncoder(bCryptPasswordEncoder());
    }

}

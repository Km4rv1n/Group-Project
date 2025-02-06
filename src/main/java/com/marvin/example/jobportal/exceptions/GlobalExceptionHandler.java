package com.marvin.example.jobportal.exceptions;

import com.marvin.example.jobportal.models.User;
import com.marvin.example.jobportal.services.UserService;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.authority.AuthorityUtils;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;

import java.security.Principal;
import java.util.List;
import java.util.Set;

@ControllerAdvice
public class GlobalExceptionHandler {

    @ExceptionHandler
    public String handleException(Exception e, Model model, Principal principal) {

        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        Set<String> authorities = AuthorityUtils.authorityListToSet(authentication.getAuthorities());

        if(e instanceof ApplicationExistsException || e instanceof JobNotFoundException || e instanceof UserNotFoundException) {
            model.addAttribute("message", e.getMessage());
        }

        else{
            model.addAttribute("message", "Something went wrong.");
        }

        model.addAttribute("authorities", authorities);
        return "error";
    }
}

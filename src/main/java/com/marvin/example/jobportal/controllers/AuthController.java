package com.marvin.example.jobportal.controllers;

import com.marvin.example.jobportal.models.User;
import com.marvin.example.jobportal.services.UserService;
import com.marvin.example.jobportal.validators.UserValidator;
import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.security.Principal;
import java.util.Objects;

@Controller
public class AuthController {
    private final UserService service;
    private final UserValidator validator;

    public AuthController(UserService service, UserValidator validator) {
        this.service = service;
        this.validator = validator;
    }

    @RequestMapping("/register")
    public String registerForm(@ModelAttribute("user") User user) {
        return "registration";
    }

    @PostMapping("/register")
    public String registration(@Valid @ModelAttribute("user") User user, BindingResult result, Model model, HttpSession session) {
        validator.validate(user, result);
        if (result.hasErrors()) {
            return "registration";
        }
        service.addUser(user);
        return "redirect:/login?success=true";
    }

    @RequestMapping("/login")
    public String login(@RequestParam(value="error", required=false) String error, @RequestParam(value="logout", required=false) String logout,@RequestParam(value="success", required=false) String success, Model model) {
        if(Objects.nonNull(error)) {
            model.addAttribute("errorMessage", "Invalid Credentials, Please try again.");
        }
        if(Objects.nonNull(logout)) {
            model.addAttribute("logoutMessage", "Logout Successful!");
        }
        if(Objects.nonNull(success)) {
            model.addAttribute("successMessage", "Successful registration. Log in with your new credentials.");
        }
        return "login";
    }

    @RequestMapping(value = {"/", "/home"})
    public String home(Principal principal, Model model) {
        String username = principal.getName();
        model.addAttribute("currentUser", service.findByUsername(username));
        return "home";
    }
}

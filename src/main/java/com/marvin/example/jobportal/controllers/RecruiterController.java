package com.marvin.example.jobportal.controllers;

import com.marvin.example.jobportal.models.Job;
import com.marvin.example.jobportal.models.User;
import com.marvin.example.jobportal.services.JobService;
import com.marvin.example.jobportal.services.UserService;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import java.security.Principal;

@Controller
@RequestMapping("/recruiter")
public class RecruiterController {

    private final UserService userService;
    private final JobService jobService;

    public RecruiterController(UserService userService, JobService jobService) {
        this.userService = userService;
        this.jobService = jobService;
    }

    @GetMapping("/dashboard/{pageNumber}")
    public String dashboard(Principal principal, Model model, @PathVariable int pageNumber) {
        User currentUser = userService.findByUsername(principal.getName());
        Page<Job> jobsByCurrentUser = jobService.jobsPerPageByCreator(currentUser, pageNumber-1);

        model.addAttribute("currentUser", currentUser);
        model.addAttribute("jobsByCurrentUser", jobsByCurrentUser);
        model.addAttribute("totalPages", jobsByCurrentUser.getTotalPages());
        return "recruiterDashboard";
    }
}

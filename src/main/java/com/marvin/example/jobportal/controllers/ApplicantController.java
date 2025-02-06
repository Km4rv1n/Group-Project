package com.marvin.example.jobportal.controllers;

import com.marvin.example.jobportal.models.Job;
import com.marvin.example.jobportal.services.JobCategoryService;
import com.marvin.example.jobportal.services.JobService;
import com.marvin.example.jobportal.services.UserService;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import java.security.Principal;

@Controller
@RequestMapping("/applicant")
public class ApplicantController {

    private final UserService userService;
    private final JobService jobService;
    private final JobCategoryService jobCategoryService;

    public ApplicantController(UserService userService, JobService jobService, JobCategoryService jobCategoryService) {
        this.userService = userService;
        this.jobService = jobService;
        this.jobCategoryService = jobCategoryService;
    }

    @GetMapping("/dashboard/{pageNumber}")
    public String applicantDashboard(Model model, Principal principal, @PathVariable int pageNumber) {
        Page<Job> allJobs = jobService.allJobsPerPage(pageNumber - 1);

        model.addAttribute("currentUser", userService.findByUsername(principal.getName()));
        model.addAttribute("allJobs", allJobs);
        model.addAttribute("categories", jobCategoryService.findAll());
        model.addAttribute("totalPages", allJobs.getTotalPages());
        return "applicantDashboard";
    }
}

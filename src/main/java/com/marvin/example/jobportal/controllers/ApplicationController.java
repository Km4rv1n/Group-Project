package com.marvin.example.jobportal.controllers;

import com.marvin.example.jobportal.models.Application;
import com.marvin.example.jobportal.models.Job;
import com.marvin.example.jobportal.models.User;
import com.marvin.example.jobportal.services.ApplicationService;
import com.marvin.example.jobportal.services.JobService;
import com.marvin.example.jobportal.services.UserService;
import jakarta.annotation.Resource;
import jakarta.validation.Valid;
import org.springframework.core.io.FileSystemResource;
import org.springframework.core.io.PathResource;
import org.springframework.core.io.UrlResource;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.io.IOException;
import java.io.InputStream;
import java.net.MalformedURLException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.security.Principal;
import java.util.UUID;

@Controller
@RequestMapping("/applications")
public class ApplicationController {
    private final ApplicationService applicationService;
    private final UserService userService;
    private final JobService jobService;

    public ApplicationController(ApplicationService applicationService, UserService userService, JobService jobService) {
        this.applicationService = applicationService;
        this.userService = userService;
        this.jobService = jobService;
    }

    @PreAuthorize("hasRole('ROLE_APPLICANT')")
    @PostMapping("/new/{jobId}")
    public String newApplication(@Valid @ModelAttribute Application application, BindingResult bindingResult,
                                 @RequestParam(name = "cv") MultipartFile cv,
                                 @PathVariable Integer jobId, Model model, Principal principal, RedirectAttributes redirectAttributes) throws IOException {
        Job job = jobService.getJobById(jobId);
        User currentUser = userService.findByUsername(principal.getName());
        //TODO: maybe check sth idk
        if (bindingResult.hasErrors()) {
            model.addAttribute("job", job);
            model.addAttribute("currentUser", currentUser);
            return "viewJob";
        }

        applicationService.saveApplication(application, currentUser, job, cv);
        redirectAttributes.addFlashAttribute("message", "Your application was submitted successfully!");
        return "redirect:/jobs/view/"+jobId;
    }

    @PreAuthorize("hasRole('ROLE_RECRUITER')")
    @GetMapping("/view/{id}")
    public String viewApplication(@PathVariable Integer id, Model model, Principal principal) {
        Application application = applicationService.findApplicationById(id);
        model.addAttribute("application", application);
        model.addAttribute("currentUser", userService.findByUsername(principal.getName()));
        return "viewApplication";
    }

    @PreAuthorize("hasRole('ROLE_RECRUITER')")
    @PutMapping("/accept/{id}")
    public String acceptApplication(@PathVariable Integer id) {
        Application application = applicationService.findApplicationById(id);
        applicationService.accept(application);
        return "redirect:/applications/view/" + id;
    }

    @PreAuthorize("hasRole('ROLE_RECRUITER')")
    @PutMapping("/reject/{id}")
    public String rejectApplication(@PathVariable Integer id) {
        Application application = applicationService.findApplicationById(id);
        applicationService.reject(application);
        return "redirect:/applications/view/" + id;
    }

    @PreAuthorize("hasRole('ROLE_APPLICANT')")
    @GetMapping("/{userId}/{pageNumber}")
    public String showUserApplications(@PathVariable Integer userId, @PathVariable int pageNumber, Pageable pageable, Model model, Principal principal) {
        User currentUser = userService.findByUsername(principal.getName());
        Page<Application> applications = applicationService.findApplicationsByApplicant(currentUser, pageNumber-1);

        model.addAttribute("currentUser", currentUser);
        model.addAttribute("applications", applications);
        model.addAttribute("totalPages", applications.getTotalPages());
        return "myApplications";
    }
}

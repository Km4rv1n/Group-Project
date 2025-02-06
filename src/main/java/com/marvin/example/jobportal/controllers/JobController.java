package com.marvin.example.jobportal.controllers;

import com.marvin.example.jobportal.enums.ExperienceLevel;
import com.marvin.example.jobportal.enums.Location;
import com.marvin.example.jobportal.models.Application;
import com.marvin.example.jobportal.models.Category;
import com.marvin.example.jobportal.models.Job;
import com.marvin.example.jobportal.models.User;
import com.marvin.example.jobportal.services.ApplicationService;
import com.marvin.example.jobportal.services.JobCategoryService;
import com.marvin.example.jobportal.services.JobService;
import com.marvin.example.jobportal.services.UserService;
import jakarta.validation.Valid;
import org.springframework.data.domain.Page;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.security.Principal;
import java.util.List;

@Controller
@RequestMapping("/jobs")
public class JobController {

    private final UserService userService;
    private final JobService jobService;
    private final JobCategoryService jobCategoryService;
    private final ApplicationService applicationService;

    public JobController(UserService userService, JobService jobService, JobCategoryService jobCategoryService, ApplicationService applicationService) {
        this.userService = userService;
        this.jobService = jobService;
        this.jobCategoryService = jobCategoryService;
        this.applicationService = applicationService;
    }

    @PreAuthorize("hasRole('ROLE_RECRUITER')")
    @GetMapping("/new")
    public String showNewJobForm(Model model, Principal principal) {
        model.addAttribute("job", new Job());
        model.addAttribute("currentUser", userService.findByUsername(principal.getName()));
        model.addAttribute("categories", jobCategoryService.findAll());
        return "newJob";
    }

    @PreAuthorize("hasRole('ROLE_RECRUITER')")
    @PostMapping("/new")
    public String addNewJob(@Valid @ModelAttribute("job") Job job, BindingResult bindingResult, Model model, Principal principal, RedirectAttributes redirectAttributes) {
        User currentUser = userService.findByUsername(principal.getName());

        if (bindingResult.hasErrors()) {
            model.addAttribute("currentUser", currentUser);
            model.addAttribute("categories", jobCategoryService.findAll());
            return "newJob";
        }

        Category category = jobCategoryService.findByNameOrCreate(job.getCategory().getName());
        job.setCategory(category);
        job.setCreatedBy(currentUser);
        jobService.addJob(job);
        redirectAttributes.addFlashAttribute("message", "Job added successfully!");
        return "redirect:/recruiter/dashboard/1";
    }

    @PreAuthorize("hasRole('ROLE_RECRUITER')")
    @DeleteMapping("/{id}")
    public String deleteJob(@PathVariable Integer id, RedirectAttributes redirectAttributes) {
        jobService.deleteJobById(id);
        redirectAttributes.addFlashAttribute("message", "Job deleted successfully!");
        return "redirect:/recruiter/dashboard/1";
    }

    @PreAuthorize("hasRole('ROLE_RECRUITER')")
    @GetMapping("/{id}")
    public String showEditJobForm(@PathVariable Integer id, Model model, Principal principal) {
        Job job = jobService.getJobById(id);
        model.addAttribute("job", job);
        model.addAttribute("currentUser", userService.findByUsername(principal.getName()));
        model.addAttribute("categories", jobCategoryService.findAll());
        return "editJob";
    }

    @PreAuthorize("hasRole('ROLE_RECRUITER')")
    @PutMapping("/{id}")
    public String updateJob(@Valid @ModelAttribute("job") Job job,BindingResult bindingResult,@PathVariable Integer id, Model model, Principal principal, RedirectAttributes redirectAttributes) {
        Job existingJob = jobService.getJobById(id);

        User currentUser = userService.findByUsername(principal.getName());
        model.addAttribute("currentUser", currentUser);

        if(bindingResult.hasErrors()) {
            model.addAttribute("currentUser", currentUser);
            model.addAttribute("categories", jobCategoryService.findAll());
            return "editJob";
        }

        Category category = jobCategoryService.findByNameOrCreate(job.getCategory().getName());
        job.setCategory(category);
        job.setCreatedBy(currentUser);
        job.setApplications(existingJob.getApplications());
        jobService.addJob(job);
        redirectAttributes.addFlashAttribute("message", "Job updated successfully!");
        return "redirect:/jobs/" + id;
    }

    @PreAuthorize("hasRole('ROLE_APPLICANT')")
    @PostMapping("/save/{id}")
    public String addToSavedJobs(@PathVariable Integer id, Principal principal, RedirectAttributes redirectAttributes) {
        User currentUser = userService.findByUsername(principal.getName());
        Job job = jobService.getJobById(id);

        jobService.addToSavedJobs(currentUser, job);
        redirectAttributes.addFlashAttribute("message", "Your list of saved jobs has been updated successfully!");
        return "redirect:/applicant/dashboard/1";
    }

    @PreAuthorize("hasRole('ROLE_APPLICANT')")
    @GetMapping("/saved/{pageNumber}")
    public String showSavedJobs(Model model, Principal principal, @PathVariable Integer pageNumber) {
        User currentUser = userService.findByUsername(principal.getName());
        Page<Job> savedJobs = jobService.userSavedJobsPerPage(currentUser, pageNumber - 1);

        model.addAttribute("currentUser",currentUser);
        model.addAttribute("savedJobs", savedJobs);
        model.addAttribute("totalPages", savedJobs.getTotalPages());
        return "savedJobs";
    }

    @PreAuthorize("hasRole('ROLE_APPLICANT')")
    @DeleteMapping("/unsave/{id}")
    public String unsaveJob(@PathVariable Integer id, RedirectAttributes redirectAttributes, Model model, Principal principal) {
        User currentUser = userService.findByUsername(principal.getName());
        Job job = jobService.getJobById(id);

        jobService.removeFromSavedJobs(currentUser, job);
        redirectAttributes.addFlashAttribute("message", "Job removed successfully!");
        return "redirect:/jobs/saved/1";
    }

    @PreAuthorize("hasRole('ROLE_APPLICANT')")
    @GetMapping("/view/{id}")
    public String viewJob(@PathVariable Integer id, Model model, Principal principal) {
        User currentUser = userService.findByUsername(principal.getName());
        Job job = jobService.getJobById(id);
        boolean hasApplied = applicationService.existsApplication(currentUser, job);

        model.addAttribute("hasApplied", hasApplied);
        model.addAttribute("currentUser", currentUser);
        model.addAttribute("job", job);
        model.addAttribute("application", new Application());
        return "viewJob";
    }

    @PreAuthorize("hasRole('ROLE_APPLICANT')")
    @GetMapping("/search/{pageNumber}")
    public String searchJobs(Principal principal, Model model, @PathVariable int pageNumber,
                             @RequestParam(name = "title",required = false) String title,
                             @RequestParam(name = "category", required = false) String category,
                             @RequestParam(name = "experience", required = false) ExperienceLevel experience,
                             @RequestParam(name = "location", required = false) Location location,
                             @RequestParam(name = "salary", required = false) Long salary) {
        //TODO: check if required false is really necessary
        Page<Job> jobs = jobService.searchJobs(title, category, experience, location, salary, pageNumber-1);

        model.addAttribute("currentUser", userService.findByUsername(principal.getName()));
        model.addAttribute("jobs", jobs);
        model.addAttribute("totalPages", jobs.getTotalPages());

        return "searchJobs";
    }
}

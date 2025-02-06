package com.marvin.example.jobportal.services;

import com.marvin.example.jobportal.enums.ExperienceLevel;
import com.marvin.example.jobportal.enums.Location;
import com.marvin.example.jobportal.models.Job;
import com.marvin.example.jobportal.models.User;
import com.marvin.example.jobportal.repositories.JobRepository;
import com.marvin.example.jobportal.repositories.UserRepository;
import jakarta.transaction.Transactional;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
@Transactional
public class JobService {

    private final JobRepository jobRepository;
    private final UserRepository userRepository;

    public JobService(JobRepository jobRepository, UserRepository userRepository) {
        this.jobRepository = jobRepository;
        this.userRepository = userRepository;
    }

    /**
     * persist or merge the given job object into the database
     * @param job
     */
    public void addJob(Job job) {
        jobRepository.save(job);
    }

    /**
     *
     * @param creator
     * @param pageNumber
     * @return a page object of the jobs created by the given user
     */
    public Page<Job> jobsPerPageByCreator(User creator, int pageNumber) {
        PageRequest pageRequest = PageRequest.of(pageNumber, 6, Sort.Direction.DESC, "createdAt");
        return jobRepository.getJobsByCreatedBy(creator, pageRequest);
    }

    /**
     *
     * @param pageNumber
     * @return a page object of all existing jobs
     */
    public Page<Job> allJobsPerPage(int pageNumber) {
        PageRequest pageRequest = PageRequest.of(pageNumber, 6, Sort.Direction.DESC, "createdAt");
        return jobRepository.findAll(pageRequest);
    }

    /**
     * remove the job associated with the given id from the database
     * @param id
     */
    public void deleteJobById(Integer id) {
        Job job = jobRepository.findJobById(id).orElseThrow(() -> new RuntimeException("Job not found"));
        List<User> usersWithSavedJob = userRepository.findUsersWithSavedJob(job);
        for (User user : usersWithSavedJob) {
            user.getSavedJobs().removeIf(currentJob -> currentJob.equals(job));
            userRepository.save(user); // Save user after modification
        }

        jobRepository.deleteJobById(id);
    }

    /**
     *
     * @param id
     * @return the job associated with the given id, or throw a JobNotFoundException if there's no job with that id
     */
    public Job getJobById(Integer id) {
        return jobRepository.findJobById(id).orElseThrow(()-> new RuntimeException("Job not found"));
    }

    /**
     * add the given job to the current user's list of saved jobs
     * @param currentUser
     * @param job
     */
    public void addToSavedJobs(User currentUser, Job job) {
        currentUser.getSavedJobs().add(job);
        userRepository.save(currentUser);
    }

    public Page<Job> userSavedJobsPerPage(User currentUser, int pageNumber) {
        List<Integer> savedJobIds = currentUser.getSavedJobs().stream().map(Job::getId).toList();
        PageRequest pageRequest = PageRequest.of(pageNumber, 6, Sort.Direction.DESC, "createdAt");
        return jobRepository.findByIdIn(savedJobIds, pageRequest);
    }

    public void removeFromSavedJobs(User currentUser, Job job) {
        currentUser.getSavedJobs().remove(job);
        userRepository.save(currentUser);
    }

    public Page<Job> searchJobs(String title, String category, ExperienceLevel experience, Location location, Long salary, int pageNumber) {
        PageRequest pageRequest = PageRequest.of(pageNumber, 6, Sort.Direction.DESC, "createdAt");
        return jobRepository.searchJobs(title, category, experience, location, salary, pageRequest);
    }


}

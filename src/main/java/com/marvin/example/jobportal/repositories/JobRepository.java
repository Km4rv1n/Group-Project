package com.marvin.example.jobportal.repositories;

import com.marvin.example.jobportal.enums.ExperienceLevel;
import com.marvin.example.jobportal.enums.Location;
import com.marvin.example.jobportal.models.Job;
import com.marvin.example.jobportal.models.User;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface JobRepository extends PagingAndSortingRepository<Job, Integer> {
    void save(Job job);

    Page<Job> getJobsByCreatedBy(User createdBy, Pageable pageable);

    void deleteJobById(Integer id);

    Optional<Job> findJobById(Integer id);

    Page<Job> findAll(Pageable pageable);

    Page<Job> findByIdIn(List<Integer> jobIds, Pageable pageable);

    @Query("""
                SELECT j FROM Job j
                WHERE (:title IS NULL OR j.title LIKE %:title%)
                AND (:category IS NULL OR j.category.name LIKE %:category%)
                AND (:experience IS NULL OR j.experienceLevel = :experience)
                AND (:location IS NULL OR j.location = :location)
                AND (:salary IS NULL OR j.salary >= :salary)
            """)
    Page<Job> searchJobs(String title, String category, ExperienceLevel experience, Location location, Long salary, Pageable pageable);
}

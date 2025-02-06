package com.marvin.example.jobportal.repositories;

import com.marvin.example.jobportal.models.Application;
import com.marvin.example.jobportal.models.Job;
import com.marvin.example.jobportal.models.User;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.repository.PagingAndSortingRepository;
import org.springframework.stereotype.Repository;
import java.util.Optional;


@Repository
public interface ApplicationRepository extends PagingAndSortingRepository<Application, Integer> {
    boolean existsByApplicantAndJob(User applicant, Job job);

    void save(Application application);

    Optional<Application> findById(Integer id);

    Page<Application> findByApplicant(User applicant, Pageable pageable);
}

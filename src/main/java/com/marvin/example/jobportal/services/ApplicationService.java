package com.marvin.example.jobportal.services;

import com.marvin.example.jobportal.enums.ApplicationStatus;
import com.marvin.example.jobportal.models.Application;
import com.marvin.example.jobportal.models.Job;
import com.marvin.example.jobportal.models.User;
import com.marvin.example.jobportal.repositories.ApplicationRepository;
import jakarta.transaction.Transactional;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.UUID;

@Service
@Transactional
public class ApplicationService {
    private final ApplicationRepository applicationRepository;

    public ApplicationService(ApplicationRepository applicationRepository) {
        this.applicationRepository = applicationRepository;
    }

    /**
     * sets the applicant, job and handles cv upload for the given application and persists it in the database
     * @param application
     * @param user
     * @param job
     */
    public void saveApplication(Application application, User user, Job job, MultipartFile cv) throws IOException {
        if (cv != null && !cv.isEmpty()) {
            String fileName = StringUtils.cleanPath(cv.getOriginalFilename());
            if (fileName != null) {
                String fileExtension = StringUtils.getFilenameExtension(fileName);
                String uniqueFileName = UUID.randomUUID().toString() + "." + fileExtension;

                String documentUrl = "/uploads/cv/" + uniqueFileName;
                application.setCvUrl(documentUrl);

                String uploadDir = "./uploads/cv/";
                Path uploadPath = Paths.get(uploadDir);
                if (!Files.exists(uploadPath)) {
                    Files.createDirectories(uploadPath);
                }

                try (InputStream inputStream = cv.getInputStream()) {
                    // construct file path
                    Path filePath = uploadPath.resolve(uniqueFileName);
                    Files.copy(inputStream, filePath, StandardCopyOption.REPLACE_EXISTING);
                } catch (IOException e) {
                    throw new IOException("Could not save uploaded file: " + fileName);
                }
            }
        }
        application.setApplicant(user);
        application.setJob(job);
        applicationRepository.save(application);
    }

    /**
     *
     * @param id
     * @return the application object associated with the given id, or throw an exception if it is not found
     */
    public Application findApplicationById(Integer id) {
        return applicationRepository.findById(id).orElseThrow(() -> new RuntimeException("Could not find application with id: " + id));
    }

    /**
     * set the status of the application as accepted, and decrement the number of available vacancies
     * @param application
     */
    public void accept(Application application) {
        application.setStatus(ApplicationStatus.ACCEPTED);
        application.getJob().setVacancies(application.getJob().getVacancies() - 1);
        applicationRepository.save(application);
    }

    /**
     * set the status of the application as rejected
     * @param application
     */
    public void reject(Application application) {
        application.setStatus(ApplicationStatus.REJECTED);
        applicationRepository.save(application);
    }

    /**
     *
     * @param user
     * @param job
     * @return true if an application exists for the given user and job, false otherwise
     */
    public boolean existsApplication(User user, Job job) {
        return applicationRepository.existsByApplicantAndJob(user, job);
    }

    /**
     *
     * @param user
     * @param pageNumber
     * @return a page object containing the applications of the given user
     */
    public Page<Application> findApplicationsByApplicant(User user, int pageNumber) {
        PageRequest pageRequest = PageRequest.of(pageNumber, 6, Sort.Direction.DESC, "applicationDate");
        return applicationRepository.findByApplicant(user, pageRequest);
    }
}

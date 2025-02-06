package com.marvin.example.jobportal.repositories;

import com.marvin.example.jobportal.models.Job;
import com.marvin.example.jobportal.models.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;
import java.util.Optional;

public interface UserRepository extends JpaRepository<User, Integer> {
    Optional<User> findByEmail(String email);

    @Query("SELECT u FROM User u JOIN u.savedJobs sj WHERE sj = :job")
    List<User> findUsersWithSavedJob(@Param("job") Job job);
}

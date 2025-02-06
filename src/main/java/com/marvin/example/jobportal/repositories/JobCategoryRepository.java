package com.marvin.example.jobportal.repositories;

import com.marvin.example.jobportal.models.Category;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface JobCategoryRepository extends JpaRepository<Category, Integer> {
    Optional<Category> findByName(String name);
}

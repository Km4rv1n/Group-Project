package com.marvin.example.jobportal.services;

import com.marvin.example.jobportal.models.Category;
import com.marvin.example.jobportal.repositories.JobCategoryRepository;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class JobCategoryService {
    private final JobCategoryRepository jobCategoryRepository;

    public JobCategoryService(JobCategoryRepository jobCategoryRepository) {
        this.jobCategoryRepository = jobCategoryRepository;
    }

    /**
     *
     * @return a list of all existing categories
     */
    public List<Category> findAll() {
        return jobCategoryRepository.findAll();
    }

    /**
     * searches the database for the category associated with the given name. if it does not exist, a new category is created
     * @param name
     * @return the existing/created category
     */
    public Category findByNameOrCreate(String name) {
        Optional<Category> category = jobCategoryRepository.findByName(name);
        if (category.isPresent()) {
            return category.get();
        }
            Category newCategory = new Category();
            newCategory.setName(name);
            jobCategoryRepository.save(newCategory);
            return newCategory;

    }
}

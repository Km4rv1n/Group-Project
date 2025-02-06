package com.marvin.example.jobportal.services;

import com.marvin.example.jobportal.enums.Role;
import com.marvin.example.jobportal.exceptions.UserNotFoundException;
import com.marvin.example.jobportal.models.User;
import com.marvin.example.jobportal.repositories.UserRepository;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

@Service
public class UserService {
    private UserRepository userRepository;
    private BCryptPasswordEncoder bCryptPasswordEncoder;

    public UserService(UserRepository userRepository, BCryptPasswordEncoder bCryptPasswordEncoder) {
        this.userRepository = userRepository;
        this.bCryptPasswordEncoder = bCryptPasswordEncoder;
    }

    /**
     * Adds a new user.
     *
     * @param user the User to be added. User must not contain a non-null password.
     *
     */
    public void addUser(User user) {
        user.setPassword(bCryptPasswordEncoder.encode(user.getPassword()));
        userRepository.save(user);
    }

    public void saveUser(User user) {
        userRepository.save(user);
    }

    /**
     * Retrieve a user based on its email
     *
     * @param email the email of the user to retrieve
     * @return the User entity associated with the given email, or null if no user with the specified email exists
     */
    public User findByUsername(String email) {
        return userRepository.findByEmail(email).orElseThrow( () -> new UserNotFoundException("User not found"));
    }

    public User findById(Integer id) {
        return userRepository.findById(id).orElseThrow( () -> new UserNotFoundException("User not found"));
    }
}
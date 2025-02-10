package com.marvin.example.jobportal.models;

import com.marvin.example.jobportal.enums.Role;
import jakarta.persistence.*;
import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Pattern;
import jakarta.validation.constraints.Size;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import java.time.LocalDate;
import java.util.Set;

@Entity
@Table(name = "users")
@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
public class User {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @NotBlank
    @Size(min = 3, max = 50)
    private String firstName;

    @NotBlank
    @Size(min = 3, max = 50)
    private String lastName;

    @NotBlank
    @Email
    private String email;

    @NotBlank
    @Size(min=8, max = 250)
    private String password;

    @Pattern(regexp = "^\\+355(6[7-9])\\d{7}$", message = "Invalid phone number format")
    private String phone;

    @Transient
    private String passwordConfirmation;

    @Enumerated(EnumType.STRING)
    private Role role;

    private LocalDate dateJoined;

    private String profilePictureUrl = "/images/default-avatar-profile-icon.jpg";

    @OneToMany(mappedBy = "createdBy", cascade = CascadeType.ALL, orphanRemoval = true)
    private Set<Job> jobs;

    @OneToMany(mappedBy = "applicant", cascade = CascadeType.ALL, orphanRemoval = true)
    private Set<Application> applications;

    @ManyToMany()
    @JoinTable(
            name = "user_saved_jobs",
            joinColumns = @JoinColumn(name = "user_id"),
            inverseJoinColumns = @JoinColumn(name = "job_id")
    )
    private Set<Job> savedJobs;

    @PrePersist
    public void onCreate() {
        this.dateJoined = LocalDate.now();
    }
}
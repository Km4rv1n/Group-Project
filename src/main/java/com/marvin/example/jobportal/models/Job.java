package com.marvin.example.jobportal.models;

import com.marvin.example.jobportal.enums.ExperienceLevel;
import com.marvin.example.jobportal.enums.Location;
import jakarta.persistence.*;
import jakarta.validation.Valid;
import jakarta.validation.constraints.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import java.time.LocalDate;
import java.util.List;

@Entity
@Table(name = "jobs")
@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
public class Job {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @NotBlank
    @Size(min = 5, max = 50)
    private String title;

    @NotNull
    @Min(1)
    @Max(50)
    private Integer vacancies;

    @NotBlank
    @Size(min = 10, max = 250)
    private String description;

    @Enumerated(EnumType.STRING)
    private Location location;

    @Enumerated(EnumType.STRING)
    private ExperienceLevel experienceLevel;

    @NotNull
    @Min(30000)
    private Long salary;

    private LocalDate createdAt;

    @ManyToOne
    @JoinColumn(name = "creator_id")
    private User createdBy;

    @Valid
    @ManyToOne
    @JoinColumn(name = "category_id")
    private Category category;

    @OneToMany(mappedBy = "job",cascade = CascadeType.ALL, orphanRemoval = true)
    private List<Application> applications;

    @PrePersist
    public void onCreate() {
        this.createdAt = LocalDate.now();
    }
}

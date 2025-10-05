package com.example.entity;

import com.fasterxml.jackson.annotation.JsonBackReference;
import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonInclude.Include;

import javax.persistence.*;
import java.time.LocalDateTime;

@Entity
@JsonInclude(Include.NON_NULL)
@Table(name = "Progress")
public class Progress {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long progressId;

    private String moduleId;
    private Double completedPercent;
    private LocalDateTime lastAccessedAt;


    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "enrollment_id", nullable = false)
    @JsonBackReference
    private Enrollment enrollment;

    // Getters and Setters
    public Long getProgressId() {
        return progressId;
    }
    public void setProgressId(Long progressId) {
        this.progressId = progressId;
    }
    public String getModuleId() {
        return moduleId;
    }
    public void setModuleId(String moduleId) {
        this.moduleId = moduleId;
    }
    public Double getCompletedPercent() {
        return completedPercent;
    }
    public void setCompletedPercent(Double completedPercent) {
        this.completedPercent = completedPercent;
    }
    public LocalDateTime getLastAccessedAt() {
        return lastAccessedAt;
    }
    public void setLastAccessedAt(LocalDateTime lastAccessedAt) {
        this.lastAccessedAt = lastAccessedAt;
    }

    public Enrollment getEnrollment() {
        return enrollment;
    }
    public void setEnrollment(Enrollment enrollment) {
        this.enrollment = enrollment;
    }
}

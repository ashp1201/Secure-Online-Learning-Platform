package com.example.dto;

import java.time.LocalDateTime;

public class ProgressDto {
    private Long progressId;
    private String moduleId;
    private Double completedPercent;
    private LocalDateTime lastAccessedAt;
    private String notes;
    private Long enrollmentId;

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

    public String getNotes() {
        return notes;
    }

    public void setNotes(String notes) {
        this.notes = notes;
    }

    public Long getEnrollmentId() {
        return enrollmentId;
    }

    public void setEnrollmentId(Long enrollmentId) {
        this.enrollmentId = enrollmentId;
    }
}
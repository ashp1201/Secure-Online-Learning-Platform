package com.example.dto;

import java.time.LocalDateTime;

public class CourseDto {
	private Long courseId;
    private String title;
    private String description;
    private String category;
    private String difficulty;
    private String contentPath;
    private LocalDateTime createdAt;
    private Long instructorId;
    private String instructorName;
    private Integer enrollmentCount; // for dashboard stats

    // Getters and setters
    public Long getCourseId() { return courseId; }
    public void setCourseId(Long id) { this.courseId = id; }
    public String getTitle() { return title; }
    public LocalDateTime getCreatedAt() {
		return createdAt;
	}
	public void setCreatedAt(LocalDateTime createdAt) {
		this.createdAt = createdAt;
	}
	public String getInstructorName() {
		return instructorName;
	}
	public void setInstructorName(String instructorName) {
		this.instructorName = instructorName;
	}
	public void setTitle(String t) { this.title = t; }
    public String getDescription() { return description; }
    public void setDescription(String d) { this.description = d; }
    public String getCategory() { return category; }
    public void setCategory(String c) { this.category = c; }
    public String getDifficulty() { return difficulty; }
    public void setDifficulty(String d) { this.difficulty = d; }
    public String getContentPath() { return contentPath; }
    public void setContentPath(String cp) { this.contentPath = cp; }
    public Long getInstructorId() { return instructorId; }
    public void setInstructorId(Long iid) { this.instructorId = iid; }
    public Integer getEnrollmentCount() { return enrollmentCount; }
    public void setEnrollmentCount(Integer e) { this.enrollmentCount = e; }
}
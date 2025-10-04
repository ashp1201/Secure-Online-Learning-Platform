package com.example.dto;

import javax.validation.Valid;
import javax.validation.constraints.Email;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.Pattern;

public class UserDto {

    private Long userId;

    @NotBlank(message = "Full name is required")
    private String fullName;

    
    @Email(message = "Provide a valid email address")
    @NotBlank(message = "Email is required")
    private String email;

    @NotBlank(message = "Password is required")
    @Pattern(
        regexp = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[@#$%^&+=!?.]).{8,}$",
        message = "Min 8 characters, must contain uppercase, lowercase, number, and special character"
    )
    private String password;

    @NotBlank(message = "Role is required")
    private String role; // INSTRUCTOR or STUDENT
    

    @Valid
    private InstructorDto instructor;

    @Valid
    private StudentDto student;

    // Getters and setters
    public Long getUserId() { return userId; }
    public void setUserId(Long userId) { this.userId = userId; }

    public String getFullName() { return fullName; }
    public void setFullName(String fullName) { this.fullName = fullName; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }

    public String getRole() { return role; }
    public void setRole(String role) { this.role = role; }
    

    public InstructorDto getInstructor() { return instructor; }
    public void setInstructor(InstructorDto instructor) { this.instructor = instructor; }

    public StudentDto getStudent() { return student; }
    public void setStudent(StudentDto student) { this.student = student; }
}

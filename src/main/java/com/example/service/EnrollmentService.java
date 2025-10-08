package com.example.service;

import com.example.dto.EnrollmentDto;
import com.example.entity.Enrollment;

import java.util.List;

public interface EnrollmentService {
    EnrollmentDto enrollStudent(Long studentId, Long courseId);
    List<EnrollmentDto> getEnrollmentsByStudent(Long studentId);
    List<EnrollmentDto> getEnrollmentsByInstructor(Long instructorId);
    void withdrawEnrollment(Long enrollmentId, String studentEmail);  // ✅ Add this

    Enrollment findById(Long enrollmentId);
	boolean isStudentEnrolled(Long userId, Long courseId);
}
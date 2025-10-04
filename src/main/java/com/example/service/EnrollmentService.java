package com.example.service;

import com.example.dto.EnrollmentDto;
import com.example.entity.Enrollment;
import java.util.List;

public interface EnrollmentService {
    Enrollment enrollStudent(EnrollmentDto dto);
    List<Enrollment> getEnrollmentsByStudent(Long studentId);
}

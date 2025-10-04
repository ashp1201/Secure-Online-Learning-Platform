package com.example.dao;

import com.example.entity.Enrollment;
import java.util.List;

public interface EnrollmentDAO {
    void save(Enrollment enrollment);
    Enrollment findById(Long id);
    List<Enrollment> findByStudent(Long studentId);
}

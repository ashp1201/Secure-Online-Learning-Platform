package com.example.dao;

import com.example.entity.Enrollment;
import java.util.List;

public interface EnrollmentDAO {
    void save(Enrollment enrollment);
    void update(Enrollment enrollment);
    void delete(Long enrollmentId);  
    Enrollment findById(Long id);
    List<Enrollment> findByStudentId(Long studentId);
    List<Enrollment> findByCourseInstructorId(Long instructorId);
 // In EnrollmentDAO interface:
    Enrollment findByStudentAndCourse(Long studentId, Long courseId);
    
}
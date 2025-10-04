package com.example.service.impl;

import com.example.dao.EnrollmentDAO;
import com.example.dao.CourseDAO;
import com.example.dao.UserDAO;
import com.example.dto.EnrollmentDto;
import com.example.entity.Course;
import com.example.entity.Enrollment;
import com.example.entity.User;
import com.example.service.EnrollmentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.List;
import java.util.stream.Collectors;

@Service
public class EnrollmentServiceImpl implements EnrollmentService {

    @Autowired
    private EnrollmentDAO enrollmentDao;

    @Autowired
    private UserDAO userDAO;

    @Autowired
    private CourseDAO courseDao;

    @Override
    public EnrollmentDto enrollStudent(Long studentId, Long courseId) {
        User student = userDAO.findById(studentId);
        Course course = courseDao.findById(courseId);

        Enrollment enrollment = new Enrollment();
        enrollment.setStudent(student);
        enrollment.setCourse(course);
        enrollment.setEnrolledAt(LocalDateTime.now());
        enrollment.setStatus("ACTIVE");

        enrollmentDao.save(enrollment);

        return toDto(enrollment);
    }

    @Override
    public List<EnrollmentDto> getEnrollmentsByStudent(Long studentId) {
        return enrollmentDao.findByStudentId(studentId)
                .stream()
                .map(this::toDto)
                .collect(Collectors.toList());
    }

    @Override
    public List<EnrollmentDto> getEnrollmentsByInstructor(Long instructorId) {
        return enrollmentDao.findByCourseInstructorId(instructorId)
                .stream()
                .map(this::toDto)
                .collect(Collectors.toList());
    }

    private EnrollmentDto toDto(Enrollment enrollment) {
        EnrollmentDto dto = new EnrollmentDto();
        dto.setEnrollmentId(enrollment.getEnrollmentId());
        dto.setStudentId(enrollment.getStudent() != null ? enrollment.getStudent().getUserId() : null);
        dto.setCourseId(enrollment.getCourse() != null ? enrollment.getCourse().getCourseId() : null);
        dto.setEnrolledAt(enrollment.getEnrolledAt());
        dto.setStatus(enrollment.getStatus());

        if (enrollment.getStudent() != null) {
            dto.setStudentName(enrollment.getStudent().getUsername());
        }

        if (enrollment.getCourse() != null) {
            dto.setCourseTitle(enrollment.getCourse().getTitle());
        }

        // Optionally add progress computation here

        return dto;
    }
    
    @Override
    public Enrollment findById(Long enrollmentId) {
        return enrollmentDao.findById(enrollmentId);
    }

}

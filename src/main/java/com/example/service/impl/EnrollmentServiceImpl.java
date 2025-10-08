package com.example.service.impl;

import com.example.dao.EnrollmentDAO;
import com.example.dao.CourseDAO;
import com.example.dao.UserDAO;
import com.example.dto.EnrollmentDto;
import com.example.entity.Course;
import com.example.entity.Enrollment;
import com.example.entity.User;
import com.example.service.EnrollmentService;
import com.example.service.ProgressService;
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

    @Autowired
    private ProgressService progressService;

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

        // Fetch again, but now fully fetched with JOIN FETCH inside DAO
        Enrollment loaded = enrollmentDao.findById(enrollment.getEnrollmentId());
        return toDto(loaded);
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
            dto.setStudentName(enrollment.getStudent().getFullName());
        }

        if (enrollment.getCourse() != null) {
            Course course = enrollment.getCourse();
            dto.setCourseTitle(course.getTitle());
            dto.setCategory(course.getCategory());
            dto.setDifficulty(course.getDifficulty());
            dto.setDescription(course.getDescription());
            dto.setContentPath(course.getContentPath());
            
            if (course.getInstructor() != null) {
                dto.setInstructorName(course.getInstructor().getFullName());
            }
        }

        // Calculate overall progress for this enrollment
        Double overallProgress = progressService.calculateOverallProgress(enrollment.getEnrollmentId());
        dto.setProgressPercentage(overallProgress);

        return dto;
    }

    
    @Override
    public Enrollment findById(Long enrollmentId) {
        return enrollmentDao.findById(enrollmentId);
    }
    
    @Override
    public boolean isStudentEnrolled(Long userId, Long courseId) {
        // Query the enrollment DAO for active enrollment by student and course
        Enrollment enrollment = enrollmentDao.findByStudentAndCourse(userId, courseId);
        return enrollment != null && "ACTIVE".equalsIgnoreCase(enrollment.getStatus());
    }

    
    @Override
    public void withdrawEnrollment(Long enrollmentId, String studentEmail) {
        // Find the enrollment
        Enrollment enrollment = enrollmentDao.findById(enrollmentId);
        
        if (enrollment == null) {
            throw new RuntimeException("Enrollment not found");
        }

        // Verify ownership - only the enrolled student can withdraw
        if (!enrollment.getStudent().getEmail().equals(studentEmail)) {
            throw new RuntimeException("You are not authorized to withdraw this enrollment");
        }

        // Delete the enrollment
        enrollmentDao.delete(enrollmentId);
    }


}
package com.example.controller;

import com.example.dto.EnrollmentDto;
import com.example.entity.User;
import com.example.service.EnrollmentService;
import com.example.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;

import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/enrollments")
public class EnrollmentController {

    @Autowired
    private EnrollmentService enrollmentService;

    @Autowired
    private UserService userService;

    // Student enrolls in a course
    @PostMapping("/enroll")
    public ResponseEntity<EnrollmentDto> enroll(@RequestBody EnrollmentDto dto, Authentication authentication) {
        User student = userService.findByEmail(authentication.getName());
        if (student == null) {
            return ResponseEntity.status(401).build();
        }
        EnrollmentDto enrollment = enrollmentService.enrollStudent(student.getUserId(), dto.getCourseId());
        return ResponseEntity.ok(enrollment);
    }

    // Student's own enrollments
    @GetMapping("/my-enrollments")
    public ResponseEntity<List<EnrollmentDto>> getMyEnrollments(Authentication authentication) {
        User student = userService.findByEmail(authentication.getName());
        if (student == null) {
            return ResponseEntity.status(401).build();
        }
        return ResponseEntity.ok(enrollmentService.getEnrollmentsByStudent(student.getUserId()));
    }

    // Instructor's student's enrollments
    @GetMapping("/instructor/students")
    public ResponseEntity<List<EnrollmentDto>> getEnrollmentsByInstructor(Authentication authentication) {
        User instructor = userService.findByEmail(authentication.getName());
        if (instructor == null) {
            return ResponseEntity.status(401).build();
        }
        return ResponseEntity.ok(enrollmentService.getEnrollmentsByInstructor(instructor.getUserId()));
    }
    
    @DeleteMapping("/{enrollmentId}")
    public ResponseEntity<?> withdrawEnrollment(
            @PathVariable Long enrollmentId, 
            Authentication authentication) {
        
        try {
            enrollmentService.withdrawEnrollment(enrollmentId, authentication.getName());
            return ResponseEntity.ok(Collections.singletonMap("message", "Successfully withdrawn from course"));
        } catch (RuntimeException e) {
            return ResponseEntity.status(403).body(Collections.singletonMap("error", e.getMessage()));
        }
    }

    }

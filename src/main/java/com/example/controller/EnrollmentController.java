//package com.example.controller;
//
//import com.example.dto.EnrollmentDto;
//import com.example.entity.Enrollment;
//import com.example.service.EnrollmentService;
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.http.ResponseEntity;
//import org.springframework.web.bind.annotation.*;
//
//import javax.validation.Valid;
//import java.util.List;
//
//@RestController
//@RequestMapping("/enrollments")
//public class EnrollmentController {
//
//    @Autowired
//    private EnrollmentService enrollmentService;
//
//    @PostMapping("/enroll")
//    public ResponseEntity<Enrollment> enrollStudent(@Valid @RequestBody EnrollmentDto dto) {
//        return ResponseEntity.ok(enrollmentService.enrollStudent(dto));
//    }
//
//    @GetMapping("/student/{id}")
//    public ResponseEntity<List<Enrollment>> getByStudent(@PathVariable Long id) {
//        return ResponseEntity.ok(enrollmentService.getEnrollmentsByStudent(id));
//    }
//}

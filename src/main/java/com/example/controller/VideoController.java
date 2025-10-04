package com.example.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.Resource;
import org.springframework.core.io.UrlResource;
import org.springframework.http.*;
import org.springframework.web.bind.annotation.*;

import com.example.entity.User;
import com.example.service.EnrollmentService;
import com.example.service.UserService;

import java.nio.file.Path;
import java.nio.file.Paths;

@RestController
@RequestMapping("/videos")
public class VideoController {

    @Autowired
    private EnrollmentService enrollmentService;
    @Autowired
    private UserService userService;

    @GetMapping("/{courseId}/{fileName:.+}")
    public ResponseEntity<Resource> streamVideo(@PathVariable Long courseId, @PathVariable String fileName, Authentication authentication) {
        User student = userService.findByEmail(authentication.getName());
        // Check if the student is enrolled in the course
        boolean isEnrolled = enrollmentService.isStudentEnrolled(student.getUserId(), courseId);
        if (!isEnrolled) {
            return ResponseEntity.status(HttpStatus.FORBIDDEN).build();
        }

        try {
            Path videoPath = Paths.get("C:/fakepath/.../")  // Construct actual video file path as per your storage logic
                                  .resolve(fileName);
            Resource videoResource = new UrlResource(videoPath.toUri());

            if (!videoResource.exists()) {
                return ResponseEntity.notFound().build();
            }

            return ResponseEntity.ok()
                .contentType(MediaTypeFactory.getMediaType(fileName).orElse(MediaType.APPLICATION_OCTET_STREAM))
                .body(videoResource);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        }
    }
}

package com.example.controller;

import com.example.dao.CourseDAO;
import com.example.entity.Course;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.Resource;
import org.springframework.core.io.UrlResource;
import org.springframework.http.*;
import org.springframework.web.bind.annotation.*;

import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.Files;

@RestController
@RequestMapping("/videos")
public class VideoController {

    @Autowired
    private CourseDAO courseDAO;

    @GetMapping("/{courseId}/{fileName:.+}")
    public ResponseEntity<Resource> streamVideo(
            @PathVariable Long courseId,
            @PathVariable String fileName) {

        try {
            // Get the course to retrieve the actual contentPath
            Course course = courseDAO.findById(courseId);
            if (course == null || course.getContentPath() == null) {
                return ResponseEntity.notFound().build();
            }

            // Use the full path from database
            Path videoPath = Paths.get(course.getContentPath());

            // Check if the file exists
            if (!Files.exists(videoPath) || !Files.isReadable(videoPath)) {
                System.out.println("Video file not found at: " + videoPath);
                return ResponseEntity.notFound().build();
            }

            Resource videoResource = new UrlResource(videoPath.toUri());

            // Set content type based on extension (.mp4 by default)
            MediaType contentType = MediaType.parseMediaType("video/mp4");
            // Optionally, detect other types based on 'fileName' if supporting more formats
            
            return ResponseEntity.ok()
                    .contentType(contentType)
                    .header(HttpHeaders.CONTENT_DISPOSITION, "inline; filename=\"" + fileName + "\"")
                    .body(videoResource);

        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        }
    }
}

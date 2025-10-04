package com.example.controller;

import com.example.dto.CourseDto;
import com.example.entity.User;
import com.example.service.CourseService;
import com.example.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/courses")
public class CourseController {

    @Autowired
    private CourseService courseService;

    @Autowired
    private UserService userService;

    @PostMapping("/create")
    public ResponseEntity<CourseDto> createCourse(@RequestBody CourseDto dto, Authentication authentication) {
        User user = userService.findByEmail(authentication.getName());
        return ResponseEntity.ok(courseService.createCourse(dto, user.getUserId()));
    }

    @GetMapping("/instructor/my-courses")
    public ResponseEntity<List<CourseDto>> getInstructorCourses(Authentication authentication) {
        User user = userService.findByEmail(authentication.getName());
        return ResponseEntity.ok(courseService.getCoursesByInstructor(user.getUserId()));
    }

    @GetMapping("/list")
    public ResponseEntity<List<CourseDto>> getAllCourses() {
        return ResponseEntity.ok(courseService.getAllCourses());
    }

    @DeleteMapping("/{courseId}")
    public ResponseEntity<?> deleteCourse(@PathVariable Long courseId) {
        courseService.deleteCourse(courseId);
        return ResponseEntity.ok().build();
    }
}

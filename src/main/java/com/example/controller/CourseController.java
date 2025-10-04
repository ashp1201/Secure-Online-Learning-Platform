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

    @PutMapping("/{courseId}")
    public ResponseEntity<CourseDto> updateCourse(@PathVariable Long courseId, @RequestBody CourseDto dto, Authentication authentication) {
        User user = userService.findByEmail(authentication.getName());
        CourseDto updatedCourse = courseService.updateCourse(dto, courseId, user.getUserId());
        if (updatedCourse == null) {
            return ResponseEntity.status(403).build(); // Forbidden - not owner
        }
        return ResponseEntity.ok(updatedCourse);
    }

    @GetMapping("/{courseId}")
    public ResponseEntity<CourseDto> getCourseById(@PathVariable Long courseId) {
        CourseDto course = courseService.getCourseById(courseId);
        if (course == null) {
            return ResponseEntity.notFound().build();
        }
        return ResponseEntity.ok(course);
    }

    @GetMapping("/category/{category}")
    public ResponseEntity<List<CourseDto>> getCoursesByCategory(@PathVariable String category) {
        return ResponseEntity.ok(courseService.getCoursesByCategory(category));
    }

    @GetMapping("/difficulty/{difficulty}")
    public ResponseEntity<List<CourseDto>> getCoursesByDifficulty(@PathVariable String difficulty) {
        return ResponseEntity.ok(courseService.getCoursesByDifficulty(difficulty));
    }

    @GetMapping("/filter")
    public ResponseEntity<List<CourseDto>> filterCourses(
            @RequestParam(required = false) String category,
            @RequestParam(required = false) String difficulty) {
        if (category != null && difficulty != null) {
            return ResponseEntity.ok(courseService.getCoursesByCategoryAndDifficulty(category, difficulty));
        } else if (category != null) {
            return ResponseEntity.ok(courseService.getCoursesByCategory(category));
        } else if (difficulty != null) {
            return ResponseEntity.ok(courseService.getCoursesByDifficulty(difficulty));
        } else {
            return ResponseEntity.ok(courseService.getAllCourses());
        }
    }

    @GetMapping("/search")
    public ResponseEntity<List<CourseDto>> searchCourses(@RequestParam String title) {
        return ResponseEntity.ok(courseService.searchCoursesByTitle(title));
    }

    @DeleteMapping("/{courseId}")
    public ResponseEntity<?> deleteCourse(@PathVariable Long courseId, Authentication authentication) {
        User user = userService.findByEmail(authentication.getName());
        CourseDto course = courseService.getCourseById(courseId);
        if (course == null) {
            return ResponseEntity.notFound().build();
        }
        if (!course.getInstructorId().equals(user.getUserId())) {
            return ResponseEntity.status(403).build(); // Forbidden - not owner
        }
        courseService.deleteCourse(courseId);
        return ResponseEntity.ok().build();
    }
}
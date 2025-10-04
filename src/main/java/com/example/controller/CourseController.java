//package com.example.controller;
//
//import com.example.dto.CourseDto;
//import com.example.entity.Course;
//import com.example.service.CourseService;
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.http.ResponseEntity;
//import org.springframework.web.bind.annotation.*;
//import org.springframework.web.multipart.MultipartFile;
//
//import java.util.List;
//
//@RestController
//@RequestMapping("/courses")
//public class CourseController {
//
//    @Autowired
//    private CourseService courseService;
//
//    @PostMapping("/create")
//    public ResponseEntity<Course> createCourse(@ModelAttribute CourseDto dto,
//                                               @RequestParam("file") MultipartFile file,
//                                               @RequestParam("instructorId") Long instructorId) {
//        return ResponseEntity.ok(courseService.createCourse(dto, file, instructorId));
//    }
//
//    @GetMapping
//    public ResponseEntity<List<Course>> getAllCourses() {
//        return ResponseEntity.ok(courseService.getAllCourses());
//    }
//
//    @GetMapping("/filter")
//    public ResponseEntity<List<Course>> filterCourses(@RequestParam(required = false) String category,
//                                                      @RequestParam(required = false) String difficulty) {
//        return ResponseEntity.ok(courseService.filterCourses(category, difficulty));
//    }
//}

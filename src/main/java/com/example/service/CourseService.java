package com.example.service;

import com.example.dto.CourseDto;
import com.example.entity.Course;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

public interface CourseService {
    Course createCourse(CourseDto courseDto, MultipartFile file, Long instructorId);
    List<Course> getAllCourses();
    List<Course> filterCourses(String category, String difficulty);
}

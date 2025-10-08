package com.example.service;

import com.example.dto.CourseDto;
import java.util.List;

public interface CourseService {
    CourseDto createCourse(CourseDto dto, Long instructorId);
    List<CourseDto> getCoursesByInstructor(Long instructorId);
    List<CourseDto> getAllCourses();
    CourseDto updateCourse(CourseDto dto, Long courseId, Long instructorId);
    CourseDto getCourseById(Long courseId);
    void deleteCourse(Long courseId);
    
    // New unified search method
    List<CourseDto> searchCourses(String category, String difficulty, String title);
}

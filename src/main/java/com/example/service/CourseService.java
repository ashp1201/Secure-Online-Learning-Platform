package com.example.service;

import com.example.dto.CourseDto;
import java.util.List;

public interface CourseService {
    CourseDto createCourse(CourseDto dto, Long instructorId);
    CourseDto updateCourse(CourseDto dto, Long courseId, Long instructorId);
    List<CourseDto> getCoursesByInstructor(Long instructorId);
    List<CourseDto> getAllCourses();
    List<CourseDto> getCoursesByCategory(String category);
    List<CourseDto> getCoursesByDifficulty(String difficulty);
    List<CourseDto> getCoursesByCategoryAndDifficulty(String category, String difficulty);
    List<CourseDto> searchCoursesByTitle(String title);
    CourseDto getCourseById(Long courseId);
    void deleteCourse(Long courseId);
}
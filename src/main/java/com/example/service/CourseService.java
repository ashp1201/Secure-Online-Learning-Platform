package com.example.service;

import com.example.dto.CourseDto;
import java.util.List;

public interface CourseService {
    CourseDto createCourse(CourseDto dto, Long instructorId);
    List<CourseDto> getCoursesByInstructor(Long instructorId);
    List<CourseDto> getAllCourses();
    void deleteCourse(Long courseId);
}

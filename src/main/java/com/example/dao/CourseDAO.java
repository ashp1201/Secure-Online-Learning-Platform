package com.example.dao;

import com.example.entity.Course;
import java.util.List;

public interface CourseDAO {
    void save(Course course);
    void update(Course course);
    void delete(Long courseId);
    Course findById(Long id);
    List<Course> findAll();
    List<Course> findByInstructorId(Long instructorId);
}

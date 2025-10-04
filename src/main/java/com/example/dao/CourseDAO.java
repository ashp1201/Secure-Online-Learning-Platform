package com.example.dao;

import com.example.entity.Course;
import java.util.List;

public interface CourseDAO {
    void save(Course course);
    Course findById(Long id);
    List<Course> findAll();
    List<Course> filterByCategoryAndDifficulty(String category, String difficulty);
}

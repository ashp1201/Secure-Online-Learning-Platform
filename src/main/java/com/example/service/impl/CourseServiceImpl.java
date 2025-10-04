package com.example.service.impl;

import com.example.dao.CourseDAO;
import com.example.dao.UserDAO;
import com.example.dto.CourseDto;
import com.example.entity.Course;
import com.example.entity.User;
import com.example.service.CourseService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.List;
import java.util.stream.Collectors;

@Service
public class CourseServiceImpl implements CourseService {
    @Autowired
    private CourseDAO courseDao;

    @Autowired
    private UserDAO userDAO;

    @Override
    public CourseDto createCourse(CourseDto dto, Long instructorId) {
        User instructor = userDAO.findById(instructorId);

        Course course = new Course();
        course.setTitle(dto.getTitle());
        course.setDescription(dto.getDescription());
        course.setCategory(dto.getCategory());
        course.setDifficulty(dto.getDifficulty());
        course.setContentPath(dto.getContentPath());
        course.setInstructor(instructor);
        course.setCreatedAt(LocalDateTime.now()); // Set createdAt WHEN SAVING

        courseDao.save(course);

        dto.setCourseId(course.getCourseId());
        dto.setCreatedAt(course.getCreatedAt());
        return dto;
    }

    @Override
    public List<CourseDto> getCoursesByInstructor(Long instructorId) {
        return courseDao.findByInstructorId(instructorId)
            .stream()
            .map(this::toDto)
            .collect(Collectors.toList());
    }

    @Override
    public List<CourseDto> getAllCourses() {
        return courseDao.findAll()
            .stream()
            .map(this::toDto)
            .collect(Collectors.toList());
    }

    @Override
    public void deleteCourse(Long courseId) {
        courseDao.delete(courseId);
    }

    private CourseDto toDto(Course course) {
        CourseDto dto = new CourseDto();
        dto.setCourseId(course.getCourseId());
        dto.setTitle(course.getTitle());
        dto.setDescription(course.getDescription());
        dto.setCategory(course.getCategory());
        dto.setDifficulty(course.getDifficulty());
        dto.setContentPath(course.getContentPath());
        dto.setCreatedAt(course.getCreatedAt());
        dto.setInstructorId(course.getInstructor() != null ? course.getInstructor().getUserId() : null);
        dto.setInstructorName(course.getInstructor() != null ? course.getInstructor().getUsername() : null);
        if (course.getEnrollments() != null) dto.setEnrollmentCount(course.getEnrollments().size());
        return dto;
    }
}

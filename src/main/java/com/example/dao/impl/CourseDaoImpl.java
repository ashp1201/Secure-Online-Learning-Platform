package com.example.dao.impl;

import com.example.dao.CourseDAO;
import com.example.entity.Course;
import com.example.helper.HibernateUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public class CourseDaoImpl implements CourseDAO {

    @Autowired
    private HibernateUtil hibernateUtil;

    @Override
    public void save(Course course) {
        hibernateUtil.executeInTransaction(session -> {
            session.save(course);
            return null;
        });
    }

    @Override
    public void update(Course course) {
        hibernateUtil.executeInTransaction(session -> {
            session.update(course);
            return null;
        });
    }

    @Override
    public void delete(Long courseId) {
        hibernateUtil.executeInTransaction(session -> {
            Course course = session.get(Course.class, courseId);
            if (course != null) session.delete(course);
            return null;
        });
    }

    @Override
    public Course findById(Long id) {
        return hibernateUtil.executeReadOnly(session ->
            session.get(Course.class, id)
        );
    }

    @Override
    public List<Course> findAll() {
        return hibernateUtil.executeReadOnly(session ->
            session.createQuery("FROM Course", Course.class).getResultList()
        );
    }

    @Override
    public List<Course> findByInstructorId(Long instructorId) {
        return hibernateUtil.executeReadOnly(session ->
            session.createQuery("FROM Course c WHERE c.instructor.userId = :id", Course.class)
                .setParameter("id", instructorId)
                .getResultList()
        );
    }
}

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
            session.createQuery("FROM Course c LEFT JOIN FETCH c.instructor", Course.class).getResultList()
        );
    }

    @Override
    public List<Course> findByInstructorId(Long instructorId) {
        return hibernateUtil.executeReadOnly(session -> session.createQuery(
            "select c from Course c " +
            "left join fetch c.enrollments " +
            "left join fetch c.instructor " +
            "where c.instructor.userId = :iid", Course.class)
            .setParameter("iid", instructorId)
            .getResultList()
        );
    }



    @Override
    public List<Course> findByCategory(String category) {
        return hibernateUtil.executeReadOnly(session ->
            session.createQuery("FROM Course c WHERE c.category = :category", Course.class)
                .setParameter("category", category)
                .getResultList()
        );
    }

    @Override
    public List<Course> findByDifficulty(String difficulty) {
        return hibernateUtil.executeReadOnly(session ->
            session.createQuery("FROM Course c WHERE c.difficulty = :difficulty", Course.class)
                .setParameter("difficulty", difficulty)
                .getResultList()
        );
    }

    @Override
    public List<Course> findByCategoryAndDifficulty(String category, String difficulty) {
        return hibernateUtil.executeReadOnly(session ->
            session.createQuery("FROM Course c WHERE c.category = :category AND c.difficulty = :difficulty", Course.class)
                .setParameter("category", category)
                .setParameter("difficulty", difficulty)
                .getResultList()
        );
    }

    @Override
    public List<Course> searchByTitle(String title) {
        return hibernateUtil.executeReadOnly(session ->
            session.createQuery("FROM Course c WHERE LOWER(c.title) LIKE LOWER(:title)", Course.class)
                .setParameter("title", "%" + title + "%")
                .getResultList()
        );
    }
}
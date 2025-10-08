package com.example.dao.impl;

import com.example.dao.CourseDAO;
import com.example.entity.Course;
import com.example.helper.HibernateUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import javax.persistence.criteria.*;
import java.util.ArrayList;
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
            session.createQuery(
                "SELECT c FROM Course c " +
                "LEFT JOIN FETCH c.instructor " +
                "WHERE c.courseId = :id", Course.class)
                .setParameter("id", id)
                .uniqueResult()
        );
    }

    @Override
    public List<Course> findAll() {
        return hibernateUtil.executeReadOnly(session ->
            session.createQuery("FROM Course c LEFT JOIN FETCH c.instructor", Course.class)
                .getResultList()
        );
    }

    @Override
    public List<Course> findByInstructorId(Long instructorId) {
        return hibernateUtil.executeReadOnly(session -> 
            session.createQuery(
                "SELECT c FROM Course c " +
                "LEFT JOIN FETCH c.instructor " +
                "WHERE c.instructor.userId = :iid", Course.class)
                .setParameter("iid", instructorId)
                .getResultList()
        );
    }

    /**
     * Dynamic search method using Criteria API.
     * Handles any combination of category, difficulty, and title filters.
     * All parameters are optional - pass null to ignore that filter.
     */
    @Override
    public List<Course> searchCourses(String category, String difficulty, String title) {
        return hibernateUtil.executeReadOnly(session -> {
            CriteriaBuilder cb = session.getCriteriaBuilder();
            CriteriaQuery<Course> cq = cb.createQuery(Course.class);
            Root<Course> course = cq.from(Course.class);
            
            // Always fetch instructor to avoid LazyInitializationException
            course.fetch("instructor", JoinType.LEFT);
            
            // Build dynamic predicates based on provided parameters
            List<Predicate> predicates = new ArrayList<>();
            
            if (category != null && !category.trim().isEmpty()) {
                predicates.add(cb.equal(course.get("category"), category));
            }
            
            if (difficulty != null && !difficulty.trim().isEmpty()) {
                predicates.add(cb.equal(course.get("difficulty"), difficulty));
            }
            
            if (title != null && !title.trim().isEmpty()) {
                predicates.add(
                    cb.like(cb.lower(course.get("title")), "%" + title.toLowerCase() + "%")
                );
            }
            
            // Apply predicates if any exist
            if (!predicates.isEmpty()) {
                cq.where(cb.and(predicates.toArray(new Predicate[0])));
            }
            
            cq.select(course);
            
            return session.createQuery(cq).getResultList();
        });
    }
}

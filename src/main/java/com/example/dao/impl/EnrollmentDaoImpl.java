package com.example.dao.impl;

import com.example.dao.EnrollmentDAO;
import com.example.entity.Enrollment;
import com.example.helper.HibernateUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class EnrollmentDaoImpl implements EnrollmentDAO {

    @Autowired
    private HibernateUtil hibernateUtil;

    @Override
    public void save(Enrollment enrollment) {
        hibernateUtil.executeInTransaction(session -> {
            session.save(enrollment);
            return null;
        });
    }

    @Override
    public void update(Enrollment enrollment) {
        hibernateUtil.executeInTransaction(session -> {
            session.update(enrollment);
            return null;
        });
    }

    @Override
    public void delete(Long enrollmentId) {
        hibernateUtil.executeInTransaction(session -> {
            Enrollment enrollment = session.get(Enrollment.class, enrollmentId);
            if (enrollment != null) session.delete(enrollment);
            return null;
        });
    }

    @Override
    public Enrollment findById(Long id) {
        return hibernateUtil.executeReadOnly(session ->
            session.get(Enrollment.class, id)
        );
    }

    @Override
    public List<Enrollment> findByStudentId(Long studentId) {
        return hibernateUtil.executeReadOnly(session ->
            session.createQuery("FROM Enrollment e WHERE e.student.userId = :sid", Enrollment.class)
                .setParameter("sid", studentId)
                .getResultList()
        );
    }

    @Override
    public List<Enrollment> findByCourseInstructorId(Long instructorId) {
        return hibernateUtil.executeReadOnly(session ->
            session.createQuery("SELECT e FROM Enrollment e JOIN e.course c WHERE c.instructor.userId = :iid", Enrollment.class)
                .setParameter("iid", instructorId)
                .getResultList()
        );
    }
}

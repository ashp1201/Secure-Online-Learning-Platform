package com.example.dao.impl;

import com.example.dao.ProgressDAO;
import com.example.entity.Progress;
import com.example.helper.HibernateUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class ProgressDaoImpl implements ProgressDAO{

    @Autowired
    private HibernateUtil hibernateUtil;

    @Override
    public void save(Progress progress) {
        hibernateUtil.executeInTransaction(session -> {
            session.save(progress);
            return null;
        });
    }

    @Override
    public void update(Progress progress) {
        hibernateUtil.executeInTransaction(session -> {
            session.update(progress);
            return null;
        });
    }

    @Override
    public void delete(Long progressId) {
        hibernateUtil.executeInTransaction(session -> {
            Progress p = session.get(Progress.class, progressId);
            if (p != null) session.delete(p);
            return null;
        });
    }

    @Override
    public Progress findById(Long progressId) {
        return hibernateUtil.executeReadOnly(session ->
            session.get(Progress.class, progressId)
        );
    }

    @Override
    public List<Progress> findByEnrollmentId(Long enrollmentId) {
        return hibernateUtil.executeReadOnly(session ->
            session.createQuery("FROM Progress p WHERE p.enrollment.enrollmentId = :enrollId", Progress.class)
                .setParameter("enrollId", enrollmentId)
                .getResultList()
        );
    }
}

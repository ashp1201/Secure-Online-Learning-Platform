package com.example.dao;

import com.example.entity.Progress;
import java.util.List;

public interface ProgressDAO {
    void save(Progress progress);
    void update(Progress progress);
    void delete(Long progressId);
    Progress findById(Long progressId);
    List<Progress> findByEnrollmentId(Long enrollmentId);
}

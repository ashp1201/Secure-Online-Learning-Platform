package com.example.dao;

import com.example.entity.Progress;
import java.util.List;

public interface ProgressDAO {
    void save(Progress progress);
    Progress findById(Long id);
    List<Progress> findByEnrollment(Long enrollmentId);
}

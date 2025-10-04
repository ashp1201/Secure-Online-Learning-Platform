package com.example.service;

import com.example.dto.ProgressDto;
import com.example.entity.Progress;
import java.util.List;

public interface ProgressService {
    Progress updateProgress(ProgressDto dto);
    List<Progress> getProgressByEnrollment(Long enrollmentId);
}

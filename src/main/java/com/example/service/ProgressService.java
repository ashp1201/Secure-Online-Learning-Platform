package com.example.service;

import com.example.dto.ProgressDto;

import java.util.List;

public interface ProgressService {
    ProgressDto addProgress(ProgressDto dto, Long enrollmentId);
    List<ProgressDto> getProgressByEnrollment(Long enrollmentId);
    void updateProgress(ProgressDto dto);
    ProgressDto getProgressById(Long progressId);
    Double calculateOverallProgress(Long enrollmentId);
    void deleteProgress(Long progressId);
    void updateOrCreateProgress(ProgressDto dto);
}

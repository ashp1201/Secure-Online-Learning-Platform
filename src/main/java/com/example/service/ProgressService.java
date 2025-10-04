package com.example.service;

import com.example.dto.ProgressDto;
import java.util.List;

public interface ProgressService {
    ProgressDto addProgress(ProgressDto progressDto, Long enrollmentId);
    List<ProgressDto> getProgressByEnrollment(Long enrollmentId);
    void updateProgress(ProgressDto progressDto);
    void deleteProgress(Long progressId);
}

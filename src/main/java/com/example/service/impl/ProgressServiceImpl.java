package com.example.service.impl;

import com.example.dao.EnrollmentDAO;
import com.example.dao.ProgressDAO;
import com.example.dto.ProgressDto;
import com.example.entity.Enrollment;
import com.example.entity.Progress;
import com.example.service.ProgressService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.List;
import java.util.stream.Collectors;

@Service
public class ProgressServiceImpl implements ProgressService {

    @Autowired
    private ProgressDAO progressDao;

    @Autowired
    private EnrollmentDAO enrollmentDao;

    @Override
    public ProgressDto addProgress(ProgressDto dto, Long enrollmentId) {
        Enrollment enrollment = enrollmentDao.findById(enrollmentId);
        Progress progress = new Progress();
        progress.setModuleId(dto.getModuleId());
        progress.setCompletedPercent(dto.getCompletedPercent());
        progress.setLastAccessedAt(LocalDateTime.now());
        progress.setEnrollment(enrollment);
        progressDao.save(progress);
        return toDto(progress);
    }

    @Override
    public List<ProgressDto> getProgressByEnrollment(Long enrollmentId) {
        return progressDao.findByEnrollmentId(enrollmentId)
                .stream()
                .map(this::toDto)
                .collect(Collectors.toList());
    }

    @Override
    public void updateProgress(ProgressDto dto) {
        Progress progress = progressDao.findById(dto.getProgressId());
        if (progress != null) {
            progress.setCompletedPercent(dto.getCompletedPercent());
            progress.setLastAccessedAt(LocalDateTime.now());
            progressDao.update(progress);
        }
    }

    @Override
    public void updateOrCreateProgress(ProgressDto dto) {
        // Check if progress exists for this enrollment
        List<Progress> existingProgress = progressDao.findByEnrollmentId(dto.getEnrollmentId());
        
        if (existingProgress.isEmpty()) {
            // Create new progress
            Enrollment enrollment = enrollmentDao.findById(dto.getEnrollmentId());
            Progress progress = new Progress();
            progress.setModuleId("video"); // Default module
            progress.setCompletedPercent(dto.getCompletedPercent());
            progress.setLastAccessedAt(LocalDateTime.now());
            progress.setEnrollment(enrollment);
            progressDao.save(progress);
        } else {
            // Update existing progress
            Progress progress = existingProgress.get(0);
            progress.setCompletedPercent(dto.getCompletedPercent());
            progress.setLastAccessedAt(LocalDateTime.now());
            progressDao.update(progress);
        }
    }

    @Override
    public ProgressDto getProgressById(Long progressId) {
        Progress progress = progressDao.findById(progressId);
        return progress != null ? toDto(progress) : null;
    }

    @Override
    public Double calculateOverallProgress(Long enrollmentId) {
        List<Progress> progressList = progressDao.findByEnrollmentId(enrollmentId);
        if (progressList.isEmpty()) return 0.0;
        return progressList.stream()
                .mapToDouble(Progress::getCompletedPercent)
                .average()
                .orElse(0.0);
    }

    @Override
    public void deleteProgress(Long progressId) {
        progressDao.delete(progressId);
    }

    private ProgressDto toDto(Progress progress) {
        ProgressDto dto = new ProgressDto();
        dto.setProgressId(progress.getProgressId());
        dto.setModuleId(progress.getModuleId());
        dto.setCompletedPercent(progress.getCompletedPercent());
        dto.setLastAccessedAt(progress.getLastAccessedAt());
        dto.setEnrollmentId(progress.getEnrollment() != null ? progress.getEnrollment().getEnrollmentId() : null);
        return dto;
    }
}

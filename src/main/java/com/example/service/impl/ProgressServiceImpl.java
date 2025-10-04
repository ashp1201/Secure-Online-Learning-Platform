package com.example.service.impl;

import com.example.dao.ProgressDAO;
import com.example.entity.Progress;
import com.example.entity.Enrollment;
import com.example.dto.ProgressDto;
import com.example.service.EnrollmentService;
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
    private EnrollmentService enrollmentService; 

    @Override
    public ProgressDto addProgress(ProgressDto dto, Long enrollmentId) {
        Progress progress = new Progress();
        progress.setModuleId(dto.getModuleId());
        progress.setCompletedPercent(dto.getCompletedPercent());
        progress.setNotes(dto.getNotes());
        progress.setLastAccessedAt(LocalDateTime.now());

        Enrollment enrollment = enrollmentService.findById(enrollmentId);
        progress.setEnrollment(enrollment);

        progressDao.save(progress);
        dto.setProgressId(progress.getProgressId());
        return dto;
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
            progress.setModuleId(dto.getModuleId());
            progress.setCompletedPercent(dto.getCompletedPercent());
            progress.setNotes(dto.getNotes());
            progress.setLastAccessedAt(LocalDateTime.now());
            progressDao.update(progress);
        }
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
        dto.setNotes(progress.getNotes());
        dto.setLastAccessedAt(progress.getLastAccessedAt());
        dto.setEnrollmentId(progress.getEnrollment().getEnrollmentId());
        return dto;
    }
}

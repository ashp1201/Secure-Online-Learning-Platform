package com.example.controller;

import com.example.dto.ProgressDto;
import com.example.entity.User;
import com.example.service.ProgressService;
import com.example.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/progress")
public class ProgressController {

    @Autowired
    private ProgressService progressService;

    @Autowired
    private UserService userService;

    @PostMapping("/add/{enrollmentId}")
    public ResponseEntity<ProgressDto> addProgress(@RequestBody ProgressDto dto, @PathVariable Long enrollmentId, Authentication auth) {
        User user = userService.findByEmail(auth.getName()); // Check user role if needed
        // Implement role validation if required
        ProgressDto created = progressService.addProgress(dto, enrollmentId);
        return ResponseEntity.ok(created);
    }

    @GetMapping("/enrollment/{enrollmentId}")
    public ResponseEntity<List<ProgressDto>> getProgress(@PathVariable Long enrollmentId, Authentication auth) {
        List<ProgressDto> list = progressService.getProgressByEnrollment(enrollmentId);
        return ResponseEntity.ok(list);
    }

    @PutMapping("/update/{progressId}")
    public ResponseEntity<Void> updateProgress(@RequestBody ProgressDto dto, @PathVariable Long progressId, Authentication auth) {
        dto.setProgressId(progressId); // ensure ID is set
        progressService.updateProgress(dto);
        return ResponseEntity.ok().build();
    }

    @DeleteMapping("/{progressId}")
    public ResponseEntity<Void> deleteProgress(@PathVariable Long progressId, Authentication auth) {
        progressService.deleteProgress(progressId);
        return ResponseEntity.ok().build();
    }
}

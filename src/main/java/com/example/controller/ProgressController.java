package com.example.controller;

import com.example.dto.ProgressDto;
import com.example.entity.User;
import com.example.service.ProgressService;
import com.example.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

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

    @GetMapping("/{progressId}")
    public ResponseEntity<ProgressDto> getProgressById(@PathVariable Long progressId, Authentication auth) {
        ProgressDto progress = progressService.getProgressById(progressId);
        if (progress == null) {
            return ResponseEntity.notFound().build();
        }
        return ResponseEntity.ok(progress);
    }

    @GetMapping("/enrollment/{enrollmentId}/overall")
    public ResponseEntity<Map<String, Object>> getOverallProgress(@PathVariable Long enrollmentId, Authentication auth) {
        Double overallProgress = progressService.calculateOverallProgress(enrollmentId);
        Map<String, Object> response = new HashMap<>();
        response.put("enrollmentId", enrollmentId);
        response.put("overallProgress", overallProgress);
        response.put("progressPercentage", String.format("%.2f%%", overallProgress));
        return ResponseEntity.ok(response);
    }

    @DeleteMapping("/{progressId}")
    public ResponseEntity<Void> deleteProgress(@PathVariable Long progressId, Authentication auth) {
        progressService.deleteProgress(progressId);
        return ResponseEntity.ok().build();
    }
}
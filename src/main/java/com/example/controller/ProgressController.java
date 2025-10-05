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

    @PostMapping("/update")
    public ResponseEntity<Map<String, Object>> updateProgress(
            @RequestBody Map<String, Object> progressData,
            Authentication auth) {
        
        Long enrollmentId = Long.valueOf(progressData.get("enrollmentId").toString());
        Double watchedPercent = Double.valueOf(progressData.get("watchedPercent").toString());
        
        ProgressDto dto = new ProgressDto();
        dto.setEnrollmentId(enrollmentId);
        dto.setCompletedPercent(watchedPercent);
        
        progressService.updateOrCreateProgress(dto);
        
        Map<String, Object> response = new HashMap<>();
        response.put("success", true);
        response.put("progress", watchedPercent);
        return ResponseEntity.ok(response);
    }

    @GetMapping("/enrollment/{enrollmentId}")
    public ResponseEntity<List<ProgressDto>> getProgress(@PathVariable Long enrollmentId, Authentication auth) {
        List<ProgressDto> list = progressService.getProgressByEnrollment(enrollmentId);
        return ResponseEntity.ok(list);
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
}

package com.example.controller;

import com.example.entity.User;
import com.example.service.FileUploadService;
import com.example.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.util.Arrays;
import java.util.HashMap;
import java.util.Map;

@RestController
@RequestMapping("/upload")
public class FileUploadController {

    @Autowired
    private FileUploadService fileUploadService;

    @Autowired
    private UserService userService;

    @Value("${app.upload.path:/uploads}")
    private String uploadPath;

    @PostMapping("/course-content")
    public ResponseEntity<Map<String, Object>> uploadCourseContent(
            @RequestParam("file") MultipartFile file,
            Authentication authentication) {
        
        User user = userService.findByEmail(authentication.getName());
        if (user == null || !"INSTRUCTOR".equalsIgnoreCase(user.getRole())) {
            return ResponseEntity.status(403).body(createErrorResponse("Only instructors can upload course content"));
        }

        try {
            String instructorUploadPath = uploadPath + "/instructors/" + user.getUserId() + "/courses";
            String filePath = fileUploadService.uploadFile(file, instructorUploadPath);
            
            Map<String, Object> response = new HashMap<>();
            response.put("success", true);
            response.put("filePath", filePath);
            response.put("fileName", file.getOriginalFilename());
            response.put("fileSize", fileUploadService.getFileSize(file));
            
            return ResponseEntity.ok(response);
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(createErrorResponse(e.getMessage()));
        }
    }

    @PostMapping("/profile-image")
    public ResponseEntity<Map<String, Object>> uploadProfileImage(
            @RequestParam("file") MultipartFile file,
            Authentication authentication) {
        
        User user = userService.findByEmail(authentication.getName());
        if (user == null) {
            return ResponseEntity.status(401).body(createErrorResponse("User not authenticated"));
        }

        try {
            // Only allow image files for profile images
            String extension = fileUploadService.getFileExtension(file.getOriginalFilename());
            if (!Arrays.asList("jpg", "jpeg", "png", "gif").contains(extension)) {
                return ResponseEntity.badRequest().body(createErrorResponse("Only image files are allowed for profile images"));
            }

            String userUploadPath = uploadPath + "/users/" + user.getUserId() + "/profile";
            String filePath = fileUploadService.uploadFile(file, userUploadPath);
            
            Map<String, Object> response = new HashMap<>();
            response.put("success", true);
            response.put("filePath", filePath);
            response.put("fileName", file.getOriginalFilename());
            
            return ResponseEntity.ok(response);
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(createErrorResponse(e.getMessage()));
        }
    }

    @DeleteMapping("/file")
    public ResponseEntity<Map<String, Object>> deleteFile(@RequestParam String filePath, Authentication authentication) {
        User user = userService.findByEmail(authentication.getName());
        if (user == null) {
            return ResponseEntity.status(401).body(createErrorResponse("User not authenticated"));
        }

        try {
            boolean deleted = fileUploadService.deleteFile(filePath);
            Map<String, Object> response = new HashMap<>();
            response.put("success", deleted);
            response.put("message", deleted ? "File deleted successfully" : "Failed to delete file");
            
            return ResponseEntity.ok(response);
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(createErrorResponse(e.getMessage()));
        }
    }

    private Map<String, Object> createErrorResponse(String message) {
        Map<String, Object> response = new HashMap<>();
        response.put("success", false);
        response.put("error", message);
        return response;
    }
}

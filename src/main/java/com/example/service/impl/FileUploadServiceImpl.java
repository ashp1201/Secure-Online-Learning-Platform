package com.example.service.impl;

import com.example.service.FileUploadService;
import org.apache.commons.io.FilenameUtils;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;


import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.Arrays;
import java.util.List;
import java.util.UUID;

@Service
public class FileUploadServiceImpl implements FileUploadService {

    private static final List<String> ALLOWED_EXTENSIONS = Arrays.asList(
        "pdf", "doc", "docx", "ppt", "pptx", "txt", "mp4", "avi", "mov", "zip", "rar"
    );
    
    private static final long MAX_FILE_SIZE = 100 * 1024 * 1024; // 100MB

    @Override
    public String uploadFile(MultipartFile file, String uploadPath) {
        try {
            if (file.isEmpty()) {
                throw new IllegalArgumentException("File is empty");
            }

            if (!isValidFileType(file.getOriginalFilename())) {
                throw new IllegalArgumentException("Invalid file type");
            }

            if (getFileSize(file) > MAX_FILE_SIZE) {
                throw new IllegalArgumentException("File size exceeds maximum limit");
            }

            // Create upload directory if it doesn't exist
            Path uploadDir = Paths.get(uploadPath);
            if (!Files.exists(uploadDir)) {
                Files.createDirectories(uploadDir);
                System.out.println("Created directory structure: " + uploadDir.toAbsolutePath());
            }

            // Generate unique filename
            String originalFilename = file.getOriginalFilename();
            String extension = getFileExtension(originalFilename);
            String uniqueFilename = UUID.randomUUID().toString() + "." + extension;

            // Save file
            Path filePath = uploadDir.resolve(uniqueFilename);
            Files.copy(file.getInputStream(), filePath, StandardCopyOption.REPLACE_EXISTING);

            return filePath.toString();
        } catch (IOException e) {
            throw new RuntimeException("Failed to upload file", e);
        }
    }

    @Override
    public boolean deleteFile(String filePath) {
        try {
            Path path = Paths.get(filePath);
            return Files.deleteIfExists(path);
        } catch (IOException e) {
            return false;
        }
    }

    @Override
    public String getFileExtension(String fileName) {
        return FilenameUtils.getExtension(fileName).toLowerCase();
    }

    @Override
    public boolean isValidFileType(String fileName) {
        String extension = getFileExtension(fileName);
        return ALLOWED_EXTENSIONS.contains(extension);
    }

    @Override
    public long getFileSize(MultipartFile file) {
        return file.getSize();
    }
}

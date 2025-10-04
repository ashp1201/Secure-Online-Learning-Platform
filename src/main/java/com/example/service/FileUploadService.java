package com.example.service;

import org.springframework.web.multipart.MultipartFile;

public interface FileUploadService {
    String uploadFile(MultipartFile file, String uploadPath);
    boolean deleteFile(String filePath);
    String getFileExtension(String fileName);
    boolean isValidFileType(String fileName);
    long getFileSize(MultipartFile file);
}

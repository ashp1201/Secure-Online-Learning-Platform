package com.example.dto;

import javax.validation.constraints.NotBlank;

public class CourseDto {

    private Long courseId;

    @NotBlank
    private String title;

    private String description;
    private String category;
    private String difficulty;

    // no file field here → handled in Controller via MultipartFile

    // getters & setters
}

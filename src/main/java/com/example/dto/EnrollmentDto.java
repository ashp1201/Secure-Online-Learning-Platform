package com.example.dto;

import javax.validation.constraints.NotNull;

public class EnrollmentDto {

    private Long enrollmentId;

    @NotNull
    private Long studentId;

    @NotNull
    private Long courseId;

    private String status; // ACTIVE or COMPLETED

    // getters & setters
}

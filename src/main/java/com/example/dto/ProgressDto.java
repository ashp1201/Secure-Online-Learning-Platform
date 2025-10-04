package com.example.dto;

import javax.validation.constraints.NotNull;

public class ProgressDto {

    private Long progressId;

    @NotNull
    private Long enrollmentId;

    private String moduleId;
    private Double completedPercent;
    private String notes;

    // getters & setters
}

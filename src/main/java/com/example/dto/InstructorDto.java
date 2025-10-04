package com.example.dto;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.Size;

public class InstructorDto {

    @NotBlank(message = "Area of expertise is required")
    @Size(max = 255, message = "Area of expertise must not exceed 255 characters")
    private String areaOfExpertise;

    @NotBlank(message = "Professional bio is required")
    @Size(max = 1000, message = "Professional bio must not exceed 1000 characters")
    private String professionalBio;

    // Getters and setters
    public String getAreaOfExpertise() {
        return areaOfExpertise;
    }
    public void setAreaOfExpertise(String areaOfExpertise) {
        this.areaOfExpertise = areaOfExpertise;
    }

    public String getProfessionalBio() {
        return professionalBio;
    }
    public void setProfessionalBio(String professionalBio) {
        this.professionalBio = professionalBio;
    }
}

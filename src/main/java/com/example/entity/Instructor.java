package com.example.entity;

import javax.persistence.*;

@Entity
@Table(name = "Instructor")
public class Instructor extends User {

    @Column(length = 255)
    private String areaOfExpertise; // e.g. Web Development, Data Science

    @Column(length = 1000)
    private String professionalBio; // Describe background, experience, philosophy

    // Getters and Setters
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

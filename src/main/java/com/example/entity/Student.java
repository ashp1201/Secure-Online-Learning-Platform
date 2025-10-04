package com.example.entity;

import javax.persistence.*;

@Entity
@Table(name = "Student")
public class Student extends User {

    @Column(length = 1000)
    private String bio; // Interests, goals

    // Getters and Setters
    public String getBio() {
        return bio;
    }
    public void setBio(String bio) {
        this.bio = bio;
    }
}

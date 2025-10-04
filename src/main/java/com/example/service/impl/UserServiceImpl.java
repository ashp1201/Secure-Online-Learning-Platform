package com.example.service.impl;

import java.util.*;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Service;

import com.example.dao.UserDAO;
import com.example.dto.LoginRequest;
import com.example.dto.UserDto;
import com.example.dto.InstructorDto;
import com.example.dto.StudentDto;
import com.example.entity.User;
import com.example.entity.Instructor;
import com.example.entity.Student;
import com.example.security.JwtUtil;
import com.example.service.UserService;

@Service
public class UserServiceImpl implements UserService {

    @Autowired
    private UserDAO userDAO;

    @Autowired
    private AuthenticationManager authenticationManager;

    private final JwtUtil jwtUtil = new JwtUtil();

    @Override
    public List<User> getAllUsers() {
        return userDAO.findAll();
    }

    @Override
    public User findUserById(Long id) {
        return userDAO.findById(id);
    }

    @Override
    public User registerUser(UserDto userDto) {
        User user;

        String role = userDto.getRole();

        if ("INSTRUCTOR".equalsIgnoreCase(role)) {
            Instructor instructor = new Instructor();
            InstructorDto instructorDto = userDto.getInstructor();
            if (instructorDto != null) {
                instructor.setAreaOfExpertise(instructorDto.getAreaOfExpertise());
                instructor.setProfessionalBio(instructorDto.getProfessionalBio());
            }
            user = instructor;
        }
        else if ("STUDENT".equalsIgnoreCase(role)) {
            Student student = new Student();
            StudentDto studentDto = userDto.getStudent();
            if (studentDto != null) {
                student.setBio(studentDto.getBio());
            }
            user = student;
        } else {
            return null;
        }

        user.setRole(role);
        user.setFullName(userDto.getFullName());
        user.setEmail(userDto.getEmail());
        user.setPasswordHash(userDto.getPassword()); // password encoding handled in DAO save

        userDAO.save(user);
        return user;
    }

    @Override
    public ResponseEntity<?> authenticateUser(LoginRequest loginRequest) {
        String email = loginRequest.getEmail();
        String password = loginRequest.getPassword();
        String role = loginRequest.getRole();

        try {
            authenticationManager.authenticate(new UsernamePasswordAuthenticationToken(email, password));
        } catch (BadCredentialsException ex) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED)
                    .body(Collections.singletonMap("message", "Invalid email or password"));
        }

        User dbUser = findByEmail(email);
        if (dbUser == null) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(Collections.singletonMap("message", "User not found"));
        }

        if (!dbUser.getRole().equalsIgnoreCase(role)) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(Collections.singletonMap("message", "Role mismatch"));
        }

        String token = jwtUtil.generateToken(dbUser.getEmail());

        Map<String, Object> response = new HashMap<>();
        response.put("status", "success");
        response.put("token", token);
        response.put("role", dbUser.getRole());

        return ResponseEntity.ok(response);
    }

    @Override
    public ResponseEntity<?> getCurrentUserInfo(Authentication authentication) {
        User user = findByEmail(authentication.getName());

        if (user == null) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(Collections.singletonMap("message", "User not found"));
        }

        Map<String, String> response = new HashMap<>();
        response.put("email", user.getEmail());
        response.put("fullName", user.getFullName());
        response.put("role", user.getRole());

        return ResponseEntity.ok(response);
    }

    @Override
    public User findByEmail(String email) {
        return userDAO.findByEmail(email);
    }
}

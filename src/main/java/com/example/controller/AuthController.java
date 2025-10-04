package com.example.controller;

import java.util.Collections;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;

import com.example.dto.LoginRequest;
import com.example.dto.UserDto;
import com.example.service.UserService;

@RestController
@RequestMapping("/auth")
public class AuthController {

    @Autowired
    private UserService userService;

    /**
     * Authenticates user credentials and generates JWT token on successful login.
     * Validates email, password, and role combination.
     *
     * @param request LoginRequest DTO containing email, password, and role
     * @return ResponseEntity with JWT token and user role or error message
     */
    @PostMapping("/login")
    public ResponseEntity<?> login(@Valid @RequestBody LoginRequest request) {
        return userService.authenticateUser(request);
    }

    /**
     * Registers a new user (Student or Instructor).
     * @param userDto DTO containing user registration details
     * @return ResponseEntity with saved User details
     */
    @PostMapping("/register")
    public ResponseEntity<?> register(@Valid @RequestBody UserDto userDto) {
    	 if (userService.findByEmail(userDto.getEmail()) != null) {
    	        return ResponseEntity.status(HttpStatus.CONFLICT)
    	                .body(Collections.singletonMap("message", "Email address already exists"));
    	    }
    	 else {
        return ResponseEntity.ok(userService.registerUser(userDto));
    	 }
    }

    /**
     * Retrieves information about the currently authenticated user.
     *
     * @param authentication Spring Security authentication context containing user details
     * @return ResponseEntity with user's basic info
     */
    @GetMapping("/user/me")
    public ResponseEntity<?> getCurrentUser(Authentication authentication) {
        return userService.getCurrentUserInfo(authentication);
    }
}

package com.example.service;

import com.example.dto.LoginRequest;
import com.example.dto.UserDto;
import com.example.entity.User;
import java.util.List;

import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;

public interface UserService {
    User registerUser(UserDto userDto);
    User findByEmail(String email);
    List<User> getAllUsers();
    
    ResponseEntity<?> authenticateUser(LoginRequest loginRequest);
    ResponseEntity<?> getCurrentUserInfo(Authentication authentication);
    User findUserById(Long id);
}

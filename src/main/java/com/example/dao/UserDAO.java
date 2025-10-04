package com.example.dao;

import com.example.entity.User;
import java.util.List;

public interface UserDAO {
    void save(User user);
    User findById(Long id);
    User findByEmail(String email);
    List<User> findAll();
}

package com.example.dao.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Repository;

import com.example.dao.UserDAO;
import com.example.entity.User;
import com.example.helper.HibernateUtil;

@Repository
public class UserDAOImpl implements UserDAO {

    private final PasswordEncoder passwordEncoder;
    private final HibernateUtil hibernateUtil;

    @Autowired
    public UserDAOImpl(PasswordEncoder passwordEncoder, HibernateUtil hibernateUtil) {
        this.passwordEncoder = passwordEncoder;
        this.hibernateUtil = hibernateUtil;
    }

    @Override
    public List<User> findAll() {
        return hibernateUtil.executeReadOnly(session ->
            session.createQuery("FROM User", User.class).list()
        );
    }

    @Override
    public User findById(Long id) {
        return hibernateUtil.executeReadOnly(session ->
            session.get(User.class, id)
        );
    }



    private boolean emailExists(String email) {
        String hql = "SELECT 1 FROM User WHERE email = :email";
        return hibernateUtil.executeReadOnly(session ->
            session.createQuery(hql)
                .setParameter("email", email)
                .uniqueResult() != null
        );
    }

    @Override
    public void save(User user) {
        hibernateUtil.executeInTransaction(session -> {
            if (emailExists(user.getEmail())) {
                // Skip saving instead of throwing custom exception
                return null;
            }
            user.setPasswordHash(passwordEncoder.encode(user.getPasswordHash())); // encode password
            session.save(user);
            return null;
        });
    }



    @Override
    public User findByEmail(String email) {
        return hibernateUtil.executeReadOnly(session -> {
            List<User> users = session.createQuery("FROM User u WHERE u.email = :email", User.class)
                .setParameter("email", email)
                .getResultList();

            if (users.isEmpty()) {
                return null; // return null instead of throwing exception
            }
            return users.get(0);
        });
    }
}

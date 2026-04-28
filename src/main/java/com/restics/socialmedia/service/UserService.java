package com.restics.socialmedia.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.restics.socialmedia.model.User;
import com.restics.socialmedia.repository.UserRepository;

@Service
public class UserService {

    private final UserRepository userRepo;

    public UserService(UserRepository userRepo) {
        this.userRepo = userRepo;
    }

    public List<User> getAllUsers() {
        return userRepo.findAll();
    }

    //     public User findUserById(int id) { // for 
    //     return userRepo.findAll().stream()
    //             .filter(u -> u.userId() == id)
    //             .findFirst()
    //             .orElse(null);
    // }

    public User getCurrentUser() { //used for following, main feed, and profile views
        List<User> all = getAllUsers();
        return all.isEmpty() ? null : all.get(0);
    }
}

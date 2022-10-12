package com.example.commute_system.repository;

import com.example.commute_system.domain.User;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;


public interface UserRepository extends JpaRepository<User, Integer> {
    Optional<User> findByUsername(String username);

    Optional<User> findByName(String name);

    Optional<User> findByUsernameOrderByName(String username);


    User findUserByUsername(String email);
}

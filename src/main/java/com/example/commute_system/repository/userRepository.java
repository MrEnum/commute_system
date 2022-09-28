package com.example.commute_system.repository;

import com.example.commute_system.domain.User;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;

public interface userRepository extends JpaRepository<User, Integer> {
    Optional<User> findByUsername(String username);
}

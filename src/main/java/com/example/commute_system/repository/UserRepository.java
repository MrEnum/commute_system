package com.example.commute_system.repository;

import com.example.commute_system.domain.User;
import org.springframework.data.jpa.repository.JpaRepository;



public interface UserRepository extends JpaRepository<User, Integer> {

    User findUserByUsername(String username);

}

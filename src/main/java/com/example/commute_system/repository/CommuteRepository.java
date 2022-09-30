package com.example.commute_system.repository;

import com.example.commute_system.domain.Commute;
import org.springframework.data.jpa.repository.JpaRepository;

public interface CommuteRepository extends JpaRepository<Commute,Integer> {
}

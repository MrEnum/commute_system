package com.example.commute_system.repository;

import com.example.commute_system.domain.Commute;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface CommuteRepository extends JpaRepository<Commute,Integer> {

    List<Commute> findAllByUsername(String username);

    //username란에 username값을 조회해서 첫번째걸 가져와라
    Commute findFirstByUsernameOrderByLocalDateTimeNowDesc(String username);
}

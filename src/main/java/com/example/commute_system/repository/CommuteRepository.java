package com.example.commute_system.repository;

import com.example.commute_system.domain.Commute;
import org.springframework.data.jpa.repository.JpaRepository;

import java.time.LocalDateTime;
import java.util.List;

public interface CommuteRepository extends JpaRepository<Commute, Integer> {

    List<Commute> findAllByUsernameOrderByIdDesc(String username);
    //username란에 username값을 조회해서 첫번째걸 가져와라
    Commute findFirstByUsernameOrderByLocalDateTimeNowDesc(String username);
    List<Commute> findAllByLocalDateTimeNowBetweenOrderByIdDesc(LocalDateTime startDate, LocalDateTime endDate);
    List<Commute> findAllByNameAndLocalDateTimeNowBetweenOrderByIdDesc(String otherUsername, LocalDateTime startDateTime, LocalDateTime endDateTime);
}

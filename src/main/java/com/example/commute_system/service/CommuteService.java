package com.example.commute_system.service;


import com.example.commute_system.domain.Commute;
import com.example.commute_system.domain.User;
import com.example.commute_system.repository.CommuteRepository;
import com.example.commute_system.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.Optional;

@Service
@RequiredArgsConstructor
public class CommuteService {
    private final CommuteRepository commuteRepository;
    private final UserRepository userRepository;
    LocalDateTime localDateTime;


    //
    // private final String localDateTimeNow = localDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));


    //출근 메서드
    public LocalDateTime start(String username) {
        int work = 1;
        LocalDateTime now = localDateTime.now();
        String name = userRepository.findUserByUsername(username).getName();
        Commute commute = new Commute(username, name, now, work);
        commuteRepository.save(commute);
        return now;
    }

    //퇴근 메서드
    public LocalDateTime finish(String username) {
        int work = 0;
        LocalDateTime now = localDateTime.now();
        String name = userRepository.findUserByUsername(username).getName();
        Commute commute = new Commute(username, name, now, work);
        commuteRepository.save(commute);
        return now;
    }

}


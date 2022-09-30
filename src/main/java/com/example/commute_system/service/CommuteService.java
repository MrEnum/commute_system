package com.example.commute_system.service;


import com.example.commute_system.domain.Commute;
import com.example.commute_system.repository.CommuteRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

@Service
@RequiredArgsConstructor
public class CommuteService {
    private final CommuteRepository commuteRepository;
    private final LocalDateTime localDateTime;
    //
   // private final String localDateTimeNow = localDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));


    //출근 메서드
    public String start(String username) {
        int work = 1;

        Commute commute = new Commute(username, localDateTime.now().toString(), work);
        commuteRepository.save(commute);
        return localDateTime.now().toString();
    }

    //퇴근 메서드
    public String finish(String username) {
        int work = 0;

        Commute commute = new Commute(username, localDateTime.now().toString(), work);
        return localDateTime.now().toString();
    }

}


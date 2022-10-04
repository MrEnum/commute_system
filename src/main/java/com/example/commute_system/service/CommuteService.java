package com.example.commute_system.service;


import com.example.commute_system.domain.Commute;
import com.example.commute_system.repository.CommuteRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;

@Service
@RequiredArgsConstructor
public class CommuteService {
    private final CommuteRepository commuteRepository;
    LocalDateTime localDateTime;



    //
   // private final String localDateTimeNow = localDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));


    //출근 메서드
    public String start(String username) {
        int work = 1;
        String now = localDateTime.now().toString();
        Commute commute = new Commute(username, now, work);
        commuteRepository.save(commute);
        return now;
    }

    //퇴근 메서드
    public String finish(String username) {
        int work = 0;

        String now = localDateTime.now().toString();
        Commute commute = new Commute(username, now, work);
        commuteRepository.save(commute);
        return now;
    }

}


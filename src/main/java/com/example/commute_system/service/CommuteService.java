package com.example.commute_system.service;


import com.example.commute_system.domain.Commute;
import com.example.commute_system.domain.User;
import com.example.commute_system.repository.CommuteRepository;
import com.example.commute_system.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

@Service
@RequiredArgsConstructor
public class CommuteService {
    private final CommuteRepository commuteRepository;
    private final UserRepository userRepository;



    //
    // private final String localDateTimeNow = localDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));

    @Transactional
    //출근 메서드
    public String start(String username) {
        LocalDateTime now = LocalDateTime.now();
        String work = "출근";
        User user = userRepository.findUserByUsername(username);//user정보 조회
        //출퇴근상태체크
        if ((user.getWork().equals("출근"))) {
            return "이미 출근중이십니다.";
        }
        //유저 상태값 수정
        setStart(user);//user출퇴근 상태값 변경
        //출퇴근 기록저장
        Commute commute = new Commute(username, user.getName(), now, work);
        commuteRepository.save(commute);
        return now.format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
    }
    @Transactional
    //퇴근 메서드
    public String finish(String username) {
        LocalDateTime now = LocalDateTime.now();
        String work = "퇴근";
        User user = userRepository.findUserByUsername(username);
        //출퇴근상태체크
        if ((user.getWork().equals("퇴근"))) {
            return "이미 퇴근중이십니다.";
        }
        //유저 상태값 수정
        setFinish(user);
        //출퇴근 기록저장
        Commute commute = new Commute(username, user.getName(), now, work);
        commuteRepository.save(commute);
        return now.format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
    }

    //출퇴근 상태값을 수정해주는 메서드
    public String setStart(User user) {
        user.setWork("출근");
        userRepository.save(user);
        return "출근 완료";
    }
    public String setFinish(User user) {
        user.setWork("퇴근");
        userRepository.save(user);
        return "퇴근 완료";
    }
    @Transactional
    public List<Commute> getCommuteList(String username) {
        User user = userRepository.findUserByUsername(username);
        //일반 사원일 경우
        if(user.getRole().equals("NORMAL")){
            return commuteRepository.findAllByUsername(username);
        }
        return commuteRepository.findAll();
    }
}


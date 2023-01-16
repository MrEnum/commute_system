package com.example.commute_system.service;


import com.example.commute_system.domain.Commute;
import com.example.commute_system.domain.User;
import com.example.commute_system.repository.CommuteRepository;
import com.example.commute_system.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.format.DateTimeFormatter;
import javax.transaction.Transactional;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.Date;
import java.util.List;

@Service
@RequiredArgsConstructor
public class CommuteService {
    private final CommuteRepository commuteRepository;
    private final UserRepository userRepository;


    @Transactional
    //출근 메서드
    public String start(String username) throws SQLException {
        System.out.println(username);
        LocalDateTime now = LocalDateTime.now();
        String work = "출근";
        User user = userRepository.findUserByUsername(username);//user정보 조회
        //매니저,사원 체크
        if (user.getWork() == null) {
            return "관리자는 출퇴근할 수 없습니다.";
        }
        //출퇴근상태체크
        if ((user.getWork().equals("출근"))) {
            //퇴근 버튼을 안눌렀을 시 퇴근시간 6시로 퇴근
            if (checkTime(username) == -1) {
                LocalDateTime localDateTime = LocalDateTime.of(now.getYear(), now.getMonth(), (now.getDayOfMonth() - 1), 18, 0);
                Commute commute = new Commute(username, user.getName(), localDateTime, "퇴근");
                commuteRepository.save(commute);
            } else {
                System.out.println("이미 출근중이십니다.");
                return "이미 출근중이십니다.";
            }
        }

        //유저 상태값 수정, 총 일 수 값++
        setStart(user, username);
        //출퇴근 기록저장
        Commute commute = new Commute(username, user.getName(), now, work);
        commuteRepository.save(commute);
        return "현재시간 : " + now.format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
    }


    @Transactional
    //퇴근 메서드
    public String finish(String username) {
        LocalDateTime now = LocalDateTime.now();
        String work = "퇴근";
        User user = userRepository.findUserByUsername(username);
        //매니저,사원 체크
        if (user.getWork() == null) {
            return "관리자는 출퇴근할 수 없습니다.";
        }
        //출퇴근상태체크
        if ((user.getWork().equals("퇴근"))) {
            return "이미 퇴근중이십니다.";
        }

        //유저 상태값 수정
        setFinish(user);
        //출퇴근 기록저장
        Commute commute = new Commute(username, user.getName(), now, work);
        commuteRepository.save(commute);
        return "현재시간 : " + now.format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
    }

    //출퇴근 상태값을 수정해주는 메서드
    public String setStart(User user, String username) {
        user.setWork("출근");
        //일 체크해서 totaldate 추가
        if (checkTime(username) == -1) {
            System.out.println("체크 중");
            user.setTotaldate();
        }
        userRepository.save(user);
        return "출근 완료";
    }

    public String setFinish(User user) {
        user.setWork("퇴근");
        userRepository.save(user);
        return "퇴근 완료";
    }


    //기본 탐색
    @Transactional
    public Page<Commute> getCommuteList(String role, String username, int page, int size, String sortBy, boolean isAsc) {
        Sort.Direction direction = isAsc ? Sort.Direction.ASC : Sort.Direction.DESC;
        Sort sort = Sort.by(direction, sortBy);
        Pageable pageable = PageRequest.of(page, size, sort);//pageable객체를 인스턴스화해준다.

        //일반 사원일 경우
        if (role.equals("ROLE_NORMAL")) {
            return commuteRepository.findAllByUsernameOrderByIdDesc(username, pageable);
        } else {
            return commuteRepository.findAll(pageable);
        }
    }

//    @Transactional
//    public List<Commute> getCommuteList(String role, String username) {
//
//
//        //일반 사원일 경우
//        if (role.equals("ROLE_NORMAL")) {
//            return commuteRepository.findAllByUsernameOrderByIdDesc(username);
//        } else {
//            return commuteRepository.findAll();
//        }
//    }


    //유저 검색
    @Transactional
    public Page<Commute> getCommuteListUserDetail(String role, String otherUsername, String startDate, String endDate, int page, int size, String sortBy, boolean isAsc) throws ParseException {
        Sort.Direction direction = isAsc ? Sort.Direction.ASC : Sort.Direction.DESC;
        Sort sort = Sort.by(direction, sortBy);
        Pageable pageable = PageRequest.of(page, size, sort);//pageable객체를 인스턴스화해준다.

        //Date타입으로 만듬
        SimpleDateFormat transformat = new SimpleDateFormat("yyyy-MM-dd-hh-mm-ss");
        Date startDate2 = transformat.parse(startDate);
        Date endDate2 = transformat.parse(endDate);
        //Date타입 LocalDateTime타입으로 변환
        LocalDateTime startDateTime = startDate2.toInstant() // Date -> Instant
                .atZone(ZoneId.systemDefault()) // Instant -> ZonedDateTime
                .toLocalDateTime(); // ZonedDateTime -> LocalDateTime;
        LocalDateTime endDateTime = endDate2.toInstant() // Date -> Instant
                .atZone(ZoneId.systemDefault()) // Instant -> ZonedDateTime
                .toLocalDateTime(); // ZonedDateTime -> LocalDateTime;

        if (role.equals("ROLE_MANAGER")) {
            return commuteRepository.findAllByNameAndLocalDateTimeNowBetweenOrderByIdDesc(otherUsername, startDateTime, endDateTime, pageable);
        } else {
            System.out.println("매니저가 아닙니다.");
            return null;
        }
    }

    //날짜 검색
    @Transactional
    public Page<Commute> getCommuteListDetail(String role, String name, String startDate, String endDate, int page, int size, String sortBy, boolean isAsc) throws ParseException {

        Sort.Direction direction = isAsc ? Sort.Direction.ASC : Sort.Direction.DESC;
        Sort sort = Sort.by(direction, sortBy);
        Pageable pageable = PageRequest.of(page, size, sort);//pageable객체를 인스턴스화해준다.

        //Date타입으로 만듬
        SimpleDateFormat transformat = new SimpleDateFormat("yyyy-MM-dd-hh-mm-ss");
        Date startDate2 = transformat.parse(startDate);
        Date endDate2 = transformat.parse(endDate);
        //Date객체를 LocalDateTime객체로 변환
        LocalDateTime startDateTime = startDate2.toInstant() // Date -> Instant
                .atZone(ZoneId.systemDefault()) // Instant -> ZonedDateTime
                .toLocalDateTime(); // ZonedDateTime -> LocalDateTime;
        LocalDateTime endDateTime = endDate2.toInstant() // Date -> Instant
                .atZone(ZoneId.systemDefault()) // Instant -> ZonedDateTime
                .toLocalDateTime(); // ZonedDateTime -> LocalDateTime;

        //일반 사원일 경우
        if (role.equals("ROLE_NORMAL")) {
            return commuteRepository.findAllByNameAndLocalDateTimeNowBetweenOrderByIdDesc(name, startDateTime, endDateTime, pageable);
        } else {
            return commuteRepository.findAllByLocalDateTimeNowBetweenOrderByIdDesc(startDateTime, endDateTime, pageable);
        }
    }


    //마지막 시간 값이 어제였는지 확인
    @Transactional
    public int checkTime(String username) {
        //마지막 시간
        int lastTime;
        if (commuteRepository.findFirstByUsernameOrderByLocalDateTimeNowDesc(username) == null) {
            lastTime = 0;
        } else {
            lastTime = commuteRepository.findFirstByUsernameOrderByLocalDateTimeNowDesc(username).getLocalDateTimeNow().getDayOfMonth();
        }
        //현재시간
        int nowDate = LocalDateTime.now().getDayOfMonth();
        System.out.println("lastDate : " + lastTime + "  nowDate : " + nowDate);
        if (lastTime == nowDate) {
            return 0;
        } else {
            return -1;
        }

    }

    //출퇴근 유저 검색

}


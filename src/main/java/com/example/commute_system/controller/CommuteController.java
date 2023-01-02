package com.example.commute_system.controller;

import com.example.commute_system.domain.Commute;
import com.example.commute_system.service.CommuteService;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Component;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.sql.SQLException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

@RestController
@Component
public class CommuteController {

    private final CommuteService commuteService;

    public CommuteController(CommuteService commuteService) {
        this.commuteService = commuteService;
    }

    LocalDateTime localDateTime;

    //@SessionAttribute(name = "loginMember", required = false) 이미 로그인 된 사람을 대상으로 씀


    //출근
    @PostMapping("/normal/start")
    public String startWork(Authentication authentication) throws SQLException {

        return commuteService.start(authentication.getName());
    }

    //퇴근
    @PostMapping("/normal/finish")
    public String finishWork(Authentication authentication) {

        return commuteService.finish(authentication.getName());
    }

//    @GetMapping("/list")
//    public String goList(){
//        return "redirect:commute_list";
//    }


    //리스트 조회

}

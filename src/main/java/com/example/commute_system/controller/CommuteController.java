package com.example.commute_system.controller;

import com.example.commute_system.service.CommuteService;
import org.springframework.stereotype.Component;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import java.time.LocalDateTime;

@RestController
@Component
public class CommuteController {

    private final CommuteService commuteService;

    public CommuteController(CommuteService commuteService) {
        this.commuteService = commuteService;
    }


    //@SessionAttribute(name = "loginMember", required = false) 이미 로그인 된 사람을 대상으로 씀


    //출근
    @PostMapping("/commute/start")
    public LocalDateTime startWork(@RequestBody String username) {

        return commuteService.start(username);
    }

    //퇴근
    @PostMapping("/commute/finish")
    public LocalDateTime finishWork(@RequestBody String username) {

        return commuteService.finish(username);
    }
}

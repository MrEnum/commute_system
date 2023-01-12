package com.example.commute_system.controller;

import com.example.commute_system.service.CommuteService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;


@Slf4j
@Controller
@RequiredArgsConstructor
public class PageController {
    private final CommuteService commuteService;




    //잘못된 접근
    @GetMapping("/signup/failure")
    public String failureSignup() {

        return "failure_signup";
    }
}

package com.example.commute_system.controller;

import com.example.commute_system.domain.UserDetail;
import com.example.commute_system.service.CommuteService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;


@Slf4j
@Controller
@RequiredArgsConstructor
public class PageController {
    private final CommuteService commuteService;


    //출퇴근 기록 열람
    @GetMapping("/commute_list")
    public String commuteList(Model model, Authentication authentication) {
        UserDetail userDetail = (UserDetail) authentication.getPrincipal();
        log.info("출퇴근 기록 열람 / 이름 : " + userDetail.getName());

        String role = userDetail.getRole();


        model.addAttribute("role", role);
        return "commute_list";
    }




    //잘못된 접근
    @GetMapping("/signup/failure")
    public String failureSignup() {

        return "failure_signup";
    }
}

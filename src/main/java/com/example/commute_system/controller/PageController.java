package com.example.commute_system.controller;

import com.example.commute_system.domain.Commute;
import com.example.commute_system.domain.UserDetail;
import com.example.commute_system.service.CommuteService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;


@Slf4j
@Controller
@RequiredArgsConstructor
public class PageController {
    private final CommuteService commuteService;

    //출퇴근 기록 페이지
    @GetMapping("/commute_list")
    public String commuteList(Model model, Authentication authentication
                              ) {
        String username = authentication.getName();

        log.info("출퇴근 기록 열람 / 이름 : " + username);
        UserDetail userDetail = (UserDetail) authentication.getPrincipal();
        String role = userDetail.getRole();
        List<Commute> list = commuteService.getCommuteList(role, username);
        model.addAttribute("list", list);
        model.addAttribute("role", role);
        return "commute_list";
    }

    //잘못된 접근
    @GetMapping("/signup/failure")
    public String failureSignup() {

        return "failure_signup";
    }
}

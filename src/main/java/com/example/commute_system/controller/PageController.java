package com.example.commute_system.controller;

import com.example.commute_system.domain.Commute;
import com.example.commute_system.service.CommuteService;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import java.util.Date;
import java.util.List;

@Controller
@RequiredArgsConstructor
public class PageController {
    private final CommuteService commuteService;




    @GetMapping("/commute_list")
    public String commuteList(Model model, Authentication authentication) {
        List<Commute> list = commuteService.getCommuteList(authentication.getName());
        model.addAttribute("list", list);

        return "commute_list";
    }
    @GetMapping("/commute_list/detail")
    public String commuteListDetail(Model model, Authentication authentication , Date startDate, Date endDate) {
        List<Commute> list = commuteService.getCommuteListDetail(authentication.getName(), startDate, endDate);
        model.addAttribute("list", list);
        System.out.println("start : " + startDate + ", end : " + endDate);


        return "commute_list";
    }
    @GetMapping("/signup/failure")
    public String failureSignup() {

        return "failure_signup";
    }
}

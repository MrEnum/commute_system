package com.example.commute_system.controller;

import com.example.commute_system.domain.Commute;
import com.example.commute_system.service.CommuteService;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import java.util.List;

@Controller
@RequiredArgsConstructor
public class PageController {
    private final CommuteService commuteService;



    //리스트 페이지 가져오기
//    @GetMapping("/commute_list")
//    public String getCommutePage(){
//        return "commute_list";
//    }
    @GetMapping("/commute_list")
    public String commuteList(Model model, Authentication authentication) {
        List<Commute> list = commuteService.getCommuteList(authentication.getName());
        model.addAttribute("list", list);

        return "commute_list";
    }
}

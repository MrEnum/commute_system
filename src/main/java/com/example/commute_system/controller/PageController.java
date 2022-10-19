package com.example.commute_system.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class PageController {
    //리스트 페이지 가져오기
    @GetMapping("/commute_list")
    public String getCommutePage(){
        return "commute_list";
    }
}

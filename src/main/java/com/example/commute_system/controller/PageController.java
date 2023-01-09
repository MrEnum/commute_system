package com.example.commute_system.controller;

import com.example.commute_system.domain.Commute;
import com.example.commute_system.service.CommuteService;
import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.RequiredArgsConstructor;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.time.LocalDateTime;
import java.util.Date;
import java.util.List;

@Controller
@RequiredArgsConstructor
public class PageController {
    private final CommuteService commuteService;




    @GetMapping("/commute_list")
    public String commuteList(Model model, Authentication authentication, Date startDate,  Date endDate) {

            List<Commute> list = commuteService.getCommuteList(authentication.getName());
            model.addAttribute("list", list);


        return "commute_list";
    }

    @ResponseBody
    @GetMapping("/commute_list/detail")
    public List<Commute> getListDetail(Authentication authentication, Date startDate,  Date endDate){
        System.out.println("start : " + startDate + ", end : " + endDate);
        List<Commute> listDetail = commuteService.getCommuteListDetail(authentication.getName(), startDate, endDate);

//        model.addAttribute("listDetail", listDetail);
        for (Commute lists:listDetail){
            System.out.println(lists.getLocalDateTimeNow() + " : " +  lists.getId() );
        }
        return listDetail;
    }

    @GetMapping("/signup/failure")
    public String failureSignup() {

        return "failure_signup";
    }
}

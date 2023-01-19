package com.example.commute_system.controller;

import com.example.commute_system.domain.Commute;
import com.example.commute_system.domain.UserDetail;
import com.example.commute_system.service.CommuteService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.domain.Page;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Component;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.sql.SQLException;
import java.text.ParseException;

@Slf4j
@RestController
@Component
public class CommuteController {

    private final CommuteService commuteService;


    public CommuteController(CommuteService commuteService) {
        this.commuteService = commuteService;
    }

    //@SessionAttribute(name = "loginMember", required = false) 이미 로그인 된 사람을 대상으로 씀
    //출근
    @PostMapping("/normal/start")
    public String startWork(Authentication authentication) throws SQLException {
        log.info("출근했습니다. 이름 : " + authentication.getName());
        return commuteService.start(authentication.getName());
    }

    //퇴근
    @PostMapping("/normal/finish")
    public String finishWork(Authentication authentication) {
        log.info("퇴근했습니다. 이름 : " + authentication.getName());
        return commuteService.finish(authentication.getName());
    }


    //출퇴근 기록 날짜 검색
    @DateTimeFormat(pattern = "yyyy-MM-dd-hh-mm-ss")
    @ResponseBody
    @GetMapping("/commute_list/detail")
    public Page<Commute> getListDetail(Model model, Authentication authentication, String startDate, String endDate,
                                       @RequestParam("page") int page,
                                       @RequestParam("size") int size,
                                       @RequestParam("sortBy") String sortBy,
                                       @RequestParam("isAsc") boolean isAsc) throws ParseException {
        log.info("날짜 검색 : " + startDate + " ~ " + endDate);
        UserDetail userDetail = (UserDetail) authentication.getPrincipal();
        page = page - 1;

        Page<Commute> commutePage = commuteService.getCommuteListDetail(userDetail.getRole(), userDetail.getName(), startDate, endDate, page, size, sortBy, isAsc);
        model.addAttribute("pageRange", commutePage.getTotalPages());
        return commutePage;
    }

    //유저검색
    @ResponseBody
    @GetMapping("/commute_list/userdetail")
    public Page<Commute> getListUserDetail(Authentication authentication, String otherUsername, String startDate, String endDate,
                                           @RequestParam("page") int page,
                                           @RequestParam("size") int size,
                                           @RequestParam("sortBy") String sortBy,
                                           @RequestParam("isAsc") boolean isAsc) throws ParseException {
        log.info("사원 검색 : " + otherUsername);
        UserDetail userDetail = (UserDetail) authentication.getPrincipal();
        page = page - 1;
        if (otherUsername.equals("")) {
            return commuteService.getCommuteListDetail(userDetail.getRole(), userDetail.getName(), startDate, endDate, page, size, sortBy, isAsc);
        } else {
            return commuteService.getCommuteListUserDetail(userDetail.getRole(), otherUsername, startDate, endDate, page, size, sortBy, isAsc);
        }
    }


    //다가져와
    @ResponseBody
    @GetMapping("/commute_list/all")
    public Page<Commute> commuteList(Model model, Authentication authentication,
                                     @RequestParam("page") int page,
                                     @RequestParam("size") int size,
                                     @RequestParam("sortBy") String sortBy,
                                     @RequestParam("isAsc") boolean isAsc
    ) {
        String username = authentication.getName();
        page = page - 1;
        log.info("출퇴근 기록 열람 / 이름 : " + username);
        UserDetail userDetail = (UserDetail) authentication.getPrincipal();
        String role = userDetail.getRole();
        Page<Commute> commutePage = commuteService.getCommuteList(role, username, page, size, sortBy, isAsc);
        model.addAttribute("pageRange", commutePage.getTotalPages());

        return commutePage;
    }
}

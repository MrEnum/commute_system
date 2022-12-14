package com.example.commute_system.controller;

import com.example.commute_system.domain.Commute;
import com.example.commute_system.domain.UserDetail;
import com.example.commute_system.service.CommuteService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.domain.Page;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.parameters.P;
import org.springframework.stereotype.Component;
import org.springframework.web.bind.annotation.*;

import java.sql.SQLException;
import java.util.Date;
import java.util.List;

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
    @ResponseBody
    @GetMapping("/commute_list/detail")
    public Page<Commute> getListDetail(Authentication authentication, Date startDate, Date endDate,
                                       @RequestParam("page") int page,
                                       @RequestParam("size") int size,
                                       @RequestParam("psortBy") String sortBy,
                                       @RequestParam("isAsc") boolean isAsc) {
        log.info("날짜 검색 : " + startDate + " ~ " + endDate);
        UserDetail userDetail = (UserDetail) authentication.getPrincipal();
        page = page - 1;
        return commuteService.getCommuteListDetail(userDetail.getRole(), userDetail.getName(), startDate, endDate, page, size, sortBy, isAsc);
    }

    //유저검색
    @ResponseBody
    @GetMapping("/commute_list/userdetail")
    public Page<Commute> getListUserDetail(Authentication authentication, String otherUsername, Date startDate, Date endDate,
                                           @RequestParam("page") int page,
                                           @RequestParam("size") int size,
                                           @RequestParam("psortBy") String sortBy,
                                           @RequestParam("isAsc") boolean isAsc) {
        log.info("사원 검색 : " + otherUsername);
        UserDetail userDetail = (UserDetail) authentication.getPrincipal();
        page = page - 1;
        if (otherUsername.equals("")) {
            return commuteService.getCommuteListDetail(userDetail.getRole(), userDetail.getName(), startDate, endDate, page, size, sortBy, isAsc);
        } else {
            return commuteService.getCommuteListUserDetail(userDetail.getRole(), otherUsername, startDate, endDate, startDate, endDate, page, size, sortBy, isAsc);
        }
    }

}

package com.example.commute_system.controller;

import com.example.commute_system.domain.Commute;
import com.example.commute_system.domain.UserDetail;
import com.example.commute_system.service.CommuteService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Component;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

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

    //출퇴근 기록 조회
    @GetMapping("/commute_list")
    public String commuteList(Model model, Authentication authentication) {
        log.info("출퇴근 기록 열람 / 이름 : " + authentication.getName());
        List<Commute> list = commuteService.getCommuteList(authentication.getName());
        model.addAttribute("list", list);


        return "commute_list";
    }

    //출퇴근 기록 날짜 검색
    @ResponseBody
    @GetMapping("/commute_list/detail")
    public List<Commute> getListDetail(Authentication authentication, Date startDate, Date endDate) {
        log.info("날짜 검색 : " + startDate + " ~ " + endDate);
        List<Commute> listDetail = commuteService.getCommuteListDetail(authentication.getName(), startDate, endDate);
        return listDetail;
    }

    @ResponseBody
    @GetMapping("/commute_list/userdetail")
    public List<Commute> getListUserDetail(Authentication authentication, String otherUsername) {
        log.info("사원 검색 : " + otherUsername);
        UserDetail userDetail = (UserDetail) authentication.getPrincipal();

        List<Commute> listDetail = commuteService.getCommuteList(otherUsername);
        return listDetail;
    }
}

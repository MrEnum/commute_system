package com.example.commute_system.controller;

import com.example.commute_system.domain.User;
import com.example.commute_system.domain.UserDetail;
import com.example.commute_system.service.UserService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

@Controller
@RequiredArgsConstructor
@Slf4j
public class UserController {
    private final UserService userService;


    /**
     * 회원가입 폼
     *
     * @return
     */

    @GetMapping("/manager/signup")
    public String signUpForm() {
        return "signup";
    }

    /**
     * 회원가입 진행
     *
     * @param user
     * @return
     */

    @PostMapping("/manager/signup")
    public String signup(User user) {
        user.setRole(user.getRole());
        userService.joinUser(user);
        return "redirect:/";
    }

    /**
     * 유저 페이지
     *
     * @param model
     * @param authentication
     * @return
     */
    @GetMapping("/")
    public String loginAccess(Model model, Authentication authentication) {
        if (authentication == null) {
            return "redirect:/login";
        } else {
            //Authentication 객체를 통해 유저 정보를 가져올 수 있다.
            UserDetail userDetail = (UserDetail) authentication.getPrincipal();  //userDetail 객체를 가져옴
            model.addAttribute("username", userDetail.getUsername());      //유저 아이디
            model.addAttribute("totaldate", userDetail.getTotaldate());      //유저 아이디
            System.out.println("보냈습니다." + userDetail.getUsername());
            return "index";
        }

    }
}
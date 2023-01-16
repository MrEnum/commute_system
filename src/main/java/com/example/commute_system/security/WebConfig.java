package com.example.commute_system.security;

import com.example.commute_system.service.UserService;
import lombok.RequiredArgsConstructor;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;


@EnableWebSecurity        //spring security 를 적용한다는 Annotation
@RequiredArgsConstructor
public class WebConfig extends WebSecurityConfigurerAdapter {
    private final UserService userService;


    @Override
    protected void configure(HttpSecurity http) throws Exception {
        http.authorizeRequests()
                .antMatchers("/index","/commute_list/**").hasAnyRole("NORMAL", "MANAGER")
                .antMatchers("/manager/signup").hasRole("MANAGER")
                .antMatchers("/chatroom").hasAnyRole("NORMAL","MANAGER")
                .and()
                .formLogin()
                .permitAll()
//                .defaultSuccessUrl("/index")//로그인 성공시 url
//                .failureUrl("/login/failure")//로그인 실패시 url
                .and()
                .csrf().disable()        //로그인 창
                // [로그아웃 기능]
                .logout()
                // 로그아웃 처리 URL
                .logoutUrl("/user/logout")
                .permitAll()
                .and()
                .exceptionHandling()
                .accessDeniedHandler(new CustomAccessDeniedHandler());
    }
//    configure(HttpSecurity http)
//    이 메소드는 HttpSecurity 객체를 이용해 각 요청을 먼저 intercept하여 URL별 인증 여부, login 처리, logout아웃 처리등 다양한 처리를 할 수 있다.
//
//      - antMachers : 각 URL 요청에 대한 접근 여부를 설정한다. 위 같은 경우 /userAccess에 접근할 경우 hasRole()을 통해 USER라는 권한을 가진 유저만 접근할 수 있다.
//      anonymous()은 인증되지 않은 즉, 로그인 되지 않은 사용자만 접근 가능하다.
//      - formLogin() : spring security에서 제공하는 login form을 이용한다는 뜻. 로그인 성공시 '/'로 리다이렉트
//      - csrf() : 웹 사이트의 취약점을 이용한 의도치 않은 요청을 통한 공격을 의미한다. 이 기능을 disable한 상태이다.


    @Override
    public void configure(AuthenticationManagerBuilder auth) throws Exception {
        auth.userDetailsService(userService).passwordEncoder(new BCryptPasswordEncoder());
    }
}


package com.example.commute_system.security;

import com.example.commute_system.service.UserService;
import lombok.RequiredArgsConstructor;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;


@EnableWebSecurity        //spring security 를 적용한다는 Annotation
@RequiredArgsConstructor
public class WebConfig extends WebSecurityConfigurerAdapter {
    private final UserService userService;

    /**
     * 규칙 설정
     *
     * @param http
     * @throws Exception
     */
    @Override
    protected void configure(HttpSecurity http) throws Exception {
        http.authorizeRequests()
                .antMatchers("/userAccess").hasRole("USER")
                .antMatchers("/signUp").anonymous()
                .and()
                .formLogin()
                .and()
                .csrf().disable();        //로그인 창
    }

    /**
     * 로그인 인증 처리 메소드
     *
     * @param auth
     * @throws Exception
     */

    @Override
    public void configure(AuthenticationManagerBuilder auth) throws Exception {
        auth.userDetailsService(userService).passwordEncoder(new BCryptPasswordEncoder());
    }
}


package com.example.commute_system.security;

import com.example.commute_system.service.UserDetailsServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;

@Configuration
@EnableWebSecurity
public class WebConfig extends WebSecurityConfigurerAdapter {
    private final UserDetailsServiceImpl userDetailsService;

    public WebConfig(UserDetailsServiceImpl userDetailsService) {
        this.userDetailsService = userDetailsService;
    }

    @Override
    protected void configure(HttpSecurity http) throws Exception {
        http
                .authorizeRequests()
                .antMatchers("/login", "/singUp", "/access_denied", "/resources/**").permitAll() // 로그인 권한은 누구나, resources파일도 모든권한
                // USER, ADMIN 접근 허용
                .antMatchers("/userAccess").hasRole("USER")
                .antMatchers("/userAccess").hasRole("ADMIN")
                .and()
                .formLogin()
                .loginPage("/login")
                .loginProcessingUrl("/login_proc")
                .defaultSuccessUrl("/user_access")
                .failureUrl("/access_denied") // 인증에 실패했을 때 보여주는 화면 url, 로그인 form으로 파라미터값 error=true로 보낸다.
                .and()
                .csrf().disable();        //로그인 창
    }


//    @Override
//    protected void configure(HttpSecurity http) throws Exception {
//        // 다음 경로에 대한 요청은 인증 없이 접근을 허용하도록 설정한다.
//        http.authorizeRequests().antMatchers("/", "/auth/**", "/js/**", "/image/**", "/webjars/**", "/login").permitAll();
//        // 위에서 언급한 경로 외에는 모두 인증을 거치도록 설정한다.
//        http.authorizeRequests().anyRequest().authenticated();
//
//        // 시큐리티가 제공하는 기본 로그인 화면은 CSRF 토큰을 무조건 전달한다.
//        // 하지만 사용자 정의 로그인 화면에서는 CSRF 토큰을 전달하지 않는다.
//        http.csrf().disable();
//
//        // 사용자가 만든 로그인 화면을 띄운다.
//        http.formLogin().loginPage("/login");
//
//        //로그아웃 설정
//        http.logout().logoutUrl("/auth/logout").logoutSuccessUrl("/");
//
//    }


    @Override
    protected void configure(AuthenticationManagerBuilder auth) throws Exception {
        auth.userDetailsService(userDetailsService);
    }
}

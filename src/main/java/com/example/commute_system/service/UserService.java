package com.example.commute_system.service;

import com.example.commute_system.domain.User;
import com.example.commute_system.domain.UserDetail;
import com.example.commute_system.repository.UserRepository;
import groovy.util.logging.Slf4j;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;


//UserDetailService 인터페이스는 DB에서 유저 정보를 불러오는 메소드인 loadUserByUsername()이 있다.
// 이 메소드 구현을 통해 DB에서 유저 정보를 불러온다.
@Service
@RequiredArgsConstructor
@Slf4j
public class UserService implements UserDetailsService {
    private final UserRepository repository;


    //회원가입
    @Transactional
    public void joinUser(User user){
        BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
        user.setPassword(passwordEncoder.encode(user.getPassword()));
        repository.save(user);
    }


    @Override
    public UserDetails loadUserByUsername(String email) throws UsernameNotFoundException {
        //여기서 받은 유저 패스워드와 비교하여 로그인 인증
        User user = repository.findUserByUsername(email);
        return new UserDetail(user);
    }
}
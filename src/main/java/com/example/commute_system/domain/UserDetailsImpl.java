package com.example.commute_system.domain;


import lombok.Getter;
import lombok.Setter;

import java.util.ArrayDeque;
import java.util.Collection;

@Getter
@Setter
public class UserDetailsImpl {// implements UserDetails
//    // User 엔티티 타입의 참조변수 선언
//    private User user;
//
//    public UserDetailsImpl(User user) {this.user = user;}
//
//    // User Entity가 가지고 있는 권한 목록을 저장하여 리턴한다.
//    @Override
//    public Collection<? extends GrantedAuthority> getAuthorities() {
//        // 권한 목록을 저장할 컬렉션
//        Collection<GrantedAuthority> roleList = new ArrayDeque<>();
//
//        //권한설정
//        roleList.add(new GrantedAuthority() {
//            @Override
//            public String getAuthority() {
//                return "ROLE_" + user.getRole();
//            }
//        });
//        return roleList;
//    }
//
//    @Override
//    public String getPassword() {
//        // {noop}은 비밀번호를 암호화하지 않도록 하는 접두사다.
//        return "{noop}" + user.getPassword();
//    }
//
//    @Override
//    public String getUsername() {
//        return user.getUsername();
//    }
//    // 계정이 만료됐는지 여부를 리턴한다.
//    @Override
//    public boolean isAccountNonExpired() {
//        return true;
//    }
//    // 계정이 잠겨있는지 여부를 리턴한다.
//    @Override
//    public boolean isAccountNonLocked() {
//        return true;
//    }
//    // 비밀번호가 만료됐는지 여부를 리턴한다.
//    @Override
//    public boolean isCredentialsNonExpired() {
//        return true;
//    }
//    // 계정의 활성화 여부를 리턴한다.
//    @Override
//    public boolean isEnabled() {
//        return true;
//    }

//    UserDetails를 상속받아 오버라이드한 메소드를 설정하여 DB에 저장된 계정으로 로그인할 수 있다.
//    정확히는 다음 과정까지 거쳐야 완벽하게 로그인 할 수 있다.
//    UserDetails는 입력받은 User객체가 정상 로그인 할 수 있는지 확인하는 클래스이다.
}

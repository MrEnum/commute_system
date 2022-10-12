package com.example.commute_system.domain;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import javax.persistence.*;
import java.time.LocalDateTime;
import java.util.Optional;

@Entity(name = "commute_table")
@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
public class Commute {


    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @Column(name = "USERNAME", nullable = false)
    private String username;

    @Column(name = "NAME", nullable = false)
    private String name;



    //나중에 테이블 추가할 것
//    @JoinColumn(name = "USER_ID")
//    @ManyToOne
//    private User user;
    @Column(name = "WORK")
    private String work = "";

    @Column(name="LOCALDATETIMENOW", nullable = false)
    private LocalDateTime localDateTimeNow;

    //    Commute(String name, LocalDateTime localDateTime, User user, int work){
//        this.name = user.getName();
//        this.localDateTime = localDateTime;
//        this.user = user;
//        this.work = work;
//    }
    public Commute(String username, String name, LocalDateTime localDateTimeNow, String work) {
        this.username = username; // 나중엔 바꿔줘야함
        this.name = name;
        this.localDateTimeNow = localDateTimeNow;
        this.work = work;
    }



}

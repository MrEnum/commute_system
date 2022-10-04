package com.example.commute_system.domain;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import javax.persistence.*;
import java.time.LocalDateTime;

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
    private String name;

    @Column(name="LOCALDATETIMENOW", nullable = false)
    private String localDateTimeNow;

    //나중에 테이블 추가할 것
//    @JoinColumn(name = "USER_ID")
//    @ManyToOne
//    private User user;

    @Column(name = "WORK")
    private int work = 0;


    //    Commute(String name, LocalDateTime localDateTime, User user, int work){
//        this.name = user.getName();
//        this.localDateTime = localDateTime;
//        this.user = user;
//        this.work = work;
//    }
    public Commute(String username, String localDateTimeNow, int work) {
        this.name = username; // 나중엔 바꿔줘야함
        this.localDateTimeNow = localDateTimeNow;
        this.work = work;
    }

}

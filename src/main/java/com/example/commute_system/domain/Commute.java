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

    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Id
    private int Id;

    @Column
    private String name;

    @Column
    private String localDateTimeNow;

    @JoinColumn(name = "user_code")
    @ManyToOne
    private User user;

    @Column
    private int work;


    //    Commute(String name, LocalDateTime localDateTime, User user, int work){
//        this.name = user.getName();
//        this.localDateTime = localDateTime;
//        this.user = user;
//        this.work = work;
//    }
    public Commute(String name, String localDateTimeNow, int work) {
        this.name = user.getName();
        this.localDateTimeNow = localDateTimeNow;
        this.work = work;
    }

}

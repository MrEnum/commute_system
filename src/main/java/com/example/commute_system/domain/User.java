package com.example.commute_system.domain;

import com.example.commute_system.service.CommuteService;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import javax.persistence.*;

@Entity(name = "User_table")
@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
public class User {


    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @Column
    private String username;

    @Column
    private String password;

    @Column
    private String role;

    @Column
    private String name;

    @Column
    private String work = "퇴근";

    @Column
    private int totaldate = 0;



    public void setWork(String work) {
        this.work = work;
    }
    public void setTotaldate(){
        this.totaldate++;
    }
}

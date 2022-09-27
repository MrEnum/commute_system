package com.example.commute_system.domain;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;

@Entity(name ="User_table")
@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
public class User {

    @Id
    private int usercode;

    @Column
    private String password;

    @Column
    private String username;

    @Column
    private Role role;

    @Column
    private int work = 0;


}

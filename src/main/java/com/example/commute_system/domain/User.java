package com.example.commute_system.domain;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import javax.persistence.*;

@Entity(name ="User_table")
@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
public class User {
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Id
    private int id;

    @Column
    private String password;

    @Column
    private String username;

    @Column
    private Role role;

    @Column
    private int work = 0;

    @Column
    private String name;


}

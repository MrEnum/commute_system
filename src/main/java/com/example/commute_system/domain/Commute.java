package com.example.commute_system.domain;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import javax.persistence.*;
import java.time.LocalDateTime;

@Entity
@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
public class Commute {


    @Id
    private int Id;

    @Column
    private String username;

    @Column
    private Work role;

    @Column
    private LocalDateTime localDateTime;

    @JoinColumn(name="user_code")
    @ManyToOne
    private User user;
}

package com.example.commute_system.dto;


import com.example.commute_system.domain.Commute;
import lombok.Getter;
import lombok.NoArgsConstructor;

import javax.persistence.Column;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import java.time.LocalDateTime;

@Getter
@NoArgsConstructor
public class CommuteDTO {
    private int id;
    private String username;
    private String name;
    private String work = "";

    public CommuteDTO(Commute commute){
        this.id = commute.getId();
        this.username = commute.getUsername();
        this.name = commute.getName();
        this.work = commute.getWork();
    }
}

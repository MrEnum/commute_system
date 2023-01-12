package com.example.commute_system.dto;


import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class UserResponseDto {
    private String username;
    private String password;
    private String role;
    private String name;

}

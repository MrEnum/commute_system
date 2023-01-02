package com.example.commute_system.dao;

import com.example.commute_system.domain.User;

import java.sql.*;
import java.time.LocalDateTime;

public class CommuteDAO {
    private Connection conn;
    private PreparedStatement pstmt;
    private ResultSet rs;

    public CommuteDAO() {
        try {
            String dbURL = "jdbc:mysql://localhost:3306/commute?allowPublicKeyRetrieval=true&useSSL=false";
            String dbID = "root";
            String dbPassword = "1111";
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    //총 시간에 더하기
    public int addTime(User user) {
        String SQL = "INSERT INTO USER VALUES(?, ?, ?, ?, ?)";
        try {
            pstmt = conn.prepareStatement(SQL);
            pstmt.setString(1, user.getUsername());
            pstmt.setString(2, user.getPassword());
            pstmt.setString(3, user.getName());

            return pstmt.executeUpdate(); // 0이상 값이 return된 경우 성공
        } catch (Exception e) {
            e.printStackTrace();

        }
        return -1; //DB 오류
    }

    //마지막 시간 값 가져오기
    public LocalDateTime getLastTime(String username) throws SQLException {
        try {
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/soochanDB?allowPublicKeyRetrieval=true&useSSL=false", "root", "1111");
            PreparedStatement pst = conn.prepareStatement("SELECT * FROM commute_table WHERE username = '?' ORDER BY localDateTimeNow DESC LIMIT 1");

            pst.setString(1, username);
            rs = pst.executeQuery();
            LocalDateTime lastTime = rs.getTimestamp("localDateTimeNow").toLocalDateTime();
            System.out.println(lastTime);
            return lastTime;

        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }




}

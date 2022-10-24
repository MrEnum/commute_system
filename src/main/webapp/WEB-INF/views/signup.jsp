<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="UTF-8" %>

<!--회원가입 페이지-->
<!--signup.jsp-->
<!DOCTYPE html>
<html xmlns:th="http://www.thymeleaf.org" lang="en">
<head>
    <meta charset="UTF-8">
</head>
<body>
<!--http 메소드, action태그 : 폼 데이터(form data)를 서버로 보낼 때 해당 데이터가 도착할 URL을 명시-->
<form method="post" action="signup">

    username : <input type="username" name="username">
    password : <input type="password" name="password">
    role : <input type="role" name="role">
    name : <input type="name" name="name">

    <button>회원가입</button>
</form>

<div>
    <a href="/">취소</a>
</div>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR" %>

<!--회원가입 페이지-->
<!--signup.html-->
<!DOCTYPE html>
<html xmlns:th="http://www.thymeleaf.org" lang="en">
<head>
    <meta charset="UTF-8">
</head>
<body>
<form method="post" action="/signUp">
    email : <input type="email" name="email">
    password : <input type="password" name="password">
    <button>회원가입</button>
</form>
</body>
</html>
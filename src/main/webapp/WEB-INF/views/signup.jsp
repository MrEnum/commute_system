<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR" %>

<!--ȸ������ ������-->
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
    <button>ȸ������</button>
</form>
</body>
</html>
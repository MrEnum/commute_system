<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="UTF-8" %>

<!--회원가입 페이지-->
<!--signup.jsp-->
<!DOCTYPE html>
<html xmlns:th="http://www.thymeleaf.org" lang="en">
<head>
    <meta charset="UTF-8">
</head>
<body style="text-align: center; /* Quirks Mode 를 위한 가운데 정렬 */
        width: 100%;
        padding: 0;
        margin: 0;
">
<!--http 메소드, action태그 : 폼 데이터(form data)를 서버로 보낼 때 해당 데이터가 도착할 URL을 명시-->
<form method="post" action="signup">

    username : <input type="username" name="username"><br>
    password : <input type="password" name="password"><br>
    role : <input type="role" name="role"><br>
    name : <input type="name" name="name"><br>

    <button>회원가입</button>
    <button>
        <a href="/">취소</a>
    </button>
</form>


</body>
</html>
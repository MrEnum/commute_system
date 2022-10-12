<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<!--로그인 페이지-->
<!-- login1.jsp-->
<!DOCTYPE html>
<!-- Latest compiled and minified CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<html xmlns:th="http://www.thymeleaf.org" lang="en">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
</head>
<body>
<div class="container">
    <h1>로그인</h1>
    <form th:action="@{/login_proc}" method="post">
        <div class="form-group">
            <label th:for="username">아이디</label>
            <input type="text" name="username" class="form-control" placeholder="아이디 입력해주세요">
        </div>
        <div class="form-group">
            <label th:for="password">비밀번호</label>
            <input type="password" class="form-control" name="password" placeholder="비밀번호 입력해주세요">
        </div>
        <button type="submit" class="btn btn-primary">로그인</button>
<!--        <button type="button" class="btn btn-primary" onClick="location.href='signUp'">회원 가입</button>-->
    </form>
    <br/>
</div>
</body>
</html>
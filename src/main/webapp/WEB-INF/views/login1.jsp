<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<!--�α��� ������-->
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
    <h1>�α���</h1>
    <form th:action="@{/login_proc}" method="post">
        <div class="form-group">
            <label th:for="username">���̵�</label>
            <input type="text" name="username" class="form-control" placeholder="���̵� �Է����ּ���">
        </div>
        <div class="form-group">
            <label th:for="password">��й�ȣ</label>
            <input type="password" class="form-control" name="password" placeholder="��й�ȣ �Է����ּ���">
        </div>
        <button type="submit" class="btn btn-primary">�α���</button>
<!--        <button type="button" class="btn btn-primary" onClick="location.href='signUp'">ȸ�� ����</button>-->
    </form>
    <br/>
</div>
</body>
</html>
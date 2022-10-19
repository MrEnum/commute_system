<%@ page contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Title</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
</head>

<body>
<div>
    <a href="/">Ȩ����</a>
</div>
<table class="table">
    <tr>
        <th>���̵�</th>
        <th>�̸�</th>
        <th>�����</th>
        <th>��¥�ð�</th>
    </tr>
    <tbody id="table1">
    <c:forEach var="list" items="${list}">
        <tr>
            <td>${list.username}</td>
            <td>${list.name}</td>
            <td>${list.work}</td>
            <td>${list.localDateTimeNow}</td>
        </tr>
    </c:forEach>
    </tbody>
</table>
<script>


</script>
</body>
</html>
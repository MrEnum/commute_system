<%@ page contentType="text/html;charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Title</title>

    <!--  부트스트랩 js 사용 -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
    <!-- 부트스트랩 css 사용 -->
    <link rel="stylesheet" href="/css/bootstrap.css">
</head>

<body>
<div>
    <a href="/">홈으로</a>
</div>
<table class="table">
    <tr>
        <th>아이디</th>
        <th>이름</th>
        <th>출퇴근</th>
        <th>날짜시간</th>
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
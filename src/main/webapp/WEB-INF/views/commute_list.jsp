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

    <style>
        th {
            border-style: solid;
        }

        td {
            border-style: solid;
        }

        body {
            text-align: center; /* Quirks Mode 를 위한 가운데 정렬 */
            width: 100%;
            padding: 0;
            margin: 0;
        }

        table {
            text-align: center; /* Quirks Mode 를 위한 가운데 정렬 */
            width: 100%;
            padding: 0;
            margin: 0;
        }
    </style>
</head>

<body>
<div style="padding: 0px 0PX 30px 0px;font-size:10px; margin-right: 50px; margin-left: 50px;">
<%--    홈으로--%>
    <a style="font-size: 30px; float: left; " href="/">홈으로</a>

    <!--로그아웃-->
    <form id="my_form" method="post" action="/user/logout" style="font-size: 30px; float: right;">
        <a id="logout-text" href="javascript:{}"
           onclick="document.getElementById('my_form').submit();">로그아웃</a>
    </form>
</div>


<div style="padding: 0px 0PX 50px 0px;font-size:20px;margin-right: 50px; margin-left: 50px;">
    <table class="table">
        <tr style="background-color: antiquewhite;">
            <th>아이디</th>
            <th>이름</th>
            <th>출퇴근</th>
            <th>날짜시간</th>
        </tr>
        <tbody id="table1">
        <c:forEach var="list" items="${list}">
            <td>${list.username}</td>
            <td>${list.name}</td>
            <c:choose>
                <c:when test="${list.work eq '출근' }">
                    <!-- Result값이 있다면 실행할 로직 -->
                    <td style="background-color: blue; color : white">${list.work}</td>
                </c:when>
                <c:otherwise>
                    <!-- 그렇지 않다면 실행할 로직 -->
                    <td style="background-color: red; color: white;">${list.work}</td>

                </c:otherwise>
            </c:choose>
            <td>${list.localDateTimeNow}</td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>

<script>


</script>

</body>
</html>
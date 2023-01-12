<%@ page contentType="text/html;charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>출퇴근 시간</title>

    <!--  부트스트랩 js 사용 -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>

    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
    <!-- 부트스트랩 css 사용 -->
    <link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">

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

        .commute-start {
            background-color: blue;
            color: white;

        }

        .commute-end {
            background-color: red;
            color: white;

        }
    </style>
</head>

<body>

<div>
    <p>
        <label> 시작 </label>
        <input type="text" id="datepicker_init_day" class="start-date" placeholder="초기날짜">
    </p>
    <p>
        <label> 끝 </label>
        <input type="text" id="datepicker_special_day" class="end-date" placeholder="특정날짜">
    </p>
    <button onclick="getCommuteListByDate()">검색</button>
</div>
<c:choose>
    <c:when test="${role eq 'ROLE_MANAGER'}">
        <div>
            <p>
                <label> 이름 검색 </label>
                <input type="text" id="name-search" class="name" placeholder="이름">
            </p>

            <button onclick="getCommuteListByName()">검색</button>

        </div>
    </c:when>
    <c:otherwise>

    </c:otherwise>
</c:choose>

<%--    홈으로--%>
<a style="font-size: 30px; float: left; padding-left: 25%; " href="/">홈으로</a>

<!--로그아웃-->
<form id="my_form" method="post" action="/user/logout" style="font-size: 30px; float: right; padding-right: 25%;">
    <a id="logout-text" href="javascript:{}"
       onclick="document.getElementById('my_form').submit();">로그아웃</a>
</form>
</div>


<div style="padding: 5% 0PX 50px 0px;font-size:90%;margin-right: 30%; margin-left: 30%;">
    <table class="table">
        <tr style="background-color: antiquewhite;">
            <th>아이디</th>
            <th>이름</th>
            <th>출/퇴근</th>
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

<script type="text/javascript">

    //비동기로 테이블 값 가져오기
    function getCommuteListByDate() {
        console.log("실행되긴함");

        let startYear = $('.start-date').datepicker('getDate').getFullYear();
        let startMonth = $('.start-date').datepicker('getDate').getMonth();
        let startDay = $('.start-date').datepicker('getDate').getDate();

        let endYear = $('.end-date').datepicker('getDate').getFullYear();
        let endMonth = $('.end-date').datepicker('getDate').getMonth();
        let endDay = $('.end-date').datepicker('getDate').getDate() + 1;

        let startdate

        const startDate = new Date(startYear, startMonth, startDay);
        const endDate = new Date(endYear, endMonth, endDay);
        console.log(startDate + " ~ " + endDate);

        $.ajax({
            type: 'GET',
            async: 'false', //비동기, false값이 기본이다.
            url: '/commute_list/detail',
            data: {
                "startDate": startDate,
                "endDate": endDate
            },
            contentType: "application/json; charset=utf-8;",
            success: function (response) {
                getList(response);
            },
            error: function () {
                alert("에러 발생");
            }
        });
    }


    //table뿌려주기
    function addHTML(listDetail, work) {
        if (work === "출근") {

            let html = "";
            html += '<tr>';
            html += '<td>' + listDetail.username + '</td>';
            html += '<td>' + listDetail.name + '</td>';
            html += '<td class="commute-start">' + listDetail.work + '</td>';
            html += '<td>' + listDetail.localDateTimeNow + '</td>';
            html += '</tr>';
            return html;
        } else {
            let html = "";
            html += '<tr >';
            html += '<td>' + listDetail.username + '</td>';
            html += '<td>' + listDetail.name + '</td>';
            html += '<td class="commute-end">' + listDetail.work + '</td>';
            html += '<td>' + listDetail.localDateTimeNow + '</td>';
            html += '</tr>';
            return html;
        }
    }


    // datepicker
    $(function () {
        $("#datepicker").datepicker();
        $("#datepicker_init_day").datepicker();
        $("#datepicker_init_day").datepicker('setDate', new Date);

        $("#datepicker_special_day").datepicker();
        $("#datepicker_special_day").datepicker('setDate', '2018-12-25');

        var today = new Date(); // 오늘날짜가 만들어진다.
        today.setDate(today.getDate() + 3); // 3일을 더하기



        $("#datepicker_add_day").datepicker();
        $("#datepicker_add_day").datepicker('setDate', today);
    });


    function getCommuteListByName() {
        let name = $(".name").val();

        $.ajax({
            type: 'GET',
            async: 'false', //비동기, false값이 기본이다.
            url: '/commute_list/userdetail',
            data: {"otherUsername": name},
            contentType: "application/json; charset=utf-8;",
            success: function (response) {
                getList(response)
            },
            error: function () {
                alert("에러 발생");
            }
        });
    }

    function getList(response) {
        if (response) {
            alert("완료");
        } else {
            alert("전송된 값 없음");
        }
        $("#table1").empty();
        console.log("일단 들어옴");
        for (let i = 0; i < response.length; i++) {
            let listDetail = response[i];
            let tempHtml = addHTML(listDetail, response[i].work);
            $('#table1').append(tempHtml);
            // console.log(response[i].localDateTimeNow + " : " + i);
        }
        console.log("ajax성공!");
    }
</script>

</body>
</html>
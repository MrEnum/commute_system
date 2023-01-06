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
<h1></h1>
<hr/>
<!-- 년( Year )은 자동으로 생성시 너무 많이 늘어날 수 있어서 -->
<!-- 월( Month )은 01 ~ 12라는 고정값을 알고 있기에 직접 값을 지정 -->
<!-- 일( Day )은 마지막 일이 항상 변하기 때문에 자동 생성 한다. -->
<div>
        <span>

            시작일 :
            <select onChange="changeConditionPeriod(this);" id="startYear">
                <option value="2018">2018</option>
                <option value="2019">2019</option>
                <option value="2020">2020</option>
                <option value="2021">2021</option>
                <option value="2022">2022</option>
                <option value="2023">2023</option>
                <option value="2024">2024</option>
                <option value="2025">2025</option>
            </select>

            년

            <select onChange="changeConditionPeriod(this);" id="startMonth">
                <option value="1">01</option>
                <option value="2">02</option>
                <option value="3">03</option>
                <option value="4">04</option>
                <option value="5">05</option>
                <option value="6">06</option>
                <option value="7">07</option>
                <option value="8">08</option>
                <option value="9">09</option>
                <option value="10">10</option>
                <option value="11">11</option>
                <option value="12">12</option>
            </select>

            월

            <select class="choiceDay" id="startDay"></select>

            일
        </span>
    ~
    <span>
            종료일
            <select onChange="changeConditionPeriod(this);" id="endYear">
                <option value="2018">2018</option>
                <option value="2019">2019</option>
                <option value="2020">2020</option>
                <option value="2021">2021</option>
                <option value="2022">2022</option>
                <option value="2023">2023</option>
                <option value="2024">2024</option>
                <option value="2025">2025</option>
            </select>
            년
            <select onChange="changeConditionPeriod(this);" id="endMonth">
                <option value="1">01</option>
                <option value="2">02</option>
                <option value="3">03</option>
                <option value="4">04</option>
                <option value="5">05</option>
                <option value="6">06</option>
                <option value="7">07</option>
                <option value="8">08</option>
                <option value="9">09</option>
                <option value="10">10</option>
                <option value="11">11</option>
                <option value="12">12</option>
            </select>
            월
            <select class="choiceDay" id="endDay"></select>
           일
        </span>
    <button onclick="getCommuteListByDate()">검색</button>
</div>
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

<script type="text/javascript">
    document.addEventListener("DOMContentLoaded", function () {
        const stdDays = document.querySelector("span:nth-child(1)");     // @param 시작일 영역지정
        const endDays = document.querySelector("span:nth-child(2)");    // @param 종료일 영역지정

        let stdFirstDate = null;    // @param 시작일의 첫날
        let endFirstDate = null;   // @param 종료일의 첫날
        let stdLastDate = null;    // @param 시작일의 전체일수
        let endLastDate = null;   // @param 종료일의 전체일수

        // @param GET방식으로 전달된 시작일, 종료일의 지정값이 존재하지 않는경우 ( ※ 맨처음 시작시에 실행 )
        if (nullPointerException(getParameter("stdDate")) == false && nullPointerException(getParameter("endDate")) == false) {
            const toDate = new Date();
            stdFirstDate = new Date(toDate.getFullYear(), (toDate.getMonth() + 1));
            stdLastDate = new Date(stdFirstDate.getFullYear(), (stdFirstDate.getMonth() + 1), 1);  // @param 다음달의 첫째날을 지정
            stdLastDate.setDate(0);    // @param 다음달에서 하루를 빼서 원하는 월의 마지막 날로 맞춤
            endFirstDate = new Date(toDate.getFullYear(), (toDate.getMonth() + 1));
            endLastDate = new Date(endFirstDate.getFullYear(), (endFirstDate.getMonth() + 1), 1);  // @param 다음달의 첫째날을 지정
            endLastDate.setDate(0);    // @param 다음달에서 하루를 빼서 원하는 월의 마지막 날로 맞춤
        }

        // @param GET방식으로 전달된 시작일, 종료일의 지정값이 존재하는 경우
        else {
            const stdDate = getParameter("stdDate");
            stdFirstDate = new Date(
                Number(stdDate.substring(0, 4))
                , Number(stdDate.substring(6, 8))
                , Number(stdDate.substring(4, 6))
            );
            stdLastDate = new Date(stdFirstDate.getFullYear(), stdFirstDate.getMonth(), 1);  // @param 다음달의 첫째날을 지정
            stdLastDate.setDate(0);    // @param 다음달에서 하루를 빼서 원하는 월의 마지막 날로 맞춤
            const endDate = getParameter("endDate");
            endFirstDate = new Date(
                Number(endDate.substring(0, 4))
                , Number(endDate.substring(4, 6))
                , Number(endDate.substring(6, 8))
            );
            endLastDate = new Date(endFirstDate.getFullYear(), endFirstDate.getMonth(), 1);  // @param 다음달의 첫째날을 지정
            endLastDate.setDate(0);    // @param 다음달에서 하루를 빼서 원하는 월의 마지막 날로 맞춤
        }


        // @param 년도( Year ) - 선택
        for (let year = 0; stdDays.querySelector("select:nth-child(1)").length > year; year++) {
            if (stdDays.querySelector("select:nth-child(1)").options[year].value == stdFirstDate.getFullYear()) {
                stdDays.querySelector("select:nth-child(1)").options[year].selected = true;
            }
            if (endDays.querySelector("select:nth-child(1)").options[year].value == stdFirstDate.getFullYear()) {
                endDays.querySelector("select:nth-child(1)").options[year].selected = true;
            }
        }

        // @param 월( Month ) - 선택
        for (let month = 0; stdDays.querySelector("select:nth-child(2)").length > month; month++) {
            if (stdDays.querySelector("select:nth-child(2)").options[month].value == stdFirstDate.getMonth()) {
                stdDays.querySelector("select:nth-child(2)").options[month].selected = true;
            }
            if (endDays.querySelector("select:nth-child(2)").options[month].value == endFirstDate.getMonth()) {
                endDays.querySelector("select:nth-child(2)").options[month].selected = true;
            }
        }


        // @param 일( Day ) - 생성 및 선택
        // @details - 날짜는 매월 마지막일이 다르게 끝나기 때문에 직접 생성하고,
        // 선택한 날( 기본값 시작일 - 01일, 종료일은 - 말일 )을 자동으로 selected 한다.
        for (let date = 1; stdLastDate.getDate() >= date; date++) {
            if (stdFirstDate.getDate() == date) {
                stdDays.querySelector("select:nth-child(3)").innerHTML
                    += "<option value='" + date + "' selected>" + autoLeftPad(date, 2) + "</option>";
            } else {
                stdDays.querySelector("select:nth-child(3)").innerHTML
                    += "<option value='" + date + "'>" + autoLeftPad(date, 2) + "</option>";
            }
        }


        for (let date = 1; endLastDate.getDate() >= date; date++) {
            if ((nullPointerException(getParameter("endDate")) == true) ? endFirstDate.getDate() : endLastDate.getDate() == date) {
                endDays.querySelector("select:nth-child(3)").innerHTML
                    += "<option value='" + date + "' selected>" + autoLeftPad(date, 2) + "</option>";
            } else {
                endDays.querySelector("select:nth-child(3)").innerHTML
                    += "<option value='" + date + "'>" + autoLeftPad(date, 2) + "</option>";
            }
        }
    });

    function getCommuteListByDate() {
        console.log("실행되긴함");
        $("#table1").empty();
        var startYear = $('#startYear option:selected').val();
        var startMonth = $('#startMonth option:selected').val();
        var startDay = $('#startDay option:selected').val();
        var endYear = $('#endYear option:selected').val();
        var endMonth = $('#endMonth option:selected').val();
        var endDay = $('#endDay option:selected').val();

        let startDate = new Date(startYear,startMonth, startDay);
        let endDate = new Date(endYear,endMonth, endDay);

        $.ajax({
                    type: 'GET',
                    async: 'false', //비동기, false값이 기본이다.
                    url: '/commute_list/detail',
                    data: (startDate, endDate),
                    contentType: "application/json",
                    success: function () {
                    },
                });

    }


    /**
     * @brief   시작일( 년, 월 ), 종료일 ( 년, 월 )의 값이 변경된 경우 실행
     * @details 시작일( 년, 월 ), 종료일 ( 년, 월 )의 값이 변경에 따른 해당 년월의 전체일수를 다시 체크,
     *             변경된 년월의 일보다 선택된 일이 큰경우 마지막 날로 선택일 자동 변경
     */

    function changeConditionPeriod(cal) {
        const searchDays = cal.parentNode;
        const checkDate = searchDays.querySelector("select:nth-child(3)").value;

        // @param 다음달의 첫째날을 지정
        let lastDate = new Date(
            searchDays.querySelector("select:nth-child(1)").value
            , searchDays.querySelector("select:nth-child(2)").value
            , 1
        );

        lastDate.setDate(0);    // @param 하루를 뺌

        // @param 일정보 초기화
        searchDays.querySelector("select:nth-child(3)").innerHTML = "";

        // @param 일정보 재삽입
        for (let date = 1; lastDate.getDate() >= date; date++) {
            if (checkDate == date) {
                searchDays.querySelector("select:nth-child(3)").innerHTML
                    += "<option value='" + date + "' selected>" + autoLeftPad(date, 2) + "</option>";
            } else {
                searchDays.querySelector("select:nth-child(3)").innerHTML
                    += "<option value='" + date + "'>" + autoLeftPad(date, 2) + "</option>";
            }
        }

        // @param 일정보 예외처리 선택되어있는 마지막 날이 바꾼 월의 날보다 큰경우의 예외처리
        if (checkDate > lastDate.getDate()) {
            searchDays.querySelector("select:nth-child(3) > option:last-child").selected = true;
        }
    }


    /**
     * @brief   강제로 앞에 0을 붙여서 두자릿수 숫자로 변경한다.
     * @param   num     앞에 0을 붙일 숫자 값
     * @param   digit   자릿수를 지정
     */
    function autoLeftPad(num, digit) {
        if (String(num).length < digit) {
            num = new Array(digit - String(num).length + 1).join("0") + num;
        }
        return num;
    }

    /**
     * @brief   GET으로 넘어오는 값의 존재 여부를 체크
     */
    function nullPointerException(worth) {
        if (
            worth == ""
            || worth == null
            || worth == undefined
            || (worth != null && typeof worth == "object" && !Object.keys(worth).length == "")) {
            return false;
        } else {
            return true;
        }
    }


    /**
     * @brief   GET방식으로 전달된 값을 추출
     * @param   param     추출할 key의 명칭
     */

    var getParameter = function (param) {
        let returnValue;
        let url = location.href;
        let parameters = (url.slice(url.indexOf("?") + 1, url.length)).split("&");

        for (let i = 0; i < parameters.length; i++) {
            let varName = parameters[i].split("=")[0];
            if (varName.toUpperCase() == param.toUpperCase()) {
                returnValue = parameters[i].split("=")[1];
                return decodeURIComponent(returnValue);
            }
        }
    };
</script>

</body>
</html>
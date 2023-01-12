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
    <script src="https://cdnjs.cloudflare.com/ajax/libs/paginationjs/2.1.4/pagination.min.js"></script>
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
        <label> 날짜 </label>
        <input type="text" id="datepicker_init_day" class="start-date" placeholder="초기날짜">
        ~
        <input type="text" id="datepicker_special_day" class="end-date" placeholder="특정날짜">

    </p>
</div>
<c:choose>
    <c:when test="${role eq 'ROLE_MANAGER'}">
        <div>
            <p>
                <label> 이름 검색 </label>
                <input type="text" id="name-search" class="real-name" placeholder="이름">
                <button onclick="getCommuteListByName()">검색</button>
            </p>
        </div>
    </c:when>
    <c:otherwise>
        <button onclick="getCommuteListByDate2()">검색</button>
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

<div id="see-area">
    <div class="pagination">
        정렬:
        <select id="sorting" onchange="getCommuteListByDate2()">
            <option value="id">ID</option>
            <option value="title">상품명</option>
            <option value="lprice">최저가</option>
        </select>
        <input type="radio" name="isAsc" value="true" onchange="getCommuteListByDate2()" checked /> 오름차순
        <input type="radio" name="isAsc" value="false" onchange="getCommuteListByDate2()" /> 내림차순
    </div>
    <div id="pagination" class="pagination"></div>
    <ul id="product-container">
    </ul>
</div>

<script type="text/javascript">
    // $("#datepicker").datepicker({
    //     language: 'ko'
    // });

    // //비동기로 테이블 값 가져오기
    // function getCommuteListByDate() {
    //     console.log("실행되긴함");
    //
    //     let startYear = $('.start-date').datepicker('getDate').getFullYear();
    //     let startMonth = $('.start-date').datepicker('getDate').getMonth();
    //     let startDay = $('.start-date').datepicker('getDate').getDate();
    //
    //     let endYear = $('.end-date').datepicker('getDate').getFullYear();
    //     let endMonth = $('.end-date').datepicker('getDate').getMonth();
    //     let endDay = $('.end-date').datepicker('getDate').getDate() + 1;
    //
    //     let startdate
    //
    //     const startDate = new Date(startYear, startMonth, startDay);
    //     const endDate = new Date(endYear, endMonth, endDay);
    //     console.log(startDate + " ~ " + endDate);
    //
    //     $.ajax({
    //         type: 'GET',
    //         async: 'false', //비동기, false값이 기본이다.
    //         url: '/commute_list/detail',
    //         data: {
    //             "startDate": startDate,
    //             "endDate": endDate
    //         },
    //         contentType: "application/json; charset=utf-8;",
    //         success: function (response) {
    //             getList(response);
    //         },
    //         error: function () {
    //             alert("에러 발생");
    //         }
    //     });
    // }


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
        $("#datepicker_init_day").datepicker({dateFormat: "yymmdd"});
        $("#datepicker_init_day").datepicker('setDate', '20220101');

        $("#datepicker_special_day").datepicker({dateFormat: "yymmdd"});
        $("#datepicker_special_day").datepicker('setDate', new Date());

    });


    function getCommuteListByName() {
        let name = $(".real-name").val();
        console.log("실행되긴함 : " + name);

        let startYear = $('.start-date').datepicker('getDate').getFullYear();
        let startMonth = $('.start-date').datepicker('getDate').getMonth();
        let startDay = $('.start-date').datepicker('getDate').getDate();

        let endYear = $('.end-date').datepicker('getDate').getFullYear();
        let endMonth = $('.end-date').datepicker('getDate').getMonth();
        let endDay = $('.end-date').datepicker('getDate').getDate() + 1;


        const startDate = new Date(startYear, startMonth, startDay);
        const endDate = new Date(endYear, endMonth, endDay);
        $.ajax({
            type: 'GET',
            async: 'false', //비동기, false값이 기본이다.
            url: '/commute_list/userdetail',
            data: {
                "otherUsername": name,
                "startDate": startDate,
                "endDate": endDate
            },
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


    Date.prototype.format = function(f) {
        if (!this.valueOf()) return " ";

        var weekName = ["일요일", "월요일", "화요일", "수요일", "목요일", "금요일", "토요일"];
        var d = this;

        return f.replace(/(yyyy|yy|MM|dd|E|hh|mm|ss|a\/p)/gi, function($1) {
            switch ($1) {
                case "yyyy": return d.getFullYear();
                case "yy": return (d.getFullYear() % 1000).zf(2);
                case "MM": return (d.getMonth() + 1).zf(2);
                case "dd": return d.getDate().zf(2);
                case "E": return weekName[d.getDay()];
                case "HH": return d.getHours().zf(2);
                case "hh": return ((h = d.getHours() % 12) ? h : 12).zf(2);
                case "mm": return d.getMinutes().zf(2);
                case "ss": return d.getSeconds().zf(2);
                case "a/p": return d.getHours() < 12 ? "오전" : "오후";
                default: return $1;
            }
        });
    };

    String.prototype.string = function(len){var s = '', i = 0; while (i++ < len) { s += this; } return s;};
    String.prototype.zf = function(len){return "0".string(len - this.length) + this;};
    Number.prototype.zf = function(len){return this.toString().zf(len);};


    //페이징 적용
    function getCommuteListByDate2() {

        let startYear = $('.start-date').datepicker('getDate').getFullYear();
        let startMonth = $('.start-date').datepicker('getDate').getMonth();
        let startDay = $('.start-date').datepicker('getDate').getDate();

        let endYear = $('.end-date').datepicker('getDate').getFullYear();
        let endMonth = $('.end-date').datepicker('getDate').getMonth();
        let endDay = $('.end-date').datepicker('getDate').getDate() + 1;


        let startDate = new Date(startYear, startMonth, startDay);


        startDate = startDate.format("yyyy-MM-dd-hh-mm-ss");

        let endDate = new Date(endYear, endMonth, endDay);
        endDate = endDate.format("yyyy-MM-dd-hh-mm-ss");

        var sorting = $("#sorting option:selected").val();
        var isAsc = $(':radio[name="isAsc"]:checked').val();
        console.log(sorting, isAsc, startDate, endDate);

        $('#table1').empty();
        $('#table1').pagination({
            dataSource: '/commute_list/detail?sortBy='+sorting+'&isAsc='+isAsc + '&startDate=' + startDate + '&endDate=' + endDate,
            locator: 'content',
            alias: {
                pageNumber: 'page',
                pageSize: 'size'
            },
            totalNumberLocator: (response) => {
                return response.totalElements;
            },
            pageSize: 10,
            showPrevious: true,
            showNext: true,
            ajax: {
                beforeSend: function() {
                    $('#table1').html('기록 불러오는 중...');
                }
            },
            callback: function(data, pagination) {
                $('#table1').empty();
                for (let i = 0; i < data.length; i++) {
                    let listDetail = data[i];
                    let tempHtml = addHTML(listDetail, data[i].work);
                    $('#table1').append(tempHtml);
                }
            }
        });
    }
    function numberWithCommas(x) {
        return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
    }

</script>

</body>
</html>
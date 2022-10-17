<!--
<%@ page contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR" %>
-->

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="clock.css"/>


    <title>Title</title>
</head>


<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

<style>
    h1 {
        text-align: center;
    }
</style>
<script type="text/javascript">

    document.addEventListener("DOMContentLoaded", function () {
        //
        realTimer();
        //
        setInterval(realTimer, 500);
    });

    //
    function realTimer() {
        const nowDate = new Date();
        const year = nowDate.getFullYear();
        const month = nowDate.getMonth() + 1;
        const date = nowDate.getDate();
        const hour = nowDate.getHours();
        const min = nowDate.getMinutes();
        const sec = nowDate.getSeconds();

        document.getElementById("nowTimes").innerHTML =
            year + "-" + addzero(month) + "-" + addzero(date) + "&nbsp;" + hour + ":" + addzero(min) + ":" + addzero(sec);

    }

    //
    function addzero(num) {
        if (num < 10) {
            num = "0" + num;
        }
        return num;
    }


    // <%--const clock = document.querySelector('.h1-clock');--%>
    // <%--function getTime(){--%>
    // <%--    const time = new Date();--%>
    // <%--    const hour = time.getHours();--%>
    // <%--    const minutes = time.getMinutes();--%>
    // <%--    const seconds = time.getSeconds();--%>
    // <%--    //clock.innerHTML = hour +":" + minutes + ":"+seconds;--%>
    // <%--    clock.innerHTML = `${hour<10 ? `0${hour}`:hour}:${minutes<10 ? `0${minutes}`:minutes}:${seconds<10 ? `0${seconds}`:seconds}`--%>
    // <%--}--%>
    //
    //
    // <%--function init(){--%>
    // <%--    setInterval(getTime, 1000);--%>
    // <%--}--%>
    //
    // <%--init();--%>
</script>
<script>
    //출근 버튼
    function getStart() {
        $.ajax({
            type: 'POST',
            async: 'false', //비동기, false값이 기본이다.
            url: '/normal/start',
            // data: JSON.stringify(),
            contentType: "application/json",
            success: function (response) {
                alert(response + "\n 현재 시간입니다.");
            },
        });
    }

    //퇴근 버튼
    function getFinish() {
        $.ajax({
            type: 'POST',
            async: 'false', //비동기, false값이 기본이다.
            url: '/normal/finish',
            // data: JSON.stringify(username),
            contentType: "application/json",
            success: function (response) {
                alert(response + "\n 현재 시간입니다.");
            },
        });
    }
</script>
<h1>실시간 : <span id="nowTimes"> </span></h1>
<body>
<button class="work_start"
        type="button" onclick="getStart()">
    출근
</button>
<button class="work_finish"
        type="button" onclick="getFinish()">
    퇴근
</button>

<button class="commute_list"
        type="button" onclick="location.href='commute_list'">
    조회
</button>
<button class="signup"
    type="button" onclick="location.href='manager/signup'">
회원가입
</button>



<!--로그아웃-->
<form id="my_form" method="post" action="/user/logout">
    <a id="logout-text" href="javascript:{}" onclick="document.getElementById('my_form').submit();">로그아웃</a>
</form>

</body>
</html>
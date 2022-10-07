<%@ page contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="clock.css"/>


    <title>Title</title>
</head>


<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

<style>
    h1{
        text-align : center;
    }
</style>
<script type="text/javascript">

    document.addEventListener("DOMContentLoaded", function() {
        // 시간을 딜레이 없이 나타내기위한 선 실행
        realTimer();
        // 이후 0.5초에 한번씩 시간을 갱신한다.
        setInterval(realTimer, 500);
    });

    // 시간을 출력
    function realTimer() {
        const nowDate = new Date();
        const year = nowDate.getFullYear();
        const month= nowDate.getMonth() + 1;
        const date = nowDate.getDate();
        const hour = nowDate.getHours();
        const min = nowDate.getMinutes();
        const sec = nowDate.getSeconds();

        document.getElementById("nowTimes").innerHTML =
            year + "-" + addzero(month) + "-" + addzero(date) + "&nbsp;" + hour + ":" + addzero(min) + ":" + addzero(sec);

    }
    // 1자리수의 숫자인 경우 앞에 0을 붙여준다.
    function addzero(num) {
        if(num < 10) { num = "0" + num; }
        return num;
    }


    <%--const clock = document.querySelector('.h1-clock');--%>
    <%--function getTime(){--%>
    <%--    const time = new Date();--%>
    <%--    const hour = time.getHours();--%>
    <%--    const minutes = time.getMinutes();--%>
    <%--    const seconds = time.getSeconds();--%>
    <%--    //clock.innerHTML = hour +":" + minutes + ":"+seconds;--%>
    <%--    clock.innerHTML = `${hour<10 ? `0${hour}`:hour}:${minutes<10 ? `0${minutes}`:minutes}:${seconds<10 ? `0${seconds}`:seconds}`--%>
    <%--}--%>


    <%--function init(){--%>
    <%--    setInterval(getTime, 1000);--%>
    <%--}--%>

    <%--init();--%>
</script>
<script>
    function getStart() {
        var username = "뿡뿡이";
        $.ajax({
            type: 'POST',
            async: 'false', //비동기처리 false가 기본값이라 한다.
            url: '/commute/start',
            data: JSON.stringify(username),       //서버로 전송할 데이터
            contentType: "application/json",
            success: function (response) {
                alert(response + "\n 출근했습니다.");
            },
        });
    }
    function getFinish() {
        var username = "뿡뿡이";
        $.ajax({
            type: 'POST',
            async: 'false', //비동기처리 false가 기본값이라 한다.
            url: '/commute/finish',
            data: JSON.stringify(username),       //서버로 전송할 데이터
            contentType: "application/json",
            success: function (response) {
                alert(response + "\n 퇴근했습니다.");
            },
        });
    }
</script>

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
        type="button" >
    조회
</button>
<h1>■ 현재시간 : <span id="nowTimes"></span></h1>

</body>
</html>
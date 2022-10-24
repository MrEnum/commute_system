<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>


<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="clock.css"/>


    <title>Title</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <!-- 합쳐지고 최소화된 최신 CSS -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
</head>

<%------------------------------------------------------------------------------------%>
<style>
    times_square {
        width: 100%;
        padding: 0;
        margin: 0;
    }

    body {
        text-align: center; /* Quirks Mode 를 위한 가운데 정렬 */
        width: 100%;
        padding: 0;
        margin: 0;

    }
</style>

<h1 calss="times_square" style="padding: 0px 0px 100px 0px;">실시간 : <span id="nowTimes"> </span></h1>

<%----------------------------------------------------------------------------------------%>
<body>
<div>
    <div style="padding: 0px 0PX 50px 0px;font-size:30px;margin-right: 50px; margin-left:  50px;">
        <div>
            <%--회원가입--%>
            <button class="signup" style="margin-right: 270px;"
                    type="button" onclick="location.href='manager/signup'">
                회원가입
            </button>

            <%--출퇴근 조회--%>
            <button class="commute_list" style="margin-left: 270px;"
                    type="button" onclick="location.href='commute_list'">
                조회
            </button>
        </div>
    </div>

    <div>

        <div>
            <%--출근 퇴근 버튼--%>
            <div style="padding: 0px 0px 100px 0px;">
                <button class="btn btn-primary" style="font-size:100px; padding:60px 90px"
                        type="button" onclick="getStart()">
                    출근
                </button>
                <button class="btn btn-danger" style="font-size:100px; padding:60px 90px"
                        type="button" onclick="getFinish()">
                    퇴근
                </button>
            </div>

            <div>

                <!--로그아웃-->
                <form id="my_form" method="post" action="/user/logout" style="font-size: 50px;">
                    <a id="logout-text" href="javascript:{}"
                       onclick="document.getElementById('my_form').submit();">로그아웃</a>
                </form>
            </div>
            <br>


        </div>
    </div>
</div>

<%---------------------------------------------script-----------------------------------------------------------------------%>
<script type="text/javascript">
    //실시간 표시해주기
    document.addEventListener("DOMContentLoaded", function () {
        //
        realTimer();
        //
        setInterval(realTimer, 500);
    });

    //시간 쪼개서 붙여넣기
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

    //시간 "0" 붙여주기
    function addzero(num) {
        if (num < 10) {
            num = "0" + num;
        }
        return num;
    }

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
</body>
</html>
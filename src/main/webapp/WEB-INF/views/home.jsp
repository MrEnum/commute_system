<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Title</title>
</head>


<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

<script>
    function getStart() {
        var username = {username: "뿡뿡이"};
        $.ajax({
            type: 'POST',
            async: 'false', //비동기처리 false가 기본값이라 한다.
            url: '/commute/start',
            data: JSON.stringify(username),       //서버로 전송할 데이터
            contentType: "application/json",
            success: function (response) {
                alert(response);
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
        type="button">
    퇴근
</button>
</body>
</html>
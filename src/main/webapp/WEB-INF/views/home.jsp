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
        var username = {username: "�׻���"};
        $.ajax({
            type: 'POST',
            async: 'false', //�񵿱�ó�� false�� �⺻���̶� �Ѵ�.
            url: '/commute/start',
            data: JSON.stringify(username),       //������ ������ ������
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
    ���
</button>
<button class="work_finish"
        type="button">
    ���
</button>
</body>
</html>
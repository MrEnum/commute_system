<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Title</title>
</head>

<body>
<table class="table test">
    <tr>
        <th>이름</th>
        <th>출퇴근</th>
        <th>날짜시간</th>
    </tr>

    <tbody id="table1">

    </tbody>
</table>
<script>
    var myArray = [
        {'이름': '홍준표', '출퇴근': '출근', '날짜시간': '2022-09-29T14:20:15'},
        {'이름': '이명박', '출퇴근': '퇴근', '날짜시간': '2022-09-29T14:20:15'},
        {'이름': '박근혜', '출퇴근': ' 출근', '날짜시간': '2022-09-29T14:20:15'},
        {'이름': '박봉기', '출퇴근': ' 퇴근', '날짜시간': '2022-09-29T14:20:15'},

    ]

    buildTable(myArray)

    function buildTable(data) {
        var table = document.getElementById('table1')

        for (var i = 0; i < data.length; i++) {
            var row = `<tr>
                    <td>${data[i].이름}</td>
                    <td>${data[i].출퇴근}</td>
                    <td>${data[i].날짜시간}</td>
                   </tr>`
            table.innerHTML += row
        }
    }


</script>
</body>
</html>
<%@ page contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Title</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <script src="https://code.jquery.com/jquery-1.12.4.min.js"></script></head>

<body>
<table class="table" onload="showList()">
    <tr>
        <th>아이디</th>
        <th>이름</th>
        <th>출퇴근</th>
        <th>날짜시간</th>
    </tr>
    <button class="getList"
            type="button" onclick="showList()">
        조회
    </button>
    <tbody id="table1">

    </tbody>
</table>
<script>
    // var myArray = [
    //     {'아이디' : {username}"'이름': "{name}", '출퇴근': '출근', '날짜시간': '2022-09-29T14:20:15'},
    // ]
    //
    // buildTable(myArray)


    function showList() {

        // 1. GET /api/products 요청
        // 2. #product-container(관심상품 목록), #search-result-box(검색결과 목록) 비우기
        // 3. for 문 마다 addProductItem 함수 실행시키고 HTML 만들어서 #product-container 에 붙이기
        $.ajax({
            type: 'GET',
            url: '/commute_list/getlist',
            contentType: "application/json",
            success: function (response) {
                console.log("response : " + response);
                for (let i = 0; i < response.length; i++) {
                    // $('#table1').empty(); //한 번 비워줘라
                    let commuteList = response[i];
                    buildTable(commuteList);

                }
            }
        })
    }

    function buildTable(commuteList) {

        var username = commuteList.username;
        var name = commuteList.name;
        var work = commuteList.work;
        var dateTime = commuteList.localDateTimeNow;

        console.log('백틱username', `${username}` );
        var table = document.getElementById('table1');
        console.log('첫번째table',table)
        console.log('table1',$('#table1'))

        var row = "<tr><td>" +username +"</td><td>" + name+ "</td><td>" + work + "</td><td>" + dateTime + "</td></tr>"
        console.log('row',row);
        table.innerHTML += row;
        console.log('두번째table', table);
        // $('#table1').append(row);
        console.log('table2',$('#table1'))
    }


</script>
</body>
</html>
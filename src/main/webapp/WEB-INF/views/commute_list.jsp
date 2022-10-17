<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Title</title>
</head>

<body>
<table class="table">
    <tr>
        <th>아이디</th>
        <th>이름</th>
        <th>출퇴근</th>
        <th>날짜시간</th>
    </tr>

    <tbody id="table1">

    </tbody>
</table>
<script>
    // var myArray = [
    //     {'아이디' : {username}"'이름': "{name}", '출퇴근': '출근', '날짜시간': '2022-09-29T14:20:15'},
    // ]
    //
    // buildTable(myArray)

    function buildTable(commuteList) {
        var table = document.getElementById('table1')

        for (var i = 0; i < commuteList.length; i++) {
            var row = `<tr>
                    <td>${commuteList[i].username}</td>
                    <td>${commuteList[i].name}</td>
                    <td>${commuteList[i].work}</td>
                    <td>${commuteList[i].dateTime}</td>
                   </tr>`
            table.innerHTML += row
        }
    }

    $(document).ready(function showList() {
        // 1. GET /api/products 요청
        // 2. #product-container(관심상품 목록), #search-result-box(검색결과 목록) 비우기
        // 3. for 문 마다 addProductItem 함수 실행시키고 HTML 만들어서 #product-container 에 붙이기
        $.ajax({
            type: 'GET',
            url:'/list',
            success: function (response) {
                for (let i = 0; i < response.length; i++) {
                    $('#table1').empty(); //한 번 비워줘라
                    let commuteList = response[i];
                    let tempHtml = buildTable(commuteList);
                    $('#table1').append(tempHtml);
                }
            }
        })
    })

</script>
</body>
</html>
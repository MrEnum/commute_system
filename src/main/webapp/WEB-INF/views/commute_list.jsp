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
        <th>���̵�</th>
        <th>�̸�</th>
        <th>�����</th>
        <th>��¥�ð�</th>
    </tr>
    <button class="getList"
            type="button" onclick="showList()">
        ��ȸ
    </button>
    <tbody id="table1">

    </tbody>
</table>
<script>
    // var myArray = [
    //     {'���̵�' : {username}"'�̸�': "{name}", '�����': '���', '��¥�ð�': '2022-09-29T14:20:15'},
    // ]
    //
    // buildTable(myArray)


    function showList() {

        // 1. GET /api/products ��û
        // 2. #product-container(���ɻ�ǰ ���), #search-result-box(�˻���� ���) ����
        // 3. for �� ���� addProductItem �Լ� �����Ű�� HTML ���� #product-container �� ���̱�
        $.ajax({
            type: 'GET',
            url: '/commute_list/getlist',
            contentType: "application/json",
            success: function (response) {
                console.log("response : " + response);
                for (let i = 0; i < response.length; i++) {
                    // $('#table1').empty(); //�� �� ������
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

        console.log('��ƽusername', `${username}` );
        var table = document.getElementById('table1');
        console.log('ù��°table',table)
        console.log('table1',$('#table1'))

        var row = "<tr><td>" +username +"</td><td>" + name+ "</td><td>" + work + "</td><td>" + dateTime + "</td></tr>"
        console.log('row',row);
        table.innerHTML += row;
        console.log('�ι�°table', table);
        // $('#table1').append(row);
        console.log('table2',$('#table1'))
    }


</script>
</body>
</html>
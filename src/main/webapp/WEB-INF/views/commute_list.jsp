<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Title</title>
</head>

<body>
<table class="table test">
    <tr>
        <th>�̸�</th>
        <th>�����</th>
        <th>��¥�ð�</th>
    </tr>

    <tbody id="table1">

    </tbody>
</table>
<script>
    var myArray = [
        {'�̸�': 'ȫ��ǥ', '�����': '���', '��¥�ð�': '2022-09-29T14:20:15'},
        {'�̸�': '�̸��', '�����': '���', '��¥�ð�': '2022-09-29T14:20:15'},
        {'�̸�': '�ڱ���', '�����': ' ���', '��¥�ð�': '2022-09-29T14:20:15'},
        {'�̸�': '�ں���', '�����': ' ���', '��¥�ð�': '2022-09-29T14:20:15'},

    ]

    buildTable(myArray)

    function buildTable(data) {
        var table = document.getElementById('table1')

        for (var i = 0; i < data.length; i++) {
            var row = `<tr>
                    <td>${data[i].�̸�}</td>
                    <td>${data[i].�����}</td>
                    <td>${data[i].��¥�ð�}</td>
                   </tr>`
            table.innerHTML += row
        }
    }


</script>
</body>
</html>
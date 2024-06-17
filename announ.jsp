<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <title></title>
</head>
<style>
    .loginTB {
        margin: 5% 30% 0px 35%;
        border-top: 1px solid #c6c9cc;
    }

    th,
    td {
        padding: 6px 15px;
    }

    th {
        background: #42444e;
        color: #fff;
        text-align: left;
    }

    tr:first-child th:first-child {
        border-top-left-radius: 6px;
    }

    tr:first-child th:last-child {
        border-top-right-radius: 6px;
    }

    td {
        border-right: 1px solid #c6c9cc;
        border-bottom: 1px solid #c6c9cc;
    }

    td:first-child {
        border-left: 1px solid #c6c9cc;
    }

    tr:nth-child(even) td {
        background: #eaeaed;
    }

    tr:last-child td:first-child {
        border-bottom-left-radius: 6px;
    }

    tr:last-child td:last-child {
        border-bottom-right-radius: 6px;
    }

    input {
        width: 90px;
        height: 32px;
        font-size: 15px;
        border: 0;
        border-radius: 15px;
        outline: none;
        padding-left: 10px;
        background-color: rgb(233, 233, 233);
    }
</style>

<body>
    <header>
        <h1 style="display:inline; padding: 0px 30% 0px 40%;"><a href="/" style="text-decoration: none;">어떤 홈페이지이름</a></h1>
        <p style="background: blue; width: 500px; text-align: center; text-decoration: none; margin: 0px 0px 0px 34%;">
            <a href="" style="text-decoration-line: none; color:red; hover:black;">공지사항</a>
            <a href="" style="text-decoration-line: none;  color:red; hover:black;">Q&A</a>
        </p>
    </header>
    <table class="loginTB">
        <th colspan="6">공지사항을 알려드립니다</th>
        <tr>
            <td style="background-color:#09C">글쓴이</td>
            <td>이사이트 관리자</td>
            <td style="background-color:#09C">작성일</td>
            <td>어제</td>
            <td style="background-color:#09C">조회수</td>
            <td>123</td>
        </tr>
        <tr>
            <td colspan="6" style="width: 400px;height: 500px">설날이 가까워 배송이 지연될수도 있다</td>
        </tr>
        <tr>
            <td>내닉네임</td>
            <td colspan="4"><input type="text" style="width: 100%;height: 100%;"></td>
            <td><input type="button" value="댓글입력"></td>
        </tr>
    </table>

</body>

</html>
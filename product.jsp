<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<style>
table {border-collapse:collapse;}
td {border :1px solid black;}
</style>
<a href="/list">리스트</a>
<a href="/signup">회원가입</a>
<a href="/">로그인</a>
<body>
        <table>
            <tr>
                <th>${goods.id}.상품 이미지</th>
                <td><img alt="Product 1"></td>
            </tr>
            <tr>
                <th>상품명</th>
                <td>${goods.goods}</td>
            </tr>
            <tr>
                <th>가격</th>
                <td>${goods.price}</td>
            </tr>
            <tr>
                <th>상세 설명</th>
                <td>이 제품은 아주 좋은 상품입니다..</td>
            </tr> 
            <tr>
                <th>리뷰</th>
                <td>리뷰</td>
            </tr>   
              <tr>
                <th>Q&A</th>
                <td>Q&A</td>
            </tr>    
        </table>
        
</body>
</html>
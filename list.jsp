<%@page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>커피블리스</title>
<style>
      
   table {
       width: 100%;
       height: 100%;
       border-collapse: collapse;
	} 
   td,tr {
       width: 25%; 
       height: 25%;
       border: 1px solid black;
       text-align: center;
       vertical-align: middle;
   }      

</style>
</head>
<body>
<a href="/signup">회원가입</a>
<a href="/">로그인</a>
 <a>품목</a>
 <table id=tblList>
     <tr><th>상품</th><th></th><th></th></tr>     
 <c:forEach items="${goods}" var="good"> 
 	<tr>   
    <td>이미지</td><td><a href="/product?id=${good.id}">${good.id}<hr>${good.goods}<hr>${good.price}</td>
    <td><button>주문</button><button>장바구니</button></td>
    </tr>  
</c:forEach>     
 </table>
</body>
</html>
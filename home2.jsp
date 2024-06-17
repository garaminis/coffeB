<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h1>home</h1>
<%
String id=(String)session.getAttribute("id"); // session 설정있음
%>
 <div class="header">메인화면</div>
 <div class="twodiv">
     <div class="twodiv1" style="width: 30%; text-align: left;"><a href="">쇼핑몰 타이틀</a></div>
     <div class="twodiv2" style="width: 30%; text-align: center;">
         <input class="textserch" type="text">
         <input class="btnserch" type="button" value="검색">
     </div>
<%  if(id==null){  %>
     <div class="twodiv3" style="width: 30%;  text-align:right;" >
         <a href="/login"> 로그인</a>
         <a href="/signup"> 회원가입</a>
     </div> <%} else { %>
     <div class="twodiv4" style="width: 30%;  text-align:right;" >
     	<a><%=id%>님 반갑습니다.</a>
     	<a id=logoutlink href="/logout">로그아웃</a>
     </div>
	<% } %>
     <div class="twodiv5" style="width: 30%;  text-align:right;">
         <a href="">장바구니</a>
         <a href="">마이페이지</a>
         <a href="">장바구니</a>
         <a href="/community">고객센터</a>
     </div>
 </div>
<script src='http://code.jquery.com/jquery-latest.js'></script>
<script> 
$(document)
.on('click','#logoutlink',function(){
	$.ajax({
		type:'post',
		url:'/logout',
		data:{},
		dataType:'text',
		success:function(data){
			if(data=='1') {
			  location.href="/";
			  console.log("성공");
			}	
		}
	}) 
	 return false;
})
</script>
</body>
</html>
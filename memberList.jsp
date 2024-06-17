<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<style>

</style>
<link href="/css/admin.css" rel="stylesheet" type="text/css">
<body>
	<nav id="nav" >
      <span id="serchArea" >
        <button id="doSerch" onclick="location.href='/'" >메인페이지</button>
    	</span>
    <span id="categoryBar" >
        <a href="/admin" class="categoryMenu">상품관리</a>
        <a href="/adminorder" class="categoryMenu">주문관리</a>
        <a href="memberList" class="categoryMenu">고객관리</a>
        <button id="doSerch" onclick="location.href='/'">메인페이지</button>
    </span>
	</nav>
	<div style="height: 140px;">
<table style="height: 100%; width: 100%;">
    <tr >
        <td style="width: 15%; text-align: center;">고객관리</td>
        <td>여기는 비워주는곳</td>
        <td style="width: 15%; vertical-align: bottom;text-align: right;"></td>
    </tr>
</table>
<div>
	<div style="width:100%;text-align: center;margin: 30px 40px 0px 50px; width: 92%;">
		<table class="memberL" style="text-align: center;margin: auto;">
		</table>
	</div>
</body>
<script src="https://code.jquery.com/jquery-latest.js"></script>
<script>
$(document)
.ready(function(){
	getMemberList() //시작하면 맴버테이블생성
})
function getMemberList(){ //테이블가져오는 함수
	$.ajax({
		type:'post',
		url:'/memberslist',
		data:{},
		dataType:'json',
		success:function(data){
			let Headtable = '<tr><td>회원번호</td><td>아이디</td>'+
	            '<td>이름</td><td>전화번호</td>'+
				'<td>이메일</td><td>생년월일</td>'+
	            '<td>성별</td><td>가입날짜</td><td>탈퇴날짜</td>'+
	            '<td>우편번호</td><td>상세주소</td><td>회원등급</td><td>수정/삭제</td></tr>';
	        $('.memberL').append(Headtable)
			for(let i = 0;i<data.length;i++){
				let ob = data[i];
				console.log(ob['id'])
				let str = '<tr><td>'+ob['id']+'</td><td>'+ob['user_id']+'</td><td>'+ob['name']+'</td><td>'+ob['mobile']+'</td><td>'+ob['mail']+'</td><td>'+
				ob['birth']+'</td><td>'+ob['gender']+'</td><td>'+ob['join_day']+'</td><td>'+ob['out_day']+'</td><td>'+
				ob['zipcode']+'</td><td>'+ob['adress']+'</td><td>'+ob['member_rank']+'</td><td>'+'<button class="siuu" value="'+ob['id']+'">수정</button>&nbsp/&nbsp'+
				'<button class="sack" value="'+ob['id']+'">삭제</button>'+'</td></tr>'
				$('.memberL').append(str)
			}
		}
	})
}
</script>
</html>
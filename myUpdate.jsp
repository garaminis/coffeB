<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>내 정보수정</title>
<link href="/css/theme.css" rel="stylesheet" type="text/css">
<script src='http://code.jquery.com/jquery-latest.js'></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script><!-- 다음카카오 주소API 스크립트 -->
</head>
<style>
table {
	  margin: 20px auto;
	  border-collapse: collapse;
	  border-radius: 8px;
	 
	}
table tr td {
    padding: 15px;
    vertical-align: top;
}

.myup {
    width: 100%;
    padding: 10px;
    border: 1px solid #ccc;
    border-radius: 4px;
    box-sizing: border-box;
}
.btnmyupdate{
	 width: 100%;
}
 

</style>
<body>
<div id="container">
  <header id="herder">
   	<%@ include file="include/header.jsp" %>
  </header>
  
  <nav id="nav">
  	<%@ include file="include/nav.jsp" %>
  </nav>

  <main id="main">
    <div id="mainContent"> 
      <h1><br>내 정보수정</h1><br>
      <hr>
			<table id="tblMyUpdate">
			  <tr>
			    <td colspan="2"><input type="text" id="user_id" name='id' placeholder="아이디" value=<%=id%> readonly class="myup"></td>
			  </tr>
		    <tr>
			    <td colspan="2" ><input type="text" id="name" placeholder="이름" value="${members.name}"  class="myup" ></td>
			  </tr>
		    <tr>
	        <td colspan="2"><input type="date" id="birth"></td>
		    </tr>
			  <tr>
	        <td><input type="number" id="zip_code" placeholder="우편번호"  class="myup"> <br><td><button id=ADRshow>주소검색</button></td>
  	    </tr>
        <tr>
	        <td colspan="2"><input type="text" id="adress"  placeholder="기본주소"  class="myup"></td>
	      </tr>
			  <tr>
			    <td colspan="2"><input type="text" id="adress2"  placeholder="상세주소"  class="myup"></td>
			  </tr>
			  <tr>
			    <td colspan="2"><input type="tel" id="mobile"  placeholder="핸드폰번호"  class="myup"></td>
			  </tr>
			  <tr>
			    <td colspan="2"><input type="email" id="mail" placeholder="이메일"  class="myup"></td>
			  </tr>
			  <tr>
			    <td colspan="2"><button id="btnupdate"  class='btnmyupdate'>수정완료</button></td>
			  </tr>
	      <tr>
		      <td colspan="2"><button id="btnclear"  class='btnmyupdate' >취소</button></td>
			  </tr>
			</table>
		</div>
  </main>
<footer id="footer">
	<%@ include file="include/footer.jsp" %>
</footer>

</body>

<script>
$(document)
.ready(function(){
	 setingData();
	 focusOnEmptyInput();
})

.on('click','#btnupdate',function(){
	$.ajax({
		type:'post', url:'/myModify',
		data:{user_id:$('#user_id').val(),name:$('#name').val(),birth:$('#birth').val(),zip_code:$('#zip_code').val(),
			  adress:$('#adress').val(), adress2:$('#adress2').val(), mobile:$('#mobile').val(),mail:$('#mail').val()}, 
		dataType:'text',
		success:function(data){
			if(data==1){
				alert('회원정보수정에 성공하였습니다')
				$('#name,#birth,#zip_code,#adress,#birth,#zipcode,#mobile,#mail').val('');
				location.href="/mypage";
			} else{
				alert('회원정보수정에 실패하였습니다')
				focusOnEmptyInput();
			}
		}
	})
})
.on('click','#btnclear',function(){
	location.href="/mypage";
})
.on('click','#ADRshow',function(){
	ADRshow();
})

function focusOnEmptyInput(){
	 $('#tblMyUpdate input').each(function() {
	      if ($(this).val() === '') {
	        $(this).focus();
	        return false; 
	      }
	 });
}



function setingData(){
	let id = '<%=(String)session.getAttribute("id")%>';
	alert(id)
	$.ajax({
		type:'post', url:'/myLoad',
		data:{user_id:id},
		dataType:'json',
		success:function(data){
				$('#name').val(data[0].name);
				$('#birth').val(data[0].birth);
				$('#zip_code').val(data[0].zipcode);
				$('#adress').val(data[0].adress);
				$('#adress2').val(data[0].adress2);
				$('#mobile').val(data[0].mobile);
				$('#mail').val(data[0].mail);
		}
	})
}

function ADRshow(){
    new daum.Postcode({
        oncomplete: function(data) {
            console.log(data);
            var roadAddr = data.roadAddress; // 도로명 주소 변수
            var jibunAddr = data.jibunAddress; // 지번 주소 변수
            $('#zipcode').val(data.zonecode) // 우편번호 넣는코드
            if(roadAddr!==''){              
               $('#adress').val(roadAddr) 
            }else if(jibunAddr!==''){
                $('#adress').val(jibunAddr)  //도로명이 없을경우 지번을 넣는다
            }
        }
    }).open();
}

</script>
</html>
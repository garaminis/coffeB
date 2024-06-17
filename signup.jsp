<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<title>Sign up</title>
<link href="/css/theme.css" rel="stylesheet" type="text/css">
<script src='http://code.jquery.com/jquery-latest.js'></script>
</head>
<style>
  
	table {
	  margin: 20px auto;
	  border-collapse: collapse;
	  border-radius: 8px;
	 
	}
	table tr td {
	  padding: 10px;
	  vertical-align: top;
	  font-family: 'YeongdeokSea';
	}
	.sign {
	  width: 100%;
	  padding: 10px;
	  border: 1px solid #ccc;
	  border-radius: 4px;
	  box-sizing: border-box;
	}
	button {
	  padding: 10px 10px;
	  width:70px;
	}
   .tosign {
   	 width: 100%;
    }
	#signup:hover {
	background-color:peru;
	}
	#zipcode {
	  width: 70%;
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
 	   <h1 ><br>회원가입</h1><br>
     <hr> 
		 <table id="tblSignup">
		  <tr style="display:none;">
              <td >로그인 API 아이디</td>
              <td><input type="text" id="userApiId" maxlength="12" readonly value=<%= id%>></td>
              <td></td>
          </tr>
           <% if (id == null) { %>
	     <tr>
	       <td>로그인 아이디</td>
	       <td><input type="text" id="userId" maxlength="12" class="sign"></td>
	       <td></td>
	     </tr>
	     <tr style="display: none;" >     
	       <td><input type="text" id="userIdCheck" class="sign"></td>
	     </tr>
	     <tr>
	       <td>비밀번호</td>
	       <td><input type="password" id="password" maxlength="12" class="sign"></td>
	       <td></td>
	     </tr>
	     <tr>
	       <td>비밀번호 확인</td>
	       <td><input type="password" id="passwordCheck" maxlength="12" class="sign"></td>
	       <td></td>
	     </tr>
	      <% } else { %>
                <h2>SNS회원가입</h2>
          <% } %>
	     <tr>
	       <td>이름</td>
	       <td><input type="text" id="userName" class="sign"></td>
	     </tr>
	      <tr>
           <td>닉네임</td>
           <td><input type="text" id="userNickname" class="sign"></td>
           <td></td>
         </tr>
	     <tr>
	       <td>생년월일</td>
	       <td><input type="date" id="birth" min="1900-01-01" class="sign"></td>
	     </tr>
	     <tr>
	       <td rowspan="3">주소 </td>
	       <td> <input type="number" id="zipcode"   placeholder="우편번호" class="sign">&nbsp;<button id=ADRshow>주소검색</button></td>
	     </tr>
	     <tr>
	       <td><input type="text" id="adress"  placeholder="기본주소" class="sign"></td>
	     </tr>
	     <tr>
	       <td><input type="text"  id="ADR_SangSoo"  placeholder="상세주소" class="sign"></td>
	     </tr>
	     <tr>
	       <td>핸드폰 번호 </td>
	       <td><input type="tel" id="mobile"  placeholder="010-0000-0000"  pattern="[0-9]{3}-[0-9]{4}-[0-9]{4}" required class="sign"></td>
	       <td></td>
	     </tr>
    	<% if (id != null) { %>
	     <tr>
	       <td>E-mail </td>
	       <td><input type="email" id="mail" class="sign"></td>
	     </tr>
     	<% } else { %>
	     <tr>
   			<td >E-mail</td>
   			<td><%@ include file="SendMail2.jsp" %></td> 
    	 </tr>
		<% } %>
	     <tr>
	       <td>성별 </td>
	       <td ><input type=radio name=gender value=male>남성 &nbsp; <input type=radio name=gender value=female>여성 </td>
	     </tr>
	     <tr>
	       <td colspan="2"><button id="signup" class="tosign">회원가입</button></td>
	     </tr>
	     <tr>
	       <td colspan="2"><button id="cancel" class="tosign">취소</button></td>
	     </tr>
			</table>
	  </div>
  </main>
	<footer id="footer">
		<%@ include file="include/footer.jsp" %>
	</footer>
</div>
</body>

<script>
$(document)
.ready(function() {	
   let mail = '<%= mail %>';   //처음에 설정된 session mail 변수선언
    if (mail == null || mail == "") {
        $('#mail').prop('readonly', false);	//mail을 가진 sns로그인이라면 메일을 넣고 readonly 없다면 풀기 
    }
     	focusOnEmptyInput();
     	$('#mail').val('<%= mail %>');
	})

.on('click','#signup',function(){
	/* alert($("#password").val().length)  */
	console.log($('#input_email').val());
	console.log($('#mail').val());
	 	 if ($('#userApiId').val() == "null" || $('#userApiId').val() == "") {
		if($('#userId').val() != $('#userIdCheck').val() || $('#userId').val() == ""){
			alert("ID 중복 확인해주세요.");
			$("#userId").focus();
		}else if($("#password").val().length < 4){
			alert("비밀번호가 너무 짧습니다. 4~12자");
			$("#password").focus();
		}else if($("#password").val() != $("#passwordCheck").val()){
			alert("비밀번호 확인해주세요.");
			$("#password,#passwordCheck").val('');
			$("#password").focus();
		}else if($('#userId').val() === '' || 
			$('#password').val() === '' || 
			$('#userName').val() === '' || 
			$('#mobile').val() === '' || 
			$('#mail').val() === '' || 
			$('#birth').val() === '' || 
			$('#adress').val() === '' || 
			$('#zipcode').val() === '' || 
			$('input[name="gender"]:checked').length === 0
		) {
			alert("빈칸에 값을 입력해주세요."); 
			focusOnEmptyInput();
		}else if ($('.auth_msg.msg').text() != "이메일 인증 성공!") {	//메일인증이 안되어있을경우
	        alert("이메일 인증을 해주세요")
	    }  else {
			 singup();
			 alert("회원가입 완료")
			 location.href="/login";
	    }
	}else {
	if ($('#userName').val() === '' ||
             $('#mobile').val() === '' ||
             $('#birth').val() === '' ||
             $('#adress').val() === '' ||
             $('#mail').val() === '' ||
             $('#zipcode').val() === '' ||
             $('input[name="gender"]:checked').length === 0) {//sns로그인일 경우
             alert("빈칸에 값을 입력해주세요.");
         } else {
             singup();
             alert("회원가입 완료")
             location.href = "/login";
         }
	} 
})

.on('click','#cancel',function(){
	location.href="/";
})
.on('click','#ADRshow',function(){
	ADRshow();
})
.on('keyup','#userId',function(){
	idcheck();
})

.on('keyup','#passwordCheck',function(){
	pswcheck();
})
.on('keyup', '#input_email', function() {	//숨어있는 email input에 따라서치기
            $('#mail').val($('#input_email').val())
 }) 
.on('keyup', '#userNickname', function() { //중복닉네임체크
    Nicknamecheck();
})
.on('click', '#header', function() { //헤더로 홈페이지갈경우 sns회원가입에 담긴 session값 날리기
 	<% session.invalidate(); %>
     $.ajax({
         type: 'post',
         url: '/logout',
         data: {},
         dataType: 'text',
         success: function(data) {}
     })
})




function singup(){	
	 if ($('#userApiId').val() == "null" || $('#userApiId').val() == "") { //sns로그인이 아닐때
	$.ajax({
		type:'post', url:'/doSignup',
		data:{  user_id: $('#userId').val(),
	            password: $('#password').val(),
	            name: $('#userName').val(),
	            userNickname: $('#userNickname').val(),
	            mobile: $('#mobile').val(),
	            mail: $('#input_email').val(),
	            birth: $('#birth').val(),
	            adress: $('#adress').val(),
	            zipcode: $('#zipcode').val(),
	            gender: $('input[name=gender]:checked').val(),
	            adress2: $('#ADR_SangSoo').val()  }, 
		dataType:'text',
		success:function(data){
			 if(data == 1){
				 $('#userId,#password,#passwordCheck,#userName,#birth,#zipcode,#address,#mobile,#mail').val('');
			 }else {
				 alert("회원가입 실패");
				 $('#userId,#password,#passwordCheck,#userName,#birth,#zipcode,#address,#mobile,#mail').val('');
			 }
		}
	})  
} else if ($('#userApiId').val() != null || $('#userApiId').val() != "") { //sns로그인일때
	  $.ajax({
        type: 'post',
        url: '/doApiSignup',
        data: {
            user_id: $('#userApiId').val(),
            password: $('#password').val(),
            name: $('#userName').val(),
            userNickname: $('#userNickname').val(),
            mobile: $('#mobile').val(),
            mail: $('#mail').val(),
            birth: $('#birth').val(),
            adress: $('#adress').val(),
            zipcode: $('#zipcode').val(),
            gender: $('input[name=gender]:checked').val(),
            adress2: $('#ADR_SangSoo').val()
        },
        dataType: 'text',
        success: function(data) {
            if (data == 1) {
                $('#userId,#password,#passwordCheck,#userName,#birth,#zipcode,#address,#mobile,#mail').val('');
            } else {
                alert("회원가입 실패");
                $('#userId,#password,#passwordCheck,#userName,#birth,#zipcode,#address,#mobile,#mail').val('');
            }
        }
    }) 
  }
}


function idcheck(){
	$.ajax({
		type:'post', 
		url:'/idcheck', 
		data: {userId:$('#userId').val()},
		dataType:'text',
		success:function(data){
		  if($("#userId").val().length < 4){
				 let str='<td style="color: red; text-align:center;"> Id가 너무 짧습니다. 4 ~ 12자</td>'; 
				 $('#tblSignup tr:eq(1) td:eq(2)').after (str);
		  } else {
			  if(data==1){
					 let str='<td style="color: red; text-align:center;"> 이미 사용중인 아이디입니다.</td>'; 
					 $('#tblSignup tr:eq(1) td:eq(2)').after (str);
				} else if(data==0 && $('#userId').val()==""){
					let str='<td style="color: red; text-align:center;"> 값을 입력해주세요.</td>'; 
					$('#tblSignup tr:eq(1) td:eq(2)').after (str);
				} else{
					let str='<td style="color: green; text-align:center;"> 가입가능한 아이디입니다.</td>'; 
					$('#tblSignup tr:eq(1) td:eq(2)').after (str);
					$('#userIdCheck').val($('#userId').val());
				}
		  }
			$('#tblSignup tr:eq(1) td:eq(2)').remove(); 
		}
	})  
}

function pswcheck(){
  if ($("#password").val() !== $("#passwordCheck").val() ) {
	  let str='<td style="color: red; text-align:center;"> 확인 비밀번호가 일치하지 않습니다.</td>'; 
	  $('#tblSignup tr:eq(3) td:eq(2)').after (str);
	} else{
	  let str='<td style="color: green; text-align:center;"> 확인 비밀번호가 일치합니다.</td>'; 
	  $('#tblSignup tr:eq(3) td:eq(2)').after (str);
	} $('#tblSignup tr:eq(3) td:eq(2)').remove();	
}

function focusOnEmptyInput(){
	 $('#tblSignup input').each(function() {
	      if ($(this).val() === '') {
	        $(this).focus();
	        return false; 
	      }
	 });
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
function Nicknamecheck() { //닉네임중복체크 함수
    if ($('#userApiId').val() != "null" || $('#userApiId').val() != "") { //sns회원가입인지 체크
        $.ajax({
            type: 'post',
            url: '/nicknamecheck',
            data: {
                userNickname: $('#userNickname').val()
            },
            dataType: 'text',
            success: function(data) {
                if ($("#userNickname").val().length < 3) { //닉네임이 3글자미만일때
                    let str = '<td style="color: red; text-align:center;"> 닉네임이 너무 짧습니다. 3 ~ 10자</td>';
                    $('#tblSignup tr:eq(2) td:eq(2)').after(str);
                } else {
                    if (data == 1) { //닉네임이 중복일때
                        let str = '<td style="color: red; text-align:center;"> 이미 사용중인 닉네임입니다.</td>';
                        $('#tblSignup tr:eq(2) td:eq(2)').after(str);
                    } else if (data == 0 && $('#userNickname').val() == "") { //아무것도 입력을 안했을때
                        let str = '<td style="color: red; text-align:center;"> 값을 입력해주세요.</td>';
                        $('#tblSignup tr:eq(2) td:eq(2)').after(str);
                    } else { //정상적인입력
                        let str = '<td style="color: green; text-align:center;"> 가입가능한 아이디입니다.</td>';
                        $('#tblSignup tr:eq(2) td:eq(2)').after(str);
                    }
                }
                $('#tblSignup tr:eq(2) td:eq(2)').remove();
            } //function(data)
        }) //ajax
    } //첫if문
    $.ajax({ //sns전용 닉네임체크
        type: 'post',
        url: '/nicknamecheck',
        data: {
            userNickname: $('#userNickname').val()
        },
        dataType: 'text',
        success: function(data) {
            if ($("#userNickname").val().length < 3) {
                let str = '<td style="color: red; text-align:center;"> 닉네임이 너무 짧습니다. 3 ~ 10자</td>';
                $('#tblSignup tr:eq(6) td:eq(2)').after(str);
            } else {
                if (data == 1) {
                    let str = '<td style="color: red; text-align:center;"> 이미 사용중인 닉네임입니다.</td>';
                    $('#tblSignup tr:eq(6) td:eq(2)').after(str);
                } else if (data == 0 && $('#userNickname').val() == "") {
                    let str = '<td style="color: red; text-align:center;"> 값을 입력해주세요.</td>';
                    $('#tblSignup tr:eq(6) td:eq(2)').after(str);
                } else {
                    let str = '<td style="color: green; text-align:center;"> 가입가능한 아이디입니다.</td>';
                    $('#tblSignup tr:eq(6) td:eq(2)').after(str);
                }
            }
            $('#tblSignup tr:eq(6) td:eq(2)').remove();
        }
    })
}
</script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script><!-- 다음카카오 주소API 스크립트 -->

</html>
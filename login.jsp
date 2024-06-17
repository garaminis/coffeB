<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<title>Login</title>
<script src='http://code.jquery.com/jquery-latest.js'></script>
</head>
<link href="/css/theme.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" href="http://cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">
<style>

table {
    margin: 0 auto;
    border-collapse: colapse;
} 

table tr td {
    padding: 10px;
    font-family: 'YeongdeokSea';
   
    
}


.dologin {
    width: 100%;
    padding: 10px;
    border: 1px solid #ddb48e;
    border-radius: 5px;
    box-sizing: border-box;
}
/* 아이콘들을 가로로 배열하기 */
.tbl-social td {
  display: flex;
  justify-content: space-between; /* 아이콘들 간의 간격을 동일하게 설정합니다. */
}

/* 각 아이콘에 대한 스타일 */
.tbl-social .g_id_signin,
.tbl-social .xi-kakaotalk {
  font-size: 40px;
  margin-top: 5px;
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
     
	<table id=tblLogin>
	  <tr>
	      <td> Login ID </td>
	      <td><input type="text" id="loginId" class=dologin>  </td>
      </tr>
      <tr>
   <td> Password </td>
   		<td><input type="password" id="password" class=dologin></td>
	</tr>
   <tr style="color: red; display: none;" id='error'>
		<td colspan="2">아이디 또는 비밀번호를 잘못 입력했습니다.<br>입력하신 내용을 다시 확인해주세요.</td>
   </tr>
   <tr>
    	<td colspan="2">
	       <table class="tbl-social">
	           <tr>
	               <td >
	                   <div id="g_id_onload"
	                       data-client_id="418242612512-vrgp2hmudip7i62aa2o66s0l10esqub6.apps.googleusercontent.com"
	                       data-callback="handleCredentialResponse">
	                   </div>
	                   <div>
	                       <a data-type="icon" data-shape="circle" class="g_id_signin"></a>
	                   </div>
	                   <div>
	                       <a href="javascript:kakaoLogin()" class="icon" style="margin-top: 20px;"><i class="xi-kakaotalk" style="font-size: 40px; margin-top: 5px;"></i></a>
	                   </div>
	               </td> 
	             </tr>
	             <tr>
	                <td>
	                	<a href="Find_Id_Pw?key=1">아이디 찾기</a>&nbsp;&nbsp;&nbsp;
	                	<a href="Find_Id_Pw?key=2">비밀번호 찾기</a>
	                </td>
	            </tr>
	       </table>   
    	</td>
     </tr>
     <tr>
	      <td colspan="2"> <button id=btnLogin class=dologin >로그인</button></td>
  	 </tr>
     <tr> 
	      <td colspan="2"> <button id=btnSignup  class=dologin>회원가입</button>
	 </tr>
	 </table>
    </div>
  </main>
  
  <footer id="footer">
  	<%@ include file="include/footer.jsp" %>
  </footer>
</div>
</body>

<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
<script src="https://accounts.google.com/gsi/client" async defer></script>
<script>
$(document)
.ready(function(){
	$('#loginId').focus();
	sessionStorage.clear(); // session초기화 
})
.on('click','#btnLogin',function(){
  $.ajax({
		type:'Post',
		url:'/dologin' ,
		data:{loginId:$('#loginId').val(),
			  passwd:$('#password').val()},
		dataType:'text',
		success:function(data){
			if(data=='1'){
				$('#loginId,#password').val('');
				location.href="/";
			} else if(data=='2'){
				alert("관리자로그인 성공");
				console.log("관리자로그인 성공");
				$('#loginId,#password').val('');
				location.href="/";
			}else{
				$('#error').show();
				$('#loginId,#password').val('');
				$('#loginId').focus();
			}
		}
	}) 
	return false;
})

.on('click','#btnSignup',function(){
	location.href="/signup";
}) 
.on('keypress', '#password', function(e, u) { 
     if (e.keyCode == 13) {
         $('#btnLogin').trigger('click')
     }
 })
        
           <!---------------카카오---------------->
Kakao.init('3b2f457b00e111fed673d2b10585bc1f');       
function kakaoLogin() {
	
    Kakao.Auth.login({
        success: function(response) {
            Kakao.API.request({
                url: '/v2/user/me',
                success: function(response) {
                    let userId = response.id; // 사용자 ID
                    kakaoLogout();
                    $.ajax({
                        type: 'POST',
                        url: '/APIidcheck',
                        data: {
                            user_id: userId // 사용자 ID 전달  
                           
                        },
                        dataType: 'text',
                        success: function(data) {
                        	
 
                            if (data == 1) {
                                location.href = "/";
                            } else {
                                location.href = "/signup";
                            }
                        }
                    });
                },
                fail: function(error) {
                    console.log(error);
                }
            });
        },
        fail: function(error) {
            console.log(error);
        }
    });
}


    //카카오로그아웃  
    function kakaoLogout() {
        if (Kakao.Auth.getAccessToken()) {
            Kakao.API.request({
                url: '/v1/user/unlink',
                success: function(response) {
                    console.log(response)
                },
                fail: function(error) {
                    console.log(error)
                },
            })
            Kakao.Auth.setAccessToken(undefined)
        }
    } 
    <!---------------구글---------------->
   function handleCredentialResponse(response) {
        const responsePayload = parseJwt(response.credential);
        $.ajax({
        	type: 'Post',
        	url: '/APIidcheck',
        	data: {user_id: responsePayload.sub,mail: responsePayload.email},
        	dataType: 'text',
        	success: function(data) {
                if (data == 1) {
                    location.href = "/";
                } else {
                	location.href = "/signup";
                }
        	}
        })
    };
 // JWT 토큰 디코딩 함수
    function parseJwt(token) {
        const base64Url = token.split('.')[1];
        const base64 = base64Url.replace(/-/g, '+').replace(/_/g, '/');
        const jsonPayload = decodeURIComponent(atob(base64).split('').map(function(c) {
            return '%' + ('00' + c.charCodeAt(0).toString(16)).slice(-2);
        }).join(''));

        return JSON.parse(jsonPayload);
    };
</script>
 
</html>
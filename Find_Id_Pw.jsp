<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<link href="/css/theme.css" rel="stylesheet" type="text/css">
<head>
<style>


h2 {
    text-align: center; /* 제목 가운데 정렬 */
    font-size: 24px; /* 적절한 제목 크기 설정 */
    margin-bottom: 20px; /* 제목 아래 여백 설정 */
}

#mainContent {
    text-align: center; /* 메인 컨텐츠 가운데 정렬 */
}

table {
    margin: 0 auto; /* 테이블 가운데 정렬 */
    border-collapse: collapse; /* 테이블 셀 간 간격 제거 */
}



</style>
</head>
 <header id="herder">
   	<%@ include file="include/header.jsp" %>
  </header>

  <nav id="nav">
  	<%@ include file="include/nav.jsp" %>
  </nav>

<body id="page-top">

<div class="container">
    <main id="main">
        <h2>아이디찾기</h2>
        <div id="mainContent">
            <table>
                <tr>
                    <td><%@ include file="SendMail2.jsp" %></td>
                </tr>
            </table>
        </div>
    </main>
    </div>
    <footer id="footer">
        <%@ include file="include/footer.jsp" %>
    </footer>
</body>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script>
 $(document).
 ready(function() {

     })
     .on('click', '.AuthBtn', function() { //인증코드 성공시 이메일보여주는코드
         if ($('.auth_msg.msg').text() == "이메일 인증 성공!") {//만약 이메일인증성공이란 텍스트로 바뀌지않았다면 false
             $.ajax({
                 type: 'post',
                 url: '/getMail',
                 data: {
                     mail: $('#input_email').val()
                 },
                 dataType: 'text',
                 success: function(data) {
                     if (data == "1") { //컨트롤러에서 1을 반환하면 이메일은 있지만 비밀번호가없으면 sns로그인인걸 확인
                         alert("sns로그인으로 등록된 이메일입니다 알맞은 사이트에서 찾아주세요")
                         location.href = "/login";
                     } else if (data == "3") { //컨트롤러에서 3을반환하면 현 이메일로 가입한 아이디가없음
                         alert("이 이메일로 가입된 아이디가 없습니다")
                         location.href = "/login";
                     } else { //정상적인 입력 *로 가려진 아이디를 alert알림으로 띄워줌
                         alert("당신의 아이디는" + data + "입니다. 보안상 중간은 가려져있습니다")
                         location.href = "/login";
                     }
                 }//function
             })//ajax
         }//첫if문 END
     })//on click
</script>

</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<link href="/css/theme.css" rel="stylesheet" type="text/css">
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

 #Input_Id {
        padding: 10px;
        border: 1px solid #ccc;
        border-radius: 5px;
        margin: 0; /* 기본 마진 제거 */
        width: 100%; /* 테이블 셀의 전체 너비를 차지하도록 설정 */
    }
.container {
    display: flex;
    justify-content: center; /* 수평 가운데 정렬 */
    align-items: center; /* 수직 가운데 정렬 */  
}

#main {
    width: 50%; /* 컨테이너의 절반 너비로 설정 */
}

/* include된 파일의 스타일(여기서는 SendMail2.jsp) */
td {
    padding-top: 10px; /* 내용과의 간격 설정 */
}

</style>
<head>
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
        <h2>비밀번호 찾기</h2>
        <div id="mainContent">
            <table>
                <tr>
                    <td><input id="Input_Id" type="text" placeholder="본인의 아이디를 입력해주세요"></td>
                </tr>
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
    $(document).ready(function() {

        })
        .on('click', '.AuthBtn', function() { //SendMail2.jsp 에 담긴 버튼함수 마지막 인증하기버튼임
            // 인증코드 성공시 비밀번호 초기화
            if ($('.auth_msg.msg').text() == "이메일 인증 성공!") { //이메일을보내고 인증코드가 맞을경우
                $.ajax({
                    type: 'post',
                    url: '/Check_Mail_Id',
                    data: {
                        mail: $('#input_email').val(),
                        id: $('#Input_Id').val()
                    },
                    dataType: 'text',
                    success: function(data) { //data에서 1을반환할경우 아이디와 인증된이메일이 db에 담겨있다
                        if (data == 1) {
                            if (confirm("비밀번호를 초기화 시키겠습니까?")) { //비밀번호 초기화,아니요 시 로그인페이지로
                                let newpass = prompt("새로운비밀번호는?");
                                $.ajax({
                                    type: 'post',
                                    url: '/resetPass',
                                    data: {
                                        id: $('#Input_Id').val(),
                                        newPass: newpass
                                    },
                                    dataType: 'text',
                                    success: function(data) {
                                        location.href = "/login";
                                    }
                                })
                            } else {
                                location.href = "/login";
                            }
                        } else { //아이디 혹은 이메일이 맞지않을경우
                            alert("아이디 혹은 이메일을 다시확인해주세요")
                            location.href = "/Find_Id_Pw?key=2";
                        }
                    }//function(data)
                })//ajax문
            }//첫if문
        })//onclick
</script>

</html>
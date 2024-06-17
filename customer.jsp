<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="/css/theme.css" rel="stylesheet" type="text/css">
</head>
<style>
   
  .square {
    width: 100px;
    height: 100px;
    background-color: blue;
    margin: 10px;
    display: inline-block;
  }
    #middle_bottom {
  display: flex;
  justify-content: space-around; /* 요소들 사이의 간격을 자동으로 조절합니다. */
}
.middleMenu {
  flex: 1; /* 요소들이 동일한 너비를 가지도록 합니다. */
  text-align: center; /* 텍스트를 가운데 정렬합니다. */
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
  
 <main>
    <div class="mainContent">
      <div id="middle_box">
        <div id="middle_top">
          <h1 class="middle_top_title">고객센터</h1>
          <hr class="middle_top_hr">
        </div>
        <div id="middle_bottom">
          <div class="middleMenu"><a href="/notice"><img src="/img/logo/notice2.jpg" id="" ></a></div> 
          <div class="middleMenu"><a href="/Qna"><img src="/img/logo/qna.jpg" id=""></a></div>
          <div class="middleMenu"><a href="/faq"><img src="/img/logo/faq.jpg" id=""></a></div>
          <div class="middleMenu"><a href="/myAbout"><img src="/img/logo/myq.jpg" id=""></a></div>
        </div>
      </div>
	</div>
 
 
  </main>
  <footer id="footer">
  	<%@ include file="include/footer.jsp" %>
  </footer>
</body>    
</body>
</html>
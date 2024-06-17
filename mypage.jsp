<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>My Page</title>
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
<% if (id == null) { %> 
	<jsp:forward page="login.jsp" />
<%} else {%>
  <main>
    <div class="mainContent">
      <div id="middle_box">
        <div id="middle_top">
          <h1 class="middle_top_title">마이페이지</h1>
          <hr class="middle_top_hr">
        </div>
        <div id="middle_bottom">
          <div class="middleMenu"><a href="/myOrderList"><img src="/img/logo/order.png" id=""></a></div>
          <div class="middleMenu"><a href="/cart"><img src="/img/logo/cart.png" id=""></a></div>
          <div class="middleMenu"><a href="/myAbout"><img src="/img/logo/myQ.jpg" id=""></a></div>
          <div class="middleMenu"><a href="/myUpdate"><img src="/img/logo/myup.png" id=""></a></div>
        </div>
      </div>
    </div>
  </main>
<%} %>  
  <footer id="footer">
  	<%@ include file="include/footer.jsp" %>
  </footer>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>나의 주문내역</title>
<link href="/css/theme.css" rel="stylesheet" type="text/css">
<style>
	* {
	    margin: 0;
	    padding: 0;
	    box-sizing: border-box;
	}
	
	section {
	    margin: 20px;
	}
	
	section > div > ul {
	    list-style-type: none;
	}
	
	section > table {
	    width: 100%;
	    border-collapse: collapse;
	}
	
	section > table th,
	section > table td {
	    border: 1px solid #ccc;
	    padding: 10px;
	    text-align: center;
	}
	
	section > table input[type="checkbox"] {
	    transform: scale(1.5);
	}
	
	
	section > table img {
	    width: 50px;
	    height: auto;
	}
	
	section > table .price {
	    font-weight: bold;
	}
	
	
	section > div > button {
	    margin-top: 10px;
	    padding: 10px 20px;
	    font-size: 16px;
	    border: none;
	    cursor: pointer;
	    background-color: black;
	    color: whitesmoke;
	}
	
	section > div > button:hover {
	    background-color: black;
	}
	}
    .click_td {
        cursor: pointer;
    }
	  
</style>
</head>

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
    <div class="">
      <div id="">
        <div id="">
          <h1 class="middle_top_title">주문 배송 현황</h1>
          <hr class="middle_top_hr">
    </div>
 <% if (id!=null) { %>   
   <section>
     <table>
       <thead>
           <tr>
               <td>주문날짜</td>
               <td colspan="2">상품정보</td>
               <td>수량</td>
               <td>결제금액</td>
               <td>주문상태</td>
               <td>확인/신청</td>
           </tr>
       </thead>
       <tbody>
       <c:if test="${empty orderItems}">
         <tr><td colspan="7">주문내역이 없습니다.</td></tr>
       </c:if>
       <c:forEach var="item" items="${orderItems}" varStatus="status">
           <tr>
           <input type="hidden" style="display:none" class="orderId" value="${item.group_id}">
               <td>${item.date}</td>
               <td class="click_td" onclick="window.location='/goods?id=${item.goods_id}'">
                  <img src="${item.img1}" alt="상품이미지">
               </td>
               <td class="click_td" onclick="window.location='/goods?id=${item.goods_id}'">
                   <p>${item.title}</p>
               </td>
               <td>
                 ${item.cnt}
               </td>
                 <td class="aPrice">${item.total}</td>
               <td class="orderState">${item.state_name}</td>
               <c:if test="${item.state_id != 4}">
               <td class="btnBox"><button class="btn_arrive">수취확인</button></td>
               </c:if>
               <c:if test="${item.state_id == 4 && item.review_id == 0}">
               <form method='post' action="/writeReview">
                 <input type="hidden" style="display:none" name="order_id" value="${item.order_id}">
                 <input type="hidden" style="display:none" name="goods_id" value="${item.goods_id}">
				 <td><button type="submit"  class="btn_review">리뷰작성</button></td>
			   </form>
               </c:if>
               <c:if test="${item.state_id == 4 && item.review_id != 0}">
               <td>리뷰작성완료</td>
               </c:if>
           </tr>
           </c:forEach>

       </tbody>
     </table>
     <a href="/"><button>홈으로</button></a>
     <a href="/mypage"><button>마이페이지</button></a>
    </section>
<% }   %> 
</div>
</div>
  </main>
<%} %>  
  <footer id="footer">
  	<%@ include file="include/footer.jsp" %>
  </footer>
</div>
<script src='http://code.jquery.com/jquery-latest.js'></script>
<script>
$(document)
.ready(function(){
	
})

.on('click','.btn_arrive',function(){
	let order_id = $(this).closest('tr').find(".orderId").val();
	let btn = $(this)
	alert("수취확인 하셨습니다.")
	alert(order_id)
	$.ajax({
		type:'post', url:'/stateUpdate',
		data: {order_id : order_id},
		dataType:'text',
		success:function(data){
			btn.closest('tr').find(".orderState").val(data);
			document.location="/myOrderList"
			
		}
	})
})


</script>
</body>
</html>
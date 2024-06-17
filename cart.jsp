<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>장바구니</title>
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
	button.doOrder {
	   padding: 13px 30px;
	   background-color: peru;
	   color: #ffffff;
	   border: none;
	   border-radius: 4px;
	   cursor: pointer;
	   font-family: 'YeongdeokSea';
	   margin-right: 10px;
	   width: 150px;
	   font-size:15px;
	}

	button.doOrder:hover {
    	background-color: #a58e7f;
    	width: 150px; 
	}
	form button {
    	margin-top: 10px; /* 버튼 위에 10px의 공간을 추가합니다. */
	}
	.plus,.minus {
	    background-color: peru; /* 버튼 배경색 */
	    color: #ffffff; /* 글자색 */
	    border: none;
	    border-radius: 4px;
	    cursor: pointer;
	    font-family: 'YeongdeokSea'; /* 글꼴 */
	    margin-top: 5px; /* 상단 여백 */
	    display: inline-block;
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
          <h1 class="middle_top_title"> 장바구니</h1>
          <hr class="middle_top_hr">
    </div>
 <% if (id!=null) { %>   
   <section>
     <table>
       <thead>
           <tr>
               <td><input type="checkbox" id="allCheck" checked="on"></td>
               <td colspan="2">상품정보</td>
               <td>옵션</td>
               <td>상품금액</td>
               <td>배송비</td>
           </tr>
       </thead>
       <tbody>
       <c:if test="${empty cartItems}">
         <tr><td colspan="6">장바구니가 비어있습니다.</td></tr>
       </c:if>
       <c:forEach var="item" items="${cartItems}" varStatus="status">
           <tr >
               <td rowspan="2"><input type="checkbox" name="cart" class="updateCart" value="${item.cart_id}" checked="on"></td>
               <td rowspan="2" class="click_td" onclick="window.location='/goods?id=${item.goods_id}'">
                   <img src="${item.img1}" alt="magic keyboard">
               </td>
               <td class="click_td" onclick="window.location='/goods?id=${item.goods_id}'">
                   <p>${item.title}</p>
               </td>
               <td rowspan="2">
                   수량 :  <input type="text" class="amount" value="${item.cnt}" size="1" readonly>
                   <input type="button" class=plus value=" + ">
                   <input type="button" class=minus value=" - ">
               </td>
                 <td class="aPrice" rowspan="2">${item.total}</td>
               <td rowspan="2" >${item.pay}</td>
           </tr>
           <tr>
           <td class="Price click_td" onclick="window.location='/goods?id=${item.goods_id}'">${item.price}</td>
           </tr>
           </c:forEach>

       </tbody>
     </table>
     <input id="sum" style="border:none">
        <div>
            <button id=btn_shopping class="doOrder">쇼핑 계속하기</button>
            <button id=btn_select_delete  class="doOrder">선택상품삭제</button>
            <button id=btn_delete  class="doOrder">전체삭제</button>  
			<form method='get' action="/order" id="cartToOrder">
				<input type="hidden" style="display=none;" name="sendOrder" id="sendOrder">
				<button id=btn_select_order  class="doOrder">선택상품주문</button>
				<button id=btn_order  class="doOrder">전체상품주문</button>
			</form>
        </div>
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

.on('click','#btn_shopping',function(){
	location.href="/";
})

.on('click','.plus',function() {    
      let number = $(this).parent().find('input.amount');
      number.val(parseInt(number.val()) + 1);
      let sPrice=$(this).closest('tr').next().find('.Price').text();
      let quantit=number.val();
      $(this).closest('tr').find('.aPrice').text(quantit * sPrice)
      
      let id = $(this).closest('tr').find('td:first-child .updateCart').val()
      alert(id)
      	$.ajax({
		type:'post', url:'/updateCart',
		data: {id:id, cnt: number.val()},
		dataType:'text',
		success:function(data){
			alert("성공")
		}
	})
})

.on('click','.minus',function() {    
      let number = $(this).parent().find('input.amount');
      if($(this).parent().find('input.amount').val()==1){
          return false;
       }
      number.val(parseInt(number.val()) - 1);
      let sPrice=$(this).closest('tr').next().find('.Price').text();
      let quantit=number.val();
      $(this).closest('tr').find('.aPrice').text(quantit * sPrice)
      
      let id = $(this).closest('tr').find('td:first-child .updateCart').val()
      alert(id)
      	$.ajax({
		type:'post', url:'/updateCart',
		data: {id:id, cnt: number.val()},
		dataType:'text',
		success:function(data){
			alert("성공")
		}
	})
})

.on('change', '#allCheck', function () {
        $('input[name="cart"]').prop('checked', $(this).prop('checked'));
    })
    
    
.on('click','#btn_select_delete',function(){
    let checked = [];
    $('input[name="cart"]:checked').each(function () {
        checked.push(this.value);
    })
	alert(checked)
	$.ajax({
		type:'post', url:'/delCart',
		data: {checked: checked},
		dataType:'text',
		success:function(data){
			location.href="/cart";
		}
	})
})

.on('click','#btn_delete',function(){
    let checked = [];
    $('input[name="cart"]:checkbox').each(function () {
        checked.push(this.value);
    })
	alert(checked)
	$.ajax({
		type:'post', url:'/delCart',
		data: {checked: checked},
		dataType:'text',
		success:function(data){
			location.href="/cart";
		}
	})
})

.on('click','#btn_order, #btn_select_order',function(){
    let checked = [];
    $('input[name="cart"]:checked').each(function () {
        checked.push(this.value);
    })
    let checkedStr = checked.join(',');
	$('#sendOrder').val(checkedStr);
	alert($('#sendOrder').val());
	
	if ($('#sendOrder').val() != '') {//제출
		$('#cartToOrder').submit();
	} else {
		alert("주문할 상품을 선택해주세요")
		return false;
	}
})

/* $("#minus").click(function() {    
    var number = $(this).parent().find('input#amount');
    number.val(parseInt(number.val()) - 1);
}); */

</script>
</body>
</html>
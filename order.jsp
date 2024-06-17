<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <title>홈</title>
    <link href="/css/theme.css" rel="stylesheet" type="text/css">
    <style>
	table {
	    width: 100%;
	    border-collapse: collapse;
	}
	
	th, td {
	    border: 1px solid #ccc;
	    padding: 10px;
	    text-align: center;
	}
	#mainContent {
  		 display: flex; 
	}
	.sOrder{
	width: 80%;
	margin-right: 20px;
	margin: 100px 20px;

	}
	.sOrder2 {
    	float:left;
    	width: 60%;
    	height: 100%;
    	margin-right: 20px;
    	margin: 20px 20px;
   }
   .sOrder3{
   		float:left;
    	width: 30%;
    	height: 100%;
    	margin-right: 20px;
    	margin: 20px 20px;	
   }
   .sOrder2_d{
   		margin: 20px 20px;
   }
   
   #zipcode2{
   		 width: 108px;
   }
   #ADRshow1{
   		padding: 10px 10px;
	 	width:70px;
   }
   .sPayment{
   		 margin-top: 15px;
   }
}</style>
<script src="https://code.jquery.com/jquery-latest.js"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script><!-- 다음카카오 주소API 스크립트 -->
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
    <main id="main">
      <div id="mainContent">
        <div id="middle_top">
          <h1 class="middle_top_title">주문/결제</h1>
          <hr class="middle_top_hr">
        </div>
        <div class='sOrder'> <!--총 정보를 감싼 DIV-->
          <div>
          <h2>1. 주문상품 정보</h2>
     <table>
       <thead>
           <tr>
               <td colspan="2">상품정보</td>
               <td>옵션</td>
               <td>상품금액</td>
               <td>배송비</td>
           </tr>
       </thead>
       
       <tbody>
       <c:forEach var="item" items="${cartItems}" varStatus="status">
      
        <input type="hidden" style="display:none" class="cartId" value="${item.cart_id}">
           <tr >
               <td rowspan="2">
                   <img src="${item.img1}" alt="상품이미지" style="width:75px;">
               </td>
               <td>
                   <p>${item.title}</p>
               </td>
               <c:if test="${cnt == null}"> <!-- 장바구니에서 올경우 -->
               <input type="hidden" style="display:none" class="orderGoodsId" value="${item.goods_id}">
               <td rowspan="2">
                   수량 :  <input type="text" class="amount" value="${item.cnt}" size="1" readonly>
                   <input type="hidden" style="display:none" class="orderGid" value="0">
               </td>
               <td class="aPrice" rowspan="2">${item.total}</td>
               </c:if>
               <c:if test="${cnt != null}"> <!-- 상세페이지에서 올경우 -->
               <input type="hidden" style="display:none" class="orderGid" value="${item.id}">
               <td rowspan="2">
                   수량 :  <input type="text" class="amount" value="1" size="${cnt}" readonly>
               </td>
	               <%
	               String itemPrice = (String) request.getAttribute("price");
	               String itemCount = (String) request.getAttribute("cnt");
	
	    			if (itemPrice != null && itemCount != null) {
	    				int price1 = Integer.parseInt(itemPrice);
	   					int cnt1 = Integer.parseInt(itemCount);
	    				int total1 = price1 * cnt1;
					%>
               <td class="aPrice" rowspan="2"><%= total1 %></td>
               <%} %>
               </c:if>
               <td rowspan="2" class="delPay">${item.pay}</td>
           </tr>
           <tr>
           <td class="Price">${item.price}</td>
           </tr>
       </c:forEach>
       </tbody>
     </table>
            <br>
            <table>
              <thead>
                <tr>
                  <th>상품금액</th>
                  <th>배송비</th>
                  <th>할인금액</th>
                  <th>결제 예정금액</th>
                </tr>
              </thead>
              <tbody>
                <tr>
                  <td id=goodsPrice></td>
                  <td id=delPrice></td>
                  <td id=discount>0</td>
                  <td id=finalPrice></td>
                </tr>
              </tbody>
            </table>
          </div>
          <div class='sOrder2'> <!--구매자 정보,배송지 정보,결제정보 DIV-->
            <div class='sOrder2_d'><!--구매자 정보DIV-->
              <h2>2. 구매자 정보</h2>
              <table>
                <tr>
                  <td>이름</td>
                  <td><input class="name" type="text" value="${userInfo[0].name}" readonly></td>
                </tr>
                <tr>
                  <td>이메일</td>
                  <td><input class="mail" type="text" value="${userInfo[0].mail}" readonly></td>
                </tr>
                <tr>
                  <td>모바일번호</td>
                  <td><input class="mobile" type="text" value="${userInfo[0].mobile}" readonly></td>
                </tr>
			     <tr hidden="">
			       <td rowspan="3">배송지 </td>
			       <td> <input id="zipcode1" value="${userInfo[0].zipcode}"></td>
			     </tr>
			     <tr hidden="">
			       <td><input id="adress1" value="${userInfo[0].adress}"></td>
			     </tr>
			     <tr hidden="">
			       <td><input id="sAdress1" value="${userInfo[0].adress2}"></td>
			     </tr>
              </table>
            </div>
            <div class='sOrder2_d'><!--배송지 정보DIV-->
              <h2>3. 배송지 정보</h2>
              <h3><input type="checkbox" class="sameOrder">주문자와 동일</h3>
              <table>
                <tr>
                  <td>이름</td>
                  <td><input class="tkname" type="text"></td>
                </tr>
			     <tr>
			       <td rowspan="3">배송지 </td>
			       <td> <input type="number" id="zipcode2" readonly>&nbsp<button id=ADRshow1>주소검색</button></td>
			     </tr>
			     <tr>
			       <td><input type="text" id="adress2" readonly></td>
			     </tr>
			     <tr>
			       <td><input type="text"  id="sAdress2" placeholder="상세주소"></td>
			     </tr>
                <tr>
                  <td>연락처</td>
                  <td><input class="tkmobile" type="text"></td>
                </tr>
                <tr>
                  <td>배송시 요청사항</td>
                  <td><input type="text" id="delreq"></td>
                </tr>
              </table>
            </div>
            <div class='sOrder_d'><!--결제 정보 DIV-->
              <h2>4. 결제정보</h2>
              <table>
                <tr>
                  <td>결제방법</td>
                  <td>
	                <input type="radio" name="payment" value=1>계좌이체
	                <input type="radio" name="payment" value=2>신용/체크카드
	                <input type="radio" name="payment" value=3>간편결제
	                <input type="radio" name="payment" value=4>휴대폰
	                <input type="radio" name="payment" value=5>무통장입금
                  </td>
                </tr>
              </table>
            </div>
          </div>
          <div class='sOrder3'>
          <div><!--주문목록 총정보DIV--><!--주문목록 테이블 DIV-->
            <h2>최종결제금액</h2>
            <table>
              <tr><td colspan=2>최종결제금액</td></tr>
              <tr><td colspan=2 id="final"></td></tr>
              <tr><td>상품가격</td><td id="goodsPrice2"></td></tr>
              <tr><td>배송비</td><td id="delPrice2"></td></tr>
              <tr><td>할인금액</td><td id="discount2" style="color:red">-0</td></tr>
            </table>
          </div>
          <div class='sPayment'>
            <button id="btnOrder">결제하기</button>
        </div>
        </div>
     </main>
<%} %>  
     <footer id="footer">
       <%@ include file="include/footer.jsp" %>
     </footer>
  </div>
</body>

<script>
let tossPayments = TossPayments("test_ck_vZnjEJeQVxROqX5KlRxM8PmOoBN0");
$(document)
.ready(function() { /*체크표시하면 주문자와 동일한 값 가져오는 함수 */

  $(".sameOrder").change(function() {
    if ($(".sameOrder").is(":checked")) {
      $(".tkname").val($(".name").val())
      $("#zipcode2").val($("#zipcode1").val())
      $("#adress2").val($("#adress1").val())
      $("#sAdress2").val($("#sAdress1").val())
      $(".tkmobile").val($(".mobile").val())
    } else {
      $(".tkname").val("")
      $("#zipcode2").val("")
      $("#adress2").val("")
      $("#sAdress2").val("")
      $(".tkmobile").val("")
    }
  })

$('#goodsPrice, #goodsPrice2').text(setingGoodsPrice());
	setingDelPrice();
	$('#finalPrice').text(Number($('#goodsPrice').text()) + Number($('#delPrice').text()) - Number($('#discount').text()))
	$('#final').text($('#finalPrice').text())
})

.on('click','#ADRshow1',function(){
	ADRshow1();
})

.on('click','#btnOrder',function(){
	
	if($('.tkname').val() === '' || 
		$('#zipcode2').val() === '' || 
		$('#adress2').val() === '' || 
		$('#sAdress2').val() === '' || 
		$('.tkmobile').val() === '' || 
		$('input[name="payment"]:checked').length === 0
	) {
			alert("빈칸있음 확인부탁"); 
	}
	let delPrice = ($("#delPrice").text() == 2500? '1' : '2')
	
	pay();
	
	
	let cart_id = [];
	let goods_id = [];
	let price = [];
	let cnt = [];
	
    $('.cartId').each(function () {
        cart_id.push(this.value);
    })
    let cart_id_str = cart_id.join(',');
    
    $('.orderGoodsId').each(function () {
        goods_id.push(this.value);
    })
    let goods_id_str = goods_id.join(',');
    
    $('.amount').each(function () {
        cnt.push(this.value);
    })
    let cnt_str = cnt.join(',');
    
    $('.Price').each(function () {
        price.push($(this).text());
    })
    let price_str = price.join(',');
	
    console.log("cart_id : " + cart_id_str)
    console.log("goods_id : " + goods_id_str)
    console.log("g_id : " + $('.orderGid').val())
    console.log("cnt : " + cnt_str)
    console.log("price : " + price_str)
    console.log("tkname : " + $('.tkname').val())
    console.log("delzipcode : " + $('#zipcode2').val())
    console.log("deladress : " + $('#adress2').val())
    console.log("deladress2 : " + $('#sAdress2').val())
    console.log("delmobile : " + $('.tkmobile').val())
    console.log("delreq : " + $('#delreq').val())
    console.log("dele : " + delPrice)
    console.log("pament : " + $('input[name=payment]:checked').val())
    
	$.ajax({
		type:'post', url:'/saveOrder',
		data:{cart_id : cart_id_str, g_id : $('.orderGid').val(), goods_id : goods_id_str, cnt : cnt_str, price : price_str, delname : $('.tkname').val(), delzipcode : $('#zipcode2').val(), deladress : $('#adress2').val(), deladress2 : $('#sAdress2').val(), delmobile : $('.tkmobile').val(), delreq : $('#delreq').val(), delprice : delPrice ,payment : $('input[name=payment]:checked').val()}, 
		dataType:'text',
		success:function(data){
			if(data==1){
				alert('주문성공')
				location.href="/orderEnd";
			} else{
				alert('주문실패')
			}
		}
	})
})

    function setingOrder(){
	
    	let id = '<%=(String)session.getAttribute("id")%>';
    	$.ajax({
    		type:'post', url:'/orderData',
    		data:{user_id:id},
    		dataType:'json',
    		success:function(data){
    				$('.name').val(data[0].name);
    				$('.mail').val(data[0].mail);
    				$('.mobile').val(data[0].mobile);
    				$('.adress').val(data[0].adress);
    		}
    	})
    }
    
    function setingGoodsPrice(){
    let totalPrice = $(".aPrice");
    let sum = 0;

    totalPrice.each(function() {
        let price = $(this).text();
        sum += Number(price);
    });
		return sum;
    }
    
    function setingDelPrice(){
        let totalPrice = $(".delPay");
        let sum = 0;

        totalPrice.each(function() {
            let price = $(this).text();
            sum += Number(price);
        });
        
        if(setingGoodsPrice() > 50000 || setingGoodsPrice() == '0') {
        	$("#delPrice, #delPrice2").text(0);
        } else if (sum >= 2500){
        	$("#delPrice, #delPrice2").text(2500);
        } else {
        	$("#delPrice, #delPrice2").text(sum);
        }
    }
    
    function ADRshow1(){
        new daum.Postcode({
            oncomplete: function(data) {
                console.log(data);
                var roadAddr = data.roadAddress; // 도로명 주소 변수
                var jibunAddr = data.jibunAddress; // 지번 주소 변수
                $('#zipcode2').val(data.zonecode) // 우편번호 넣는코드
                if(roadAddr!==''){              
                   $('#adress2').val(roadAddr) 
                }else if(jibunAddr!==''){
                    $('#sAdress2').val(jibunAddr)  //도로명이 없을경우 지번을 넣는다
                }
            }
        }).open();
    }
        

	
	function pay() {
		let orderName = TitleName();
		let orderQuantity = quantity();
		let orderid = orderidtest();
		let userid = useridName();
		let checkbox = checkbox1();
	    
		const method="카드";
		const requestJson= {
				"amount": window.amount,
	            "orderId": "sample-" + orderId,
	            "orderName": orderName,
	            "orderid": orderid,
	            "userid": userid,
	            "orderQuantity": orderQuantity,
	            "checkbox": checkbox,
	            "customerName": userid,
	            "successUrl": successUrl,
	            "failUrl": failUrl
	            
		}
		console.log("---------------------")
		console.log("orderName:", orderName);
		console.log("amount:",amount);
		console.log("orderQuantity:",orderQuantity);
		console.log("orderId:",orderId);
		console.log("orderid: ",orderid);
		console.log("userid: ",userid);
		console.log("checkbox: ",checkbox);
	    tossPayments.requestPayment(method, requestJson)
	        .catch(function (error) {
	
	            if (error.code === "USER_CANCEL") {
	                alert('유저가 취소했습니다.');
	            } else {
	                alert(error.message);
	            }
	        });
	}
	
	
	let path = "/order/";
	let successUrl = window.location.origin + path + "success";
    let failUrl = window.location.origin + path + "fail";
    let orderId = new Date().getTime();
</script>

</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>장바구니</title>
<link href="https://fonts.googleapis.com/css2?family=Nanum+Pen+Script&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/meyer-reset/2.0/reset.min.css">
<link rel="shortcut icon" type="image/x-icon" href="image/favicon.ico">
<link rel='stylesheet' href='https://fonts.googleapis.com/css?family=Roboto:400,500,700&amp;display=swap'>
<link rel="stylesheet" href="/css/basket.css">
<script src="https://js.tosspayments.com/v1"></script>

</head>
<body>
	<input type="hidden" id="userid" value="${email}">

    <div class="cart-container">
    <div id="wrap">
        <div class="cart-title">장바구니 
        	<a href="/home" style="float:right; font-size: 20px; margin-top: 5px;">메인으로</a>
        </div>
        <table id="tbbasket">
            <tr>
            	<th>전체선택<input type="checkbox" id="allCk"></th>
                <!-- <th>사진</th> -->
                <th>상품명</th>
                <th>수량</th>
                <th>상품금액</th>
                <!-- <th>아이디</th> -->
                <th>삭제</th>
            </tr>
        </table>
        <strong>선택한 제품 가격: <span id="selectedPrice"></span> 원</strong>
        <button class="order" onclick="pay();" id =session style="left: 57%; margin-top: 10px;"><span class="default">결제하기</span><span class="success">결제 성공
		    <svg viewbox="0 0 12 10">
		      <polyline points="1.5 6 4.5 9 10.5 1"></polyline>
		    </svg></span>
		  <div class="box"></div>
		  <div class="truck">
		    <div class="back"></div>
		    <div class="front">
		      <div class="window"></div>
		    </div>
		    <div class="light top"></div>
		    <div class="light bottom"></div>
		  </div>
		  <div class="lines"></div>
        </div>
    </div>
</body>
<script src="https://code.jquery.com/jquery-latest.js"></script>
<script>
	
	$(document).ready(function(){
		let userid = $("#userid").val();
		console.log(userid)
		basketList();
	    totalPrice();
		
	    $('input[type="checkbox"][name="productchk"], #allCk').change(function() {
	        totalPrice();
	    });
	});
	
	$('#allCk').click(function(){
        $('input[type="checkbox"][name="productchk"]').prop('checked', this.checked);
        totalPrice();
    });

	$(document).on('change', 'input[type="checkbox"][name="productchk"]', function() {
	    let checkbox = [];
	    if ($('input[type="checkbox"][name="productchk"]:not(:checked)').length == 0) {
	        $('#allCk').prop('checked', true);
	    } else {
	        $('#allCk').prop('checked', false);
	    }
	    totalPrice();

	    $('input[type="checkbox"][name="productchk"]:checked').each(function() {
	        let orderid = $(this).val();
	        checkbox.push(orderid);
	    });

	   
	})
    
	function checkbox1() {
	    let checkbox = [];
	    $('input[type="checkbox"][name="productchk"]:checked').each(function() {
	        let orderid = $(this).val();
	        checkbox.push(orderid);
	    });
	    let checkboxString = checkbox.join(',');
	    /* console.log("checkboxString: ", checkboxString); */
	    return checkboxString;
	}
	
   //세션 정의
    $(document).on('click', '#session', function(){
       let session = "";
       $('input[name="productchk"]:checked').each(function() {
         console.log('체크박스 값:', $(this).val());
           session += $(this).val()+','; 
           console.log("체크박스1",session);
        });
       $.ajax({
         type: 'post',
         url: '/doSession',
         data: {session:session},
         dataType: 'text',
         success: function(data){
             if(data == "1"){
                console.log(data);
             }
         }
     })
     pay();
  })
    
    
    .on('click', '.basketRemove', function(){
    	let id = $(this).data('id');
	    /* let n=$(this).parent().find('td:eq(6)').find('#id').text() */
	    console.log("id="+id)
	    
	    $.ajax({
	        type: 'post',
	        url: '/basketRemove',
	        data: {id:id},
	        dataType: 'text',
	        success: function(data){
	        	console.log(data)
	            if(data == "1"){
	                alert("삭제하였습니다.");
	                basketList();
	            } else{
	                alert("삭제 실패하였습니다.");
	            }
	        }
	    });
	});
    
    $('.order').click(function (e) {

        let button = $(this);
      
        if (!button.hasClass('animate')) {
          button.addClass('animate');
          setTimeout(() => {
            button.removeClass('animate');
          }, 10000);
        }
      
      });
	function basketList(){
		$.ajax({
			type:'post',
			url:'/basketrev',
			data:{userid:$("#userid").val()},
			dataType:'json',
			success: function(data){
				$('#tbbasket tr:gt(0)').empty();
				console.log(data);
				for(let i = 0; i < data.length; i++){
					let ob = data[i];
					let btn = '<button type="button" class="basketRemove" data-id="'+ ob['id'] +'">삭제</button>';
					let checkbox = '<input type="checkbox" name="productchk" value="' + ob['id'] + '">';
					let str = '<tr data-id="${ob.orderid}" data-userid="${ob.userid}"><td style="display: none;">'+ ob['orderid']+
								'</td><td style="display: none;">'+ ob['userid']+
								'</td><td>'+checkbox+
								'</td><td>' + ob['orderName'] +
								'</td><td>' + ob['count'] + 
								'</td><td>' + ob['amount'] +
								'</td><td id="id" style="display: none;">' + ob['id'] +
								'</td><td>' +btn+ '</td></tr>';
					$('#tbbasket').append(str);
				}
				
			}
		})
	}
	
	//가격 표시
	function totalPrice() {
	    let total = 0;
	    $('input[type="checkbox"][name="productchk"]:checked').each(function() {
	        let row = $(this).closest('tr');
	        let amount = parseInt(row.find('td:nth-child(6)').text());
	        total += amount;
	    });
	    $('#selectedPrice').text(total);

	    window.amount = total;
	}
	
	//제품 이름
	function TitleName(){
	    let productNames = [];
	    $('input[type="checkbox"][name="productchk"]:checked').each(function() {
	        let row = $(this).closest('tr');
	        let name = row.find('td:nth-child(4)').text();
	        productNames.push(name);
	    });
	    
	    let productNameString = productNames.join(', ');
	    return productNameString;
	}
	
	//총 수량
	function quantity() {
	    let totalQuantity = 0;
	    $('input[type="checkbox"][name="productchk"]:checked').each(function() {
	        let row = $(this).closest('tr');
	        let quantity = parseInt(row.find('td:nth-child(5)').text());
	        totalQuantity += quantity;
	    });
	    console.log("Total Quantity: ", totalQuantity);
	    return totalQuantity;
	}
	
	// 유저id
	function useridName() {
	    let useridNameid = [];
	    $('input[type="checkbox"][name="productchk"]:checked').each(function() {
	        let row = $(this).closest('tr');
	        let userids = row.find('td:nth-child(2)').text();
	        useridNameid.push(userids);
	    });
	    let userIdString = useridNameid.join(', ');
	    console.log("userid:", userIdString);
	    return userIdString; 
	}
	
	//주문번호id
	function orderidtest() {
	    let selectedOrderIds = [];
	    $('input[type="checkbox"][name="productchk"]:checked').each(function() {
	        let row = $(this).closest('tr');
	        let orderid = row.find('td:nth-child(1)').text();
	        selectedOrderIds.push(orderid);
	    });
	    let orderIdString = selectedOrderIds.join(', ');
	    console.log("Selected OrderIds: ", selectedOrderIds);
	    return orderIdString; 
	}

	
	/* ------------------------------------------------------------------------------------------------- */
	
	//테스트 API키
	
	let tossPayments = TossPayments("test_ck_kYG57Eba3G9KevJYNE5lrpWDOxmA");
	
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

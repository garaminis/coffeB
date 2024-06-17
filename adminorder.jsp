<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="/css/admin.css" rel="stylesheet" type="text/css">
</head>
<style>
 tr, td{
 border:1px;}
</style>
<body>
	  <nav id="nav" >
      <span id="serchArea" >
        <button id="doSerch" onclick="location.href='/'" >메인페이지</button>
    </span>
    <span id="categoryBar">
        <a href="/admin" class="categoryMenu">상품관리</a>
        <a href="/adminorder" class="categoryMenu">주문관리</a>
        <a href="memberList" class="categoryMenu">고객관리</a>
        <button id="doSerch" onclick="location.href='/'">메인페이지</button>
    </span>
</nav>
<a onclick=inputHiddenNum(1) style="cursor: pointer;">신규주문</a>&nbsp; <a onclick=inputHiddenNum(2) style="cursor: pointer;">배송준비</a>&nbsp; <a onclick=inputHiddenNum(3) style="cursor: pointer;">배송중</a>&nbsp; <a onclick=inputHiddenNum(4) style="cursor: pointer;">배송완료</a>
<input type="hidden"  id="stateNum" value="1"> <!-- 숨어있는 input  -->
<div style="height: 140px;">
<table style="height: 100%; width: 100%;">
    <tr >
        <td style="width: 15%; text-align: center;">주문관리</td>
        <td>여기는 비워주는곳</td>
        <td style="width: 15%; vertical-align: bottom;text-align: right;"></td>
    </tr>
</table>
<div>
<div style="">
	    <table class="orderL" style="margin: 30px 40px 0px 50px; width: 92%;">
	    </table>
</div>
<script src='https://code.jquery.com/jquery-latest.js'></script>
<script>
let Headtable = '<tr><td>주문번호</td><td>주문아이디</td>'+
'<td>상품이름</td><td>수량</td><td>금액</td>'+
'<td>받는사람</td><td>우편번호</td><td>보낼주소</td>'+
'<td>상세주소</td>'+
'<td>받는사람번호</td><td>요청사항</td><td>배송방법</td>'+
'<td>배송비</td><td>결제방법</td><td>진행상황</td><td>주문날짜</td><td>수정/삭제</td></tr>';
$(document)
.ready(function(){
	getOrderList() //시작하면 맴버테이블생성
})
.on('click','#plusStateLink',function(){ //배송상황클릭시 입금완료->배송준비->배송중 순으로 바뀜 아직3개뿐이라 추가수정필요
	alert($(this).parent().parent().find('td:eq(0)').attr('value'))
    if ($('#stateNum').val() == 4) {
        return false;
    }
    if (confirm('배송상황을 다음으로 진행시키겠습니까?')) { 
        $.ajax({
            type: 'post',
            url: '/updateState',
            data: {
                stateNum: $('#stateNum').val(),
                id: $(this).parent().parent().find('td:eq(0)').attr('value')
            },
            dataType: 'text',
            success: function (data) {
                $('.orderL').empty()
                inputHiddenNum($('#stateNum').val())
            }
        })
    } 
	
})
function getOrderList(){ //테이블가져오는 함수
	$.ajax({
		type:'post',
		url:'/orderList',
		data:{stateNum : $('#stateNum').val()},
		dataType:'json',
		success:function(data){
	        $('.orderL').append(Headtable)
        for (let i = 0; i < data.length; i++) {
            let ob = data[i];
            let str = '<tr><td value="'+ob['id']+'">' + ob['order_id'] + '</td><td>'+ob['member_id']+'</td><td>' +
                ob['goods_name'] + '</td><td>' + ob['cnt'] + '</td><td>' + ob['sales'] + '</td><td>' + ob['delname'] + '</td><td>'+ob['delzipcode']+'</td><td>' +
                ob['deladress'] + '</td><td>'+ob['deladress2']+'</td><td>' + ob['delmobile'] + '</td><td>' + ob['delreq'] + '</td><td>' + ob['delivery_name'] + '</td><td>'+ob['delivery_pay']+'</td><td>' +
                ob['payment_name'] + '</td><td><a id="plusStateLink" style="cursor: pointer;" value="' + ob['state'] + '">' + ob['orderstate_name'] + '</a></td><td>'+ob['created']+'</td><td>' + '<button class="siuu" value="">수정</button>/' +
                '<button class="sack" value="">삭제</button>' + '</td></tr>';
            $('.orderL').append(str);
        }
		}
	})
}
function inputHiddenNum(hnum){
	var getNum = hnum;
	$('#stateNum').val(getNum);
	$('.orderL').empty();
	getOrderList()
}
</script>
</body>
</html>
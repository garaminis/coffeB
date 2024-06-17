<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 등록</title>
</head>
<script src='https://code.jquery.com/jquery-latest.js'></script>
<style>
table{corder-collapse:collapse;}
td tr {border:1px solid block;}
</style>
<body>
<input type = hidden name = id value="">
<table>
	<tr><td>카테고리</td><td>
		<select style="width: 100%" name=category_name id=category_id>
	        <option name=category id=category value="1">1번 카테</option>
	        <option name=category id=category value="2">2번 카테</option>
	        <option name=category id=category value="3">3번 카테</option>
	        <option name=category id=category value="4">4번 카테</option>
	        <option name=category id=category value="5">5번 카테</option>
	        <option name=category id=category value="6">6번 카테</option>
	   	</select></td></tr>
	<tr><td>노출명</td><td><input type=text name=title id=title></td></tr>
	<tr><td>상품명</td><td><input type=text name=goods id=goods></td></tr>
	<tr><td>판매가</td><td><input type=text name=price id=price></td></tr>
	<tr><td>할인</td><td><input type=text name=discnt id=discnt disabled value="개발예정"></td><td>%</td><td>원</td></tr>
	<tr><td>총 판매금액</td><td><input type=text name=totalPrice id=totalPrice disabled value="개발예정"></td></tr>
	<tr><td>재고수량</td><td><input type=number name=stock id=stock></td></tr>
	<tr><td>배송방법</td>
	<td><input type="radio" name="delivery" id="delivery_paid" value="1">유료배송</td>
	<td><input type="radio" name="delivery" id="delivery_free" value="2">무료배송</td></tr>
	<tr><td>이미지등록</td><td><input type="file" name="img" id=img /></td></tr>
	<tr><td colspan=2> <button id=btnAdd>등록</button></td>
		<td colspan=2><button id=btnDel>취소</button></td>
	</tr>
	<tr><td>상세설명</td><td><input type=text name=goods id=content></td></tr>
</table>
</body>

<script>
$(document)
.ready(function(){
	
})

.on('click','#btnAdd',function(){
if($('#title').val()==''){
		alert("노출명을 입력해주세요.");
		return false;
	}
	$.ajax({
		type : 'post',
		url : '/goodsAdd',
		data : {category_id : $('#category_id option:selected').val(), title : $('#title').val(), goods : $('#goods').val(), price : $('#price').val(), stock : $('#stock').val(), delivery : $('input[name=delivery]:checked').val(), img : $('#img').val(), content : $('#content').val()},
		dataType : 'text',
		success : function(data){
			if(data=='1'){
				$('#category_id, #title, #goods, #price, #stock, #delivery, #img', '#content').val('');
			} else {
				alert('등록 실패');
			}
		}
	})
})

.on('click','#btnDel',function(){
	$('#category_id, #title, #goods, #price, #stock, #delivery, #img', '#content').val('');
})

</script>

</html>
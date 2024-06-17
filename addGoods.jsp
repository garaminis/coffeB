<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 등록</title>
<link href="/css/admin.css" rel="stylesheet" type="text/css">
</head>
<script src='https://code.jquery.com/jquery-latest.js'></script>
<style>

/* 네비게이션 바 스타일 */
#nav1 {
    margin-bottom: 20px; /* 네비게이션 바 아래 여백 추가 */
}

.top-box, .middle-box, .bottom-box {
		margin-top: 50px;
		margin-bottom: 50px;
}

/* 테이블 스타일 */
.goodslist {
    width: 90%; /* 테이블 너비를 설정합니다. */
    margin: 0 auto; /* 가운데 정렬합니다. */
}

/* 버튼 스타일 */
#btnAdd,
#btnDel {
    display: inline-block; /* 버튼을 블록 요소로 변경하여 중앙 정렬합니다. */
    margin: 0 auto; /* 가운데 정렬합니다. */
    size: 120%;
}

/* 나머지 CSS 스타일 */
table td,
table th {
    border: 1px solid #dddddd;
    text-align: left;
    padding: 5px;
    table-layout: auto;
    word-wrap: break-word;
}

#doSerch {
    float: right;
}

input[type=text],
input[type=number],
select,
textarea {
    width: 70%;
    padding: 12px 20px;
    margin: 8px 0;
    display: inline-block;
    border: 1px solid #ccc;
    border-radius: 4px;
    box-sizing: border-box;
}

#txtContent {
		padding: 10px;
		border: 1px solid #ccc;
		border-radius: 4px;
		font-size: 16px;
		resize: vertical;
		background-color: white;
}

</style>
<body>
   <nav id="nav1" >
    <span  class='addG'>
        <a href="/admin" class="categoryMenu">상품관리</a>
        <a href="/adminorder" class="categoryMenu">주문관리</a>
        <a href="memberList" class="categoryMenu">고객관리</a>
        <button id="doSerch" onclick="location.href='/'">메인페이지</button>
    </span>
  </nav> 
<input type = hidden name = id id=hiddenid value="">
<div class="top-box">
	<h2 style="font-size:200%;">상품 등록</h2>
</div>
<div class="middle-box">
	<table class=goodslist>
		<tr>
			<td>카테고리</td><td>
				<select style="width: 100%" name=category_name id=category_id>
				</select>
			</td>
			<td>노출명</td>
			<td colspan="10"><input type=text name=title id=title></td>
		</tr>
		<tr>
			<td>판매가</td>
			<td><input type=text name=price id=price></td>
			<td>
				<input type=radio name="disradio" class="disradio" value="no" checked>할인안함<br>
				<input type=radio name="disradio" class="disradio" value="percent">%<br>
				<input type=radio name="disradio" class="disradio" value="won">원
			</td>
			<td><input type=text name=discnt id=discnt value="0"></td>
			<td>총 판매금액</td>
			<td><input type=text name=totalPrice id=totalPrice readonly></td>
			<td>재고수량</td>
			<td><input type=number name=stock id=stock value="999"></td>
			<td>배송방법</td>
			<td><input type="radio" name="delivery" id="delivery_paid" value="1" checked>유료배송</td>
	   	<td><input type="radio" name="delivery" id="delivery_free" value="2">무료배송</td>
		</tr>
		<tr>
			<td>대표이미지</td>
			<td colspan="1"><input type="file" name="img1" id=img1 onchange="titleuploadImage('img1')" /></td>
			<td colspan="2"><input type="file" name="img2" id=img2 onchange="titleuploadImage('img2')" /></td>
			<td colspan="2"><input type="file" name="img3" id=img3 onchange="titleuploadImage('img3')" /></td>
			<td colspan="2"><input type="file" name="img4" id=img4 onchange="titleuploadImage('img4')"/></td>
			<td colspan="3"><input type="file" name="img5" id=img5 onchange="titleuploadImage('img5')"/></td></tr>
		<tr>
			<td>상품설명</td >
			<td colspan="11">
	   		<textarea id="txtContent" rows="30" cols="100" style="width: 99.9%;"></textarea>
	   		<input type="file" id="fileInput" onchange="uploadImage(event)" accept="image/*" />
			</td>
		</tr>
	</table>
</div>
<div class="bottom-box">
	<button id=btnAdd>등록</button><button id=btnDel>취소</button>
</div>

</body>
<script src="https://code.jquery.com/jquery-latest.js"></script>
<script>
$(document)
.ready(function(){ //시작하자마자 session안에 goodsid가 들어있으면 상품수정형 없다면 상품추가형
	$.ajax({
		type:'post',
		url:'/getCategoty',
		data : {},
		dataType : 'json',
		success : function(data){
			for (let i = 0; i < data.length; i++) {
		        let ob = data[i];
		        let str = '<option value="' + ob['id'] + '">' + ob['name'] + '</option>';
		        $('#category_id').append(str);
		    }
		}
	})
})

<%-- <% --%>
// 	if(session.getAttribute("goodsid")==null) {
<%-- %> --%>
// 	let goodsid = null;
<%-- <% } else { %> --%>
<%-- 	let goodsid = '<%=session.getAttribute("goodsid")%>'; --%>
<%-- <% } %> --%>
//     console.log('goodsid ['+goodsid+']')
//     $('input.disradio[value="no"]').prop('checked', true);
//     if(goodsid!=null){
//     	$('#hiddenid').val(goodsid);
//     	$.ajax({
//     		type:'post',
//     		url: '/view',
//     		data:{goods_id:$('#hiddenid').val()},
//     	    dataType : 'json',
//     	    error:function(){
//     	    	alert('server error')
//     	    },
//     		success : function(data){
//     			let ob = data;
//     			let delpay = ob['delpay']
//     			if(delpay==1){
//     				$('input[id="delivery_paid"]').prop('checked', true)
//     			}else if(delpay==2){
//     				$('input[id="delivery_free"]').prop('checked', true)
//     			}
//     			$('#category_id').val(ob['category'])
// /*     			$('#img1').val(ob['img1'])
//     			$('#img2').val(ob['img2'])
//     			$('#img3').val(ob['img3'])
//     			$('#img4').val(ob['img4'])
//     			$('#img5').val(ob['img5']) */
//     			$('#title').val(ob['title'])
//     			$('#price').val(ob['price'])
//     			$('#stock').val(ob['stock'])
//     			$('#content').val(ob['content'])
//     			$('#discnt').val(ob['discnt'])
//     			$('input[value="percent"]').prop('checked', true) /*확정으로 퍼센트를 넣은거라 수정필요*/
//     			discnt()
<%--     			<%session.invalidate();%> --%>
//     		}
//     	})
//     }
// })

.on('click','#btnAdd',function(){ //상품추가버튼을 눌렀을때 hidden안에 id값이있으면 그id를 수정 없으면 새로 상품추가
	let images = [];
	for (let i = 1; i <= 5; i++) {
	    let file = $('#img' + i).attr('src');
	    if (file) {
	        let fileName = file.split("\\").pop();
	        images.push(fileName);
	    }
	}
	
	if($('#hiddenid').val()!=null && $('#hiddenid').val()!=''){
		$.ajax({
			type:'post',
			url:'/update',
			data : {goods_id:$('#hiddenid').val(),
				category_id : $('#category_id option:selected').val(), 
				itle : $('#title').val(),discnt : $('#discnt').val(), 
				price : $('#price').val(), stock : $('#stock').val(), 
				delivery : $('input[name=delivery]:checked').val(), 
	            img1 : img1,img2 : img2,
				img3 : img3,img4 : img4,
				img5 : img5,content: $('#content').val()},
			dataType : 'text',
			success : function(data){
				$('#hiddenid, #category_id, #title,#totalPrice,#content,#discnt, #price, #stock, #deliver').val('');
				$('input[id="delivery_paid"]').prop('checked', false)
				$('input[id="delivery_free"]').prop('checked', false)
				$('input[class="disradio"]').prop('checked', false)
				window.location.href = '/admin';//끝나고 상품관리페이지로 가는코드
			}
		})
		
	} else if ($('#hiddenid').val() == '') {
	    if ($('#title').val() === '') {
	        alert("노출명을 입력해주세요.");
	        return false;
	    }

	    // 에디터의 내용을 업데이트합니다.
	    oEditors.getById["txtContent"].exec("UPDATE_CONTENTS_FIELD", []);

	    console.log('category_id = ' + $('#category_id option:selected').val());
	    console.log('title = ' + $('#title').val());
	    console.log('price = ' + $('#price').val());
	    console.log('discnt = ' + $('#discnt').val());
	    console.log('stock = ' + $('#stock').val());
	    console.log('delivery = ' + $('input[name=delivery]:checked').val());
	    console.log('img = ' + images);
	    console.log('content = ' + $("#txtContent").val());
	    
	     let requestData = {
			        category_id: $('#category_id option:selected').val(),
			        title: $('#title').val(),
		          price: $('#price').val(),
		          discnt: $('#discnt').val(),
		          stock: $('#stock').val(),
		          delivery: $('input[name=delivery]:checked').val(),
		          img : images,
			        content: $("#txtContent").val()
	    	    };
	     
	    $.ajax({
	        type: 'POST',
	        url: '/goodsAdd',
	        data: JSON.stringify(requestData),
	        contentType: "application/json",
	        success: function (data) {
	            if (data === '1') {
	                $('#category_id, #title, #price, #stock, #img1, #img2, #img3, #img4, #img5, #txtContent').val('');
	            } else {
	                alert('등록 실패');
	            }
	            window.location.href = '/admin'; // 끝나고 상품관리페이지로 가는 코드
	        }
	    })
	}
	return false;

})
.on('click','#btnDel',function(){
	$('#hiddenid, #category_id, #title, #price, #stock, #img1, #img2, #img3, #img4, #img5, #txtContent').val('');
	$('input[id="delivery_paid"]').prop('checked', false)
	$('input[id="delivery_free"]').prop('checked', false)
	$('input[class="disradio"]').prop('checked', false)
})
.on('keyup', '#price', function () {
	$('#totalPrice').val($('#price').val())
	discnt()
})
.on('keyup', '#discnt', function () {
	discnt()
})
.on('click','.disradio',function(){
	discnt()
})
function discnt(){ //퍼센트 체크시 총금액에 퍼센트할인금액입력 원 체크시 총금액에 원할인금액 입력
	if($('input[value="percent"]').is(":checked")){
		let a = $('#discnt').val()
		let b = $('#price').val()*(1 - a / 100)
		let c = Math.round(b / 10) * 10;
		$('#totalPrice').val(c)
		return false;
	}else if($('input[value="won"]').is(":checked")){
		let discount = parseFloat($('#discnt').val());
		$('#totalPrice').val($('#price').val()-discount)
		return false;
	}else if($('input[value="no"]').is(":checked")){
		$('#discnt').val('0')
		$('#totalPrice').val($('#price').val())
	}
}
</script>
<script type="text/javascript" src="/libs/smarteditor/js/HuskyEZCreator.js" charset="utf-8"></script>
<script src="/js/editor.js"></script>
</html>
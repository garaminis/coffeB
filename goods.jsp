<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>커피블리스</title>
<link href="/css/theme.css" rel="stylesheet" type="text/css">
<script src="https://code.jquery.com/jquery-latest.js"></script>
</head>
<style>
    html{
  			scroll-behavior: initial;
    } /*스크롤 내릴때 확내려가거나 부드럽게 내려가는 타입*/
    a{
        text-decoration: none;
    }
    #comment{
        scroll-margin-top: 120px;
    } /*버튼누르고 스크롤 내려갔을때 상단의 공백*/
    #mainDIS{
        scroll-margin-top: 120px;
    }/*버튼누르고 스크롤 내려갔을때 상단의 공백*/
    #QnA{
        scroll-margin-top: 120px;
    }/*버튼누르고 스크롤 내려갔을때 상단의 공백*/
    #먹태{
        scroll-margin-top: 120px;
    }/*버튼누르고 스크롤 내려갔을때 상단의 공백*/
    
    .read {
    font-size: 80%;
    text-align: left;
    padding-left: 20px;
    }
    

    
	/* 테이블 셀과 테두리 스타일 */
	tr, td {
	    padding: 10px;
	    text-align: center;
	    font-size:20px
	}
	
	/* 테이블 테두리 스타일 및 가운데 정렬 */
	table {
	    border-collapse: collapse;
	    margin: auto;
	}
	
	/* 이미지 상자 */
	.img-box {
	    display: inline-block;
	    vertical-align: top; /* 이미지 상단 정렬 */
	}
	
	/* 주문 폼 */
	.doOrder {
	    display: inline-block;
	    vertical-align: top; /* 폼 상단 정렬 */
	    margin-left: 20px; /* 왼쪽 여백 추가 */
	    margin-top: 40px; /* 상단 여백 추가 */
	}
	
	/* 장바구니 담기, 주문하기 버튼 */
	#addCart, #directOrder {
	    background-color: peru;/* 버튼 배경색 */
	    color: #ffffff; /* 글자색 */
	    border: none;
	    border-radius: 4px;
	    cursor: pointer;
	    font-family: 'YeongdeokSea'; /* 글꼴 */
	    
	}
	
	/* 수량 조절 버튼 */
	.int {
	    background-color: peru; /* 버튼 배경색 */
	    color: #ffffff; /* 글자색 */
	    border: none;
	    border-radius: 4px;
	    cursor: pointer;
	    font-family: 'YeongdeokSea'; /* 글꼴 */
	    width: 80px;
	    height: 30px;
	    font-size: 30px;
	    margin-top: 5px; /* 상단 여백 */
	    display: inline-block;
	}
	
	/* 결과 값 가운데 정렬 */
	#result {
	    text-align: center;
	    width: 80px;
	    height: 35px;
	    font-size: 20px;
	}
	.int2 {
  /* 텍스트 입력 상자의 너비와 높이 */
	  width: 100px;
	  height: 30px;
	  /* 텍스트 정렬 및 패딩 설정 */
	  text-align: center;
	  padding: 5px;
	  /* 배경색 및 테두리 설정 */
	  background-color: #f2f2f2;
	  border: 1px solid #ccc;
	  border-radius: 5px; /* 모서리를 둥글게 만듭니다. */
	  /* 글꼴 설정 */
	  font-size: 10px;
	  /* 입력 상자 읽기 전용 속성 */
	  pointer-events: none; /* 입력 방지 */
	}
		
.scroll_bar {
    color:  rgb(139, 90, 26); /* 링크 색상 */
    text-decoration: none; /* 밑줄 제거 */
    font-weight: bold; /* 폰트 굵기 설정 */
    transition: background-color 0.3s, color 0.3s; /* 호버 효과를 위한 전이 효과 설정 */
}
.scroll_bar:hover {
    color: black; /* 호버 시 텍스트 색상 변경 */
}
 
  	
    
</style>
<body>
  <header id="herder">
   	<%@ include file="include/header.jsp" %>
  </header>
  
  <nav id="nav">
  	<%@ include file="include/nav.jsp" %>
  </nav>
<div id="container" >  
<c:set var="imgSrc" value="${item.img1}" />
  <main id="main">
    <div id="mainContent"  style="width:90%; margin: 0 auto;">
      <div style="margin-top: 80px; margin-bottom: 70px; text-align: center; display:flex; justify-content: center; height:500px; padding-left: 30px; padding-right: 30px;">
        <div class="img-box" style="display: inline-block;width: 50%;">
          <div style="height:400px; text-align: center;">
          	<img class="M_img"style="max-width: 100%; max-height: 100%;" src="${itemInfo[0].img1}" alt=""><br>
          </div>
          <div style="margin-top: 20px;">
            <img class="S_img1" onmouseover="onIMG();" onmouseout="offIMG();"style="width: 80px;" src="${itemInfo[0].img1}" alt="">
            <img class="S_img2" onmouseover="onIMG();" onmouseout="offIMG();"style="width: 80px;" src="${itemInfo[0].img2}" alt="">
            <img class="S_img3" onmouseover="onIMG();" onmouseout="offIMG();"style="width: 80px;" src="${itemInfo[0].img3}" alt="">
            <img class="S_img4" onmouseover="onIMG();" onmouseout="offIMG();"style="width: 80px;" src="${itemInfo[0].img4}" alt="">
            <img class="S_img5" onmouseover="onIMG();" onmouseout="offIMG();"style="width: 80px;" src="${itemInfo[0].img5}" alt="">
          </div>
        </div>
        <div style="width: 50%; text-align: left;">
        <form method='get' action="/order" id="goOrder" class='doOrder' style="width: 90%; height: 460px;">
        <input type="hidden" style="display:none" id="goodsNumber" name="goodsNumber" value="${itemInfo[0].id}">
         <input type="hidden" style="display:none" id="gPrice" name="goodsPrice" value="">
        
          <table style="font-size: 30px; width: 90%;">
            <tr><td colspan="2" class="goodsName" style="width: 100%; vertical-align: top; text-align: left; font-size: 2.5vw; height: 100px;">${itemInfo[0].title}</td></tr>
            <tr>
              <td style="width: 20%;">판매가</td>
              <td class="goodsPrice" style="width: 80%; font-size: 2vw; text-align: right;">${itemInfo[0].price}원</td>
            </tr>
            <tr>
              <td>배송비</td>
              <td class="goodsSend" style="font-size: 2vw; text-align: right; ">${itemInfo[0].pay}원</td>
            </tr>
            <tr>
            	<td colspan="2">50,000원 이상 구매 시 무료배송</td>
            </tr>
            <tr>
              <td>수량</td>
              <td style="vertical-align: top;">
                <input type="text" id="result" name="result" readonly value="1" class="int2">
                <input type="button" style="width: 40px;height: 35px;" onclick='count("plus")' value="+" class="int">
                <input type="button" style="width: 40px;height: 35px;" onclick='count("minus")' value="-" class="int">
              </td>
            </tr>
            <tr>
              <td>합계</td>
              <td class="tital-price" style="font-size: 2vw; text-align: right; ">${itemInfo[0].price}원</td>
            </tr>
          </table>
      <div style="text-align: right; margin-top: 30px; margin-right: 30px;">
        <input type="button" style="width: 120px; height: 50px;" id="addCart" value="장바구니에담기">
        <input type="button" style="width: 120px; height: 50px;" id="directOrder" value="주문하기">
      </div>
        </form>
        
        </div>
	
      </div>

      <div id="scrollbar"style="background-color: white; text-align: center; position: sticky; top: 0px; right: 300px;">
        <div>
          <div style="width: 24%; font-size: 2.2vw; line-height: 120px;display: inline-block;"><a href="#mainDIS" class="scroll_bar">상세정보</a></div>
          <div style="width: 24%; font-size: 2.2vw; line-height: 120px;display: inline-block;"><a href="#coment" class="scroll_bar">상품평</a></div>
          <div style="width: 24%; font-size: 2.2vw; line-height: 120px;display: inline-block;"><a href="#QnA" class="scroll_bar">Q&A</a></div>
          <div style="width: 24%; font-size: 2.2vw; line-height: 120px;display: inline-block;"><a href="#change" class="scroll_bar">교환/반품안내</a></div>
        </div>
      </div>
      <div id="mainDIS" style="text-align: center;"><!--상품상세설명-->
        ${itemInfo[0].content}
      </div>
      <div id="coment" style="height: 400px; margin-top: 60px;"><!--상품평-->
        <h1 style="text-align: left;font-style: initial;">상품평</h1>
        <hr style="margin-bottom: 20px;">
        <div>
          <table id="tblReview" style="width:100%">
	        	<tr style="border-bottom: 3px solid #ccc;">
	          	<th style="width:15%;">평점</th>
	            <th style="width:50%;">내용</th>
	            <th style="width:15%;">작성자</th>
	            <th style="width:30%;">작성일</th>
	          </tr>
          </table>
        </div>
      </div>
      <div id="QnA" style="height: 400px;"><!--QnA-->
        <h1 style="text-align: left;font-style: initial;">QnA</h1>
        <hr style="margin-bottom: 20px;">

        <div>
          <table id="tblQna" style="width:100%">
            <tr style="border-bottom: 3px solid #ccc;">
              <th style="width:15%;">상태</th>
              <th style="width:50%;">내용</th>
              <th style="width:15%;">작성자</th>
              <th style="width:30%;">작성일</th>
            </tr>
          </table>
          <form method='post' action="/writeQna" style="text-align: right; margin-top: 10px;">
          <input type="hidden" style="display:none" name="goods_id" value="${itemInfo[0].id}">
         	 <button id="writeQna">작성하기</button>
          </form>
        </div>
      </div>
      <div id="change">
        <h1 style="text-align: left;font-style: initial;">교환/반품 안내</h1>
        <hr style="margin-bottom:20px;">
					<table cellspacing="0">
		        <colgroup>
		            <col width="160">
		            <col width="410">
		            <col width="150">
		            <col>
		        </colgroup>
		        <tbody>
		            <tr>
		                <th scope="row">판매자 지정택배사</th>
		                <td colspan="3">CJ대한통운</td>
		            </tr>
		            <tr>
		                <th scope="row">반품배송비</th>
		                <td class="read">편도 3,000원 (최초 배송비 무료인 경우 6,000원 부과)</td>
		                <th scope="row">교환배송비</th>
		                <td class="read">6,000원</td>
		            </tr>
		            <tr>
		                <th scope="row">보내실 곳</th>
		                <td colspan="3" class="read">경기 고양시 일산동구 장항동 846 센트럴프라자빌딩 1층</td>
		            </tr>
		            <tr>
		                <th scope="row" rowspan="2" >반품/교환 사유에 따른 요청 가능 기간</th>
		                <td colspan="3" class="read">구매자 단순 변심은 상품 수령 후 7일 이내
		                    <span>(구매자 반품배송비 부담)</span>
		                </td>
		            </tr>
		            <tr>
		                <td colspan="3" class="read">표시/광고와 상이, 계약 내용과 다르게 이행된 경우 상품 수령 후 3개월 이내 혹은 표시/광고와 다른 사실을 안 날로부터 30일 이내
		                    <span>(판매자 반품 배송비 부담)</span>
		                    <br>둘 중 하나 경과 시 반품/교환 불가
		                </td>
		            </tr>
		            <tr>
		                <th scope="row" rowspan="7">반품/교환 불가능 사유</th>
		                <td colspan="3">
		                    <ul style="list-style:none;">
		                        <li class="read">
		                            <span>1. </span>반품요청기간이 지난 경우
		                        </li>
		                        <li class="read">
		                            <span>2. </span>구매자의 책임 있는 사유로 상품 등이 멸실 또는 훼손된 경우
		                            <span>(단, 상품의 내용을 확인하기 위하여 포장 등을 훼손한 경우는 제외)</span>
		                        </li>
		                        <li class="read">
		                            <span>3. </span>구매자의 책임있는 사유로 포장이 훼손되어 상품 가치가 현저히 상실된 경우
		                            <span>(예: 식품, 화장품, 향수류, 음반 등)</span>
		                        </li>
		                        <li class="read">
		                            <span>4. </span>구매자의 사용 또는 일부 소비에 의하여 상품의 가치가 현저히 감소한 경우
		                            <span>(라벨이 떨어진 의류 또는 태그가 떨어진 명품관 상품인 경우)</span>
		                        </li>
		                        <li class="read">
		                            <span>5. </span>시간의 경과에 의하여 재판매가 곤란할 정도로 상품 등의 가치가 현저히 감소한 경우
		                        </li>
		                        <li class="read">
		                            <span>6. </span>고객의 요청사항에 맞춰 제작에 들어가는 맞춤제작상품의 경우
		                            <span>(판매자에게 회복불가능한 손해가 예상되고, 그러한 예정으로 청약철회권 행사가 불가하다는 사실을 서면 동의 받은 경우)</span>
		                        </li>
		                        <li class="read">
		                            <span>7. </span>복제가 가능한 상품 등의 포장을 훼손한 경우
		                            <span>(CD/DVD/GAME/도서의 경우 포장 개봉 시)</span>
		                        </li>
		                    </ul>
		                </td>
		            </tr>
		        </tbody>
		    </table>
      </div>
      </div>
    </main>
</div>
    <footer id="footer">
      <%@ include file="include/footer.jsp" %>
    </footer>

</body>

<script>
$(document).ready(function() {
	
    let imgSrc = '<%= request.getAttribute("imgSrc") %>';
    getReviwe();
    getQna();
});
let id = '<%=(String)session.getAttribute("id")%>';

$(document).on('click', '.btnQna', function() {
	
    let i = $(this).data('i');
    let content = $('#setAnswer' + i).val();
    let qna_id = $(this).data('qna_id');
    let member_name = $(this).data('member_name');
    let member_id = $(this).data('member_id');
    alert(i)
    $.ajax({
    	type:'post', url:'/setAnswer',
    	data:{id:$('#goodsNumber').val(), content : content, qna_id : qna_id, member_name : member_name, member_id : member_id}, 
    	dataType:'text',
    	success:function(data){
    			$('#tblQna tr.Re1').remove();
    			getQna();
    	}
    })
})
.on('click','.notyet',function(){
	if($(this).find('td:eq(0)').text() == '미답변' && id != 'admin'){
       return false;
	}
	$(this).closest('tr').next('.Re1').toggle();
})


.on('click','#addCart',function(){
	alert(id);
	alert($('#goodsNumber').val());
	alert($('#result').val());
	console.log(id, typeof id);
	if(id === "null"){
		alert("로그인 후 가능합니다..")
		document.location='/login'
		return false;
	}
	$.ajax({
		type:'post', url:'/addCart',
		data:{member_id:id, goods_id:$('#goodsNumber').val(), cnt:$('#result').val()},
		dataType:'text',
		success:function(data){
			if(data == 1){
				alert("장바구니에 상품을 담았습니다.")
				let result = confirm("장바구니로 이동하시겠습니까?")
				if(result){
					document.location='/cart'
				} else {
					return false;
				};
			} else {
				alert("이미 같은 상품이 장바구니에 담겨있습니다.")
				return false;
			}
		}
	})
})

.on('click','#directOrder',function(){
	alert($('#goodsNumber').val())
	$('#gPrice').val($('.goodsPrice').text())
	$('#goOrder').submit();
})


function toglReview(TKclass) {
    $(TKclass).closest('tr').next('.Re1').toggle();
}

function count(type)  {
  const resultElement = $('#result');
  let number = resultElement.val();
  if(type === 'plus') {
    number = parseInt(number) + 1;
  }else if(type === 'minus')  {
    number = parseInt(number) - 1;
    if(number<1){return false;}
  }
  resultElement.val(number);
  
  $('.tital-price').text(number * parseInt($('.goodsPrice').text().slice(0, -1)) + '원');
} /*+ - 버튼눌러 수량을 나타내는 스크립트*/

function onIMG(){
  let src = $(event.target).attr('src');
  $('.M_img').attr('src',src);
} /*작은 그림에 마우스 올렸을떄 올린 그림의 링크를 큰그림 링크에 붙여넣는 스크립트*/

function offIMG(){
  $('.M_img').attr('src','/img/' + imgSrc);
} /*마우스가 그림에서 떠날때 설정한 기본상품의 그림 초반그림 설정해줘야함*/

function Juuu(){
  document.location='/tkorder?img='+$('.M_img').attr('src')+'&goodsName='+$('.goodsName').text()+'&goodsPrice='+$('.goodsPrice').text()+'&goodsSend='+$('.goodsSend').text()+'&result='+$('#result').val();
}/**/



//리뷰 불러오는 함수
function getReviwe() {
	$.ajax({
		type:'post', url:'/getReview',
		data:{id:$('#goodsNumber').val()},
		dataType:'json',
		success:function(data){
			let str = "";
			if(data.length > 0){
				for(let i = 0; i < data.length; i++) {
		            str += '<tr style="border-bottom: 1px solid #ccc;"><td>' + data[i].rating + '</td>'
		            + '<td class="Re1" onclick="toglReview(this)" style="cursor: pointer;">' + data[i].title +'</td>'
		            + '<td>' + data[i].user_id + '</td><td>' + data[i].created +'</td></tr>'
		            + '<tr class="Re1" hidden style="border-bottom: 1px solid #ccc;">'
		            + '<td></td><td colspan="3" style="text-align:left;">' + data[i].content + '</td></tr>'
				}
				$('#tblReview').append(str)
			} else {
				str += '<tr><td colspan="4"> 등록된 리뷰가 없습니다. </td></tr>'
				$('#tblReview').append(str)
			}
		}
	})
}

function getQna() {
	$.ajax({
		type:'post', url:'/getQna',
		data:{id:$('#goodsNumber').val()},
		dataType:'json',
		success:function(data){
			let str = "";
			for(let i = 0; i < data.length; i++) {
				let qna_id = data[i].id;
				let member_name = data[i].qwriter;
				let member_id = data[i].member_id;
	            //str += '<tr class="Re1" onclick="toglQna(this)" style="cursor: pointer;">'
	            str += '<tr class="Re1 notyet"  style="cursor: pointer; border-bottom: 1px solid #ccc;">'
	            +  '<td>' + data[i].name +'</td>'
	            +  '<td>'+ data[i].content+ '</td>'
	            +  '<td>'+ member_name +'</td>'
	            +  '<td>' + data[i].qusdate +'</td></tr>'
	            
	            if(data[i].state == '1' && id == 'admin') {
	            		str+=  '<tr class="Re1" hidden>'
			            +  '<td colspan="3"><textarea rows="4" id="setAnswer' + i + '" style="resize: none; width: 100%;"></textarea></td>'
			            + '<td><button class="btnQna"data-i="' + i + '" data-qna_id="' + qna_id + '" data-member_name="' + member_name + '" data-member_id="' + member_id + '">등록하기</button></td></tr>'
	            } else {
		            str+=  '<tr class="Re1" hidden style="border-bottom: 1px solid #ccc;">'
		            +  '<td colspan="2" style="font-size: 80%; text-align: left;">Q.'+ data[i].content +'<br><hr>A.' + data[i].answer+ '<br></td>'
		            +  '<td>' + data[i].awriter + '</td>'
		            +  '<td>' + data[i].ansdate + '</td></tr>'	
	            }
			}
			$('#tblQna').append(str)
		}
	})
}


//QnA불러오는 함수
</script>
</html>
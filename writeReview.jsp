<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>작성하기</title>
<link href="/css/theme.css" rel="stylesheet" type="text/css">
</head>
<style>
	body {
	    font-family: Arial, sans-serif;
	    background-color: #f4f4f4;
	    margin: 0;
	    padding: 0;
	}
	
	.layout {
	    width: 80%;
	    max-width: 600px;
	    margin: 20px auto;
	    background-color: #fff;
	    padding: 20px;
	    border-radius: 8px;
	    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
	}
	
	.layout label {
	    display: block;
	    font-weight: bold;
	    margin-bottom: 5px;
	}
	
	.layout input[type="text"],
	.layout textarea {
	    width: 100%;
	    padding: 10px;
	    margin-bottom: 15px;
	    border: 1px solid #ccc;
	    border-radius: 4px;
	    box-sizing: border-box;
	}
	
	.layout textarea {
	    min-height: 150px;
	    resize: vertical;
	}
	
	.layout button {
	    background-color: black;
	    color: #fff;
	    border: none;
	    border-radius: 4px;
	    padding: 10px 20px;
	    cursor: pointer;
	    font-size: 16px;
	}
	
	.layout button:hover {
	    background-color: #0056b3;
	}
	
	.layout select {
	    width: 100%;
	    padding: 10px;
	    margin-bottom: 15px;
	    border: 1px solid #ccc;
	    border-radius: 4px;
	    box-sizing: border-box;
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
   
    <main id="main">
     <div id="mainContent"> 
     
<div class="layout" id='data_div'>
   	<label>작성하기</label>
   	<input type="hidden" style="display:none" class="order_id" value="${order_id}">
    <input type="hidden" style="display:none" class="goods_id" value="${goods_id}">
    <select id="rating" required="required">
  	  <option name="rating" value="10" selected disabled>평점을 선택해주세요.</option>
  	  <option name="rating" value="10">10점</option>
  	  <option name="rating" value="9">9점</option>
  	  <option name="rating" value="8">8점</option>
  	  <option name="rating" value="7">7점</option>
  	  <option name="rating" value="6">6점</option>
  	  <option name="rating" value="5">5점</option>
  	  <option name="rating" value="4">4점</option>
  	  <option name="rating" value="3">3점</option>
  	  <option name="rating" value="2">2점</option>
  	  <option name="rating" value="1">1점</option>
    </select>
    <input type="text" class="title" placeholder="제목" required>
    <textarea class="content" placeholder="내용" required></textarea>

    <button id="write">등록하기</button>
    <a href="/myOrderList"><button>취소하기</button></a>
</div>
</div>
</main>
 
 <footer id="footer">
	<%@ include file="include/footer.jsp" %>
</footer>
</body>


<script src='http://code.jquery.com/jquery-latest.js'></script>
<script>
$(document)
.ready(function() {
    focusOnEmptyInput();  
})

.on('click','#write',function(){
   console.log("order : " + $('.order_id').val())
   console.log("goods : " + $('.goods_id').val())
   console.log("title : " + $('.title').val())
   console.log("content : " + $('.content').val())
   console.log("rating: " + $('#rating option:selected').val())
     $.ajax({
        type:'post', url:'/addReview', 
        data:{order_id : $('.order_id').val(), goods_id : $('.goods_id').val(), title:$('.title').val(), content:$('.content').val(),rating:$('#rating option:selected').val()}, 
        dataType:'text',
        success:function(data){
        	document.location="/myOrderList"
        }
    }); 
})

function focusOnEmptyInput(){
	 $('#data_div input').each(function() {
	      if ($(this).val() === '') {
	        $(this).focus();
	        return false; 
	      }
	 });
}


</script>
</body>
</html>
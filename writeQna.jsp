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
   	<label>상품문의 작성하기</label>
    <input type="hidden" style="display:none" class="goods_id" value="${goods_id}">
    <textarea class="content" placeholder="내용" required></textarea>

    <button id="write">등록하기</button>
    <button id="cancel">취소하기</button>
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
   console.log("goods : " + $('.goods_id').val())
   console.log("content : " + $('.content').val())
     $.ajax({
        type:'post', url:'/addQna', 
        data:{goods_id : $('.goods_id').val(), content:$('.content').val()}, 
        dataType:'text',
        success:function(data){
        	window.location.replace(document.referrer);
        }
    }); 
})

.on('click','#cancel',function(){
	window.location.replace(document.referrer);
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
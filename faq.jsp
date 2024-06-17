<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>fna</title>
<link href="/css/theme.css" rel="stylesheet" type="text/css">

<style>
.middle_top_hr {
  margin-bottom: 20px;
}

#data_write{
  display: none;
}

.announcement { 
  margin-bottom: 10px;
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
  

<main>
	 <h1 class="middle_top_title">자주묻는질문</h1>
	 <hr class="middle_top_hr">

<c:forEach items="${boardlist}" var="board">  

<div class="announcement" id='data_list' style="cursor: pointer;" >
 <span>제목: ${board.title}</span>
  <div>
    <span>작성자: ${board.writer}</span>
    <span>작성시각: ${board.created}</span>
  </div>
</div>
<div class="announcement" id='data_write' style="display: none;">
  <input type="hidden" id="uniq" value=${board.id} > 
  <input type="hidden" id="title" value=${board.title}> 
  <input type="hidden" id="category" value="${board.category}" >
  <input  type="hidden" id="writer"  value=${board.writer} readonly >
  <textarea id="content" style="display: none;">${board.content}</textarea>  
  

   <pre id="content" readonly >${board.content}</pre>
   
   <!-- <input type="text" id="uniq" value=${board.id} style="display: none;"> -->
   <%--  <input type="text" id="category" value="${board.category}" >  --%>
   <!-- <label>제목</label><input type="text" id="title" value=${board.title}> -->
  <!--  <label>작성자</label><input type="text" id="writer"  value=${board.writer} readonly > -->
  <%--  <label>내용</label><textarea id="content">${board.content}</textarea> --%>
 
<c:if test="${sessionScope.admin != null }"> 
 <br><br> 
  <button id="btnbModify" >수정하기</button>
  <button id="btnbDelete" >삭제하기</button>
</c:if>

</div>

</c:forEach>

<c:if test="${sessionScope.admin != null }">  
<button id=gowrite>작성하기</button>
</c:if>
</main>
  
<footer id="footer">
  	<%@ include file="include/footer.jsp" %>
</footer>   

 
</body>   



<script src='http://code.jquery.com/jquery-latest.js'></script>
<script>
$(document)
.ready(function(){
	focusOnEmptyInput();	
})

.on('click','#clear',function(){
	$('#title,#text').val('');
})

.on('click','#data_list',function(){
	$(this).next().toggle(300);
})  

.on('click','#gowrite',function(){
	location.href="/write";
})

.on('click','#btnbDelete',function(){
	let id=$(this).parent().find('input#uniq').val();
	let category=$(this).parent().find('input#category').val();
	
	$.ajax({
		type:'post', url:'/boardDelete',
		data:{uniq:id,category:category},
		dataType:'text',
		success:function(data){
			if(data==1||data==2){
				alert('성공하였습니다')
				location.href="/faq";
			} else{
				alert('실패하였습니다')
			}
		}
	})	
})
.on('click','#btnbModify',function(){
	let id=$(this).parent().find('input#uniq').val();
	location.href="/write?id="+ id;
}) 
/* function category(){
	$.ajax({
		type:'Get', url:'/catagoryboard', data:{}, dataType:'json',
		success:function(data){
			for(let i=0; i<data.length; i++){
				let ob=data[i];
				let str='<option value='+ob['id']+'>'+ ob['name'] + '</option>';
				$('#category').append(str);
			}
		}
	})
} */

function focusOnEmptyInput(){
	 $('#data_div input').each(function() {
	      if ($(this).val() === '') {
	        $(this).focus();
	        return false; 
	      }
	 });
}

</script>
</html>
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
     
<input  type='hidden' id="memberID"  >
<input  type='text' id="board_id" value=${id }>
<input  type='hidden' id="title" value=<%=admin%> >

     
<div class="layout" id='data_div'>
   	<label>작성하기</label>
    <input type="text" id="titleInput"  placeholder="제목">
    <input type="hidden" id="category2">
    <input type="hidden" id="writer" value=<%=id%> readonly >
    <input type="text" id="nickname" value=<%=name%> readonly >
    <textarea id="content" placeholder="내용"></textarea>

   <select id="category" required="required">
   <option value="" selected disabled hidden>카테고리를 선택해주세요.</option> 
   </select>
    <br><br>
    <button id="write" >작성하기</button>
    <button id="btnbModify" >수정하기</button>
    <button id="clear" >취소하기</button>
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
    category();
    focusOnEmptyInput();
    setingData(); 
 	
    /* if($('#board_id').val() != 'admin'){
 		boardload(); 
 	} */
  
})
/* .on('change', '#category', function() {
    console.log($(this).val());
}) */
.on('click','#write',function(){
    let previousPage = document.referrer;
   
    if(!$('#category').val()) {
        alert("카테고리의 값을 선택해주세요.");
        return;
    } else if($('#titleInput').val()=='' || $('#content').val()==''){
    	alert("빈 칸을 입력해주세요.");
        return;
    }
    
    $.ajax({
        type:'post', 
        url:'/doWrite', 
        data:{ memberID:$('#memberID').val(),
        	   title:$('#titleInput').val(),
        	   writer:$('#writer').val(),
        	   content:$('#content').val(),
        	   category:$('#category option:selected').val(),
        	   nickname:$('#nickname').val()}, 
        dataType:'text',
        success:function(data){
        
            if(data==1){
                alert('관리자 글 작성 성공')
                $('#title,#text').val('');
                window.location.href = previousPage;
            } else if(data==2){
                alert('글 작성 성공')
                $('#title,#text').val('');
                window.location.href = previousPage;
            } else {
                console.log(data);
                alert('글 작성 실패-관리자에게 문의하세요.')
                $('#title,#text').val('')
            }
        }
    }); 
})
 .on('click','#btnbModify',function(){
	var previousPage = document.referrer;
	
	$.ajax({
		type:'post', url:'/boardModify',
		data:{title:$('#titleInput').val(),
			  content:$('#content').val(),
			  uniq:$('#board_id').val(),
			  category:$('#category option:selected').val()},//$('#uniq').val()}, 
		dataType:'text',
		success:function(data){
			if(data==1 || data==2){
				alert('글 수정-성공하였습니다')
				window.location.href = previousPage;
			} else{
				alert('글 수정-실패하였습니다')
			}
		}
	}) 
})  


 function category() {
	var admin = '<%= session.getAttribute("admin") %>';
    if (admin == null || admin == '' || admin == "null") {
        admin = "1";      
    }
	
    $.ajax({
        type: 'GET',
        url: '/catagoryboard',
        data: { admin: admin },
        dataType: 'json',
        success: function(data) {
            for (let i = 0; i < data.length; i++) {
                let ob = data[i];           
                if (admin==1) {
                	 if (ob['id'] >= 3) {                          
                        let str = '<option value=' + ob['id'] + '>' + ob['name'] + '</option>';
                        $('#category').append(str);
                	 }
                } else  {                	 
                    let str = '<option value=' + ob['id'] + '>' + ob['name'] + '</option>';
                    $('#category').append(str);               	 
                }
            }
        }
    });
} 


function focusOnEmptyInput(){
	 $('#data_div input').each(function() {
	      if ($(this).val() === '') {
	        $(this).focus();
	        return false; 
	      }
	 });
}
function setingData(){
	let id = '<%=(String)session.getAttribute("id")%>';
	console.log(id);
	$.ajax({
		type:'post', url:'/myLoad',
		data:{user_id:id},
		dataType:'json',
		success:function(data){
			$('#memberID').val(data[0].id);	
		}
	})
}
/* function boardload(){ // 카테고리부분 확인.
	
	$.ajax({
	      type: 'post', 
	        url: '/boardData',
	        data: {id:$('#board_id').val()}, 
	        dataType: 'json',
	        success: function(data) {
	           $('#titleInput').val(data.title);
	           $('#content').val(data.content);  
	           $('#category2').val(data.category);
	           
	       
	           	$('#category option').each(function(){
	               if($(this).val()==data.category){
	                  $(this).prop('selected',true)  
	                  return false;
	               }
	            }) 
	          
	          
	      }
	 });
	 
} */




</script>
</body>
</html>
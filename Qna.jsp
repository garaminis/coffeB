<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>나의 문의내역</title>
<link href="/css/theme.css" rel="stylesheet" type="text/css">

<style>
	
.middle_top_hr {
  margin-bottom: 20px;
}

#data_write{
  display: none;
}
/* .cid {
  display: none;
} */

.announcement { 
  margin-bottom: 10px;
}
label {
  font-weight: bold;
  margin-bottom: 5px;
}

pre {
  padding: 10px;
  border-radius: 5px;
  white-space: pre-wrap;
  margin-bottom: 15px;
}
.tblmodi{
  display:none;
}
.popup {
    display: none;
    position: fixed;
    z-index: 1000;
    left: 50%;
    top: 50%;
    transform: translate(-50%, -50%);
    border: 1px solid #888;
    width: 400px;
    padding: 20px;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
    height: 80%;
    overflow-y: auto;
    background-color: white;
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
 <h1 class="middle_top_title">QnA</h1>
 <hr class="middle_top_hr">

<input type="hidden" id=userid value="${id }">
<input type="hidden" id=admin value="${admin }">

<c:forEach items="${directQnAlist}" var="directQnA">
  <div class="announcement" id='data_list' style="cursor: pointer;">
     <span>제목: ${directQnA.title}</span>
	  <div>
	    <span>작성자: ${directQnA.writer}</span>
	    <span>작성시각: ${directQnA.created}</span>
	  </div>
  </div>

  <div class="announcement" id='data_write' > 
      <input type="hidden" id="uniq" value="${directQnA.id}" > 
      <input type="hidden" id="category" value="${directQnA.category}" > 
      
      <label>제목</label><pre id="title" >${directQnA.title}</pre>
      <label>작정자</label><pre id="writer"  >${directQnA.writer}</pre>
      <label>내용</label><pre id="content" >${directQnA.content}</pre>
 
	<c:if test="${sessionScope.id != null and sessionScope.id==directQnA.writer}">  
      <button id="btnbModifygo" >수정하기</button>
      <button id="btnbDelete" >삭제하기</button><br><br>
    </c:if>
   <c:set var="writerValue" value="${not empty Qwriter ? Qwriter : ''}" />
	<c:if test="${not empty writerValue}">
    	<input type="hidden" id="comment_id" >
	    <label>답변</label><pre id="comment" ></pre>
	    <label>답변자</label><pre class="Qwriter" ></pre>
   </c:if>
        
    <!-- <select id="answerstate" required="required">
        <option value="" selected disabled hidden>답변 상태를 선택해주세요.</option>
    </select> -->
    <!-- <input type=radio value="2" >답변
    <input type="radio" value="1" >미답변 -->


<br><br>
      <c:if test="${sessionScope.admin != null }">  
          <button id="btnCommentgo" >답변하기</button>
          <button id="btnDelete_coment" >답변삭제하기</button>
      </c:if> 
  </div>
  
</c:forEach>

   <!---- popup ---->
 <div class="popup" id="add_popup">
      <div class="layout" id='data_div'>
	   	<label>작성하기</label>
	   	<input type="hidden" id="cid2" >
	   	<input type="hidden" id="category2">
	    <input type="text" id="titleInput2"  placeholder="제목">
	    <input type="text" id="writer2"  readonly >
	    <textarea id="content2" placeholder="내용"></textarea>

	    <br><br>
	    <button id="btnbModify" >수정하기</button>
	    <button id="clear" >취소하기</button>
	    <button class="btnclose" >닫기</button>
	    
	    <br><br>
	     <c:if test="${sessionScope.admin != null }">  
		    <input type="hidden" class="cid3" >
		    
		    <label>답변 작성하기</label> 
		    <textarea class="comment2"></textarea>
		    <input type="text" id="Qwriter2" value="<%=id%>" readonly> 
		   
	
		    <br><br>
		    <button id="btnComment" >답변하기</button>
		    <button id="clear" >취소하기</button>
		    <button class="btnclose" >닫기</button>
	    </c:if> 
	    
	</div>
   </div>




<button id=gowrite>작성하기</button>

</main>
  
<footer id="footer">
  	<%@ include file="include/footer.jsp" %>
</footer>   

 
</body>   



<script src='http://code.jquery.com/jquery-latest.js'></script>
<script>

$(document)
.ready(function(){
	let str=$('#writer').val(); 
	commentLoad();
	
})

.on('click','#clear',function(){
	$('#titleInput2,#content2').val('');
})
 .on('click', '#data_list', function() {
     let clickedElement = $(this);  // 클릭된 요소를 변수에 저장
    $(this).next().toggle(300); // 클릭된 요소의 다음 요소를 토글
    
   /* let commnet = $('.Qwriter').text().trim();
    
    if (commnet !== '') {
        $('.Qwriter,').show();
    } else {
        $('.Qwriter').hide();
    } */
    
   /* 
    if ($('input[type="radio"][value="2"]').length > 0) {
        $('input[type="radio"][value="2"]').prop('checked', true);
    } else {
        
        $('input[type="radio"][value="1"]').prop('checked', true);
    } */
 }) 

    /* $.ajax({
        type: 'GET', 
        url: '/answerstate',
        data: {}, 
        dataType: 'json',
        success: function(data) {
            // 클릭된 요소를 변수로 사용하여 해당 요소 아래의 select 요소 선택
            let selectElement = $(this).next().next().find('select#answerstate'); 
            for (let i = 0; i < data.length; i++) {
                let ob = data[i];
                let str = '<option value="' + ob['id'] + '">' + ob['name'] + '</option>';
                selectElement.append(str);
            }
        },
        error: function(xhr, status, error) {
            console.error('Ajax 요청 중 오류 발생:', error);
        }
    }); */

.on('click','#gowrite',function(){
	if($('#userid').val()==''){
		alert("로그인을 하십시오.")
		return
	}
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
			if(data==1 || data==2){
				alert('성공하였습니다')
				location.href="/Qna";
			} else{
				alert('실패하였습니다')
			}
		}
	})	
})
.on('click','#btnbModify',function(){
	
	    $.ajax({
		type:'post', url:'/boardModify',
		data:{title:$('#titleInput2').val(),content:$('#content2').val(),
			  uniq:$('#cid2').val(),category:$("#category2").val()},//$('#uniq').val()}, 
		dataType:'text',
		success:function(data){
			if(data==1 || data==2){
				alert('성공하였습니다')
				location.href="/Qna";
			} else{
				alert('실패하였습니다')
			}
		}
	})    
})  


.on('click',"#btnbModifygo,#btnCommentgo",function(){
     var title = $(this).closest(".announcement").find("#title").text(); 
     var writer = $(this).closest(".announcement").find("#writer").text(); 
     var content =$(this).closest(".announcement").find("#content").text(); 
     var id =$(this).closest(".announcement").find("#uniq").val(); 
     var cate =  $(this).closest(".announcement").find("#category").val();
     var id2 = $(this).closest(".announcement").find("#comment_id").val(); 
     var commnent = $(this).closest(".announcement").find("#comment").text(); 
       
     $("#titleInput2").val(title);
     $("#writer2").val(writer);
     $("#content2").val(content);
     $("#cid2").val(id);
     $("#category2").val(cate);
     $(".cid3").val(id2);
     $(".comment2").val(commnent);

     $("#add_popup").show();
})

.on('click','.btnclose',function(){ 
	 $('.popup').hide();
})
 .on('click','#btnComment',function(){

    $.ajax({
       type:'post', url:'/doComment', 
       data:{uniq: $("#cid2").val() ,writer:$('#writer2').val(),category:$("#category2").val(),
             Qwriter:$('#Qwriter2').val(),comment:$('.comment2').val(),comment_id:$('.cid3').val()}, 
       dataType:'text',
       success:function(data){     	
       	if(data==1){
			alert('작성-성공하였습니다');
			answerstate ();
			location.href="/Qna";
		}else if(data==2){
			alert('수정-성공하였습니다');
			location.href="/Qna";
		} else {
			alert('실패하였습니다')
		}
       }
 })    
})    

.on('click','#btnDelete_coment',function(){
	let comment_id=$(this).parent().find('input#comment_id').val();
	
	$.ajax({
		type:'post', url:'/QnaDelete',
		data:{comment_id:comment_id},
		dataType:'text',
		success:function(data){
			if(data==1){
				alert('삭제하였습니다')
				location.href="/Qna";
			} else{
				alert('실패하였습니다')
			}
		}
	})	
})
/* .on('click','#btnModify_coment',function(){
	/* let comment_id=$(this).parent().find('input#comment_id').val();
	let comment=$(this).parent().find('textarea#comment').val();
	console.log(comment);
	 
	
	 $.ajax({
		type:'post', url:'/QnaModify',
		data:{comment_id:comment_id,comment:comment},//$('#uniq').val()}, 
		dataType:'text',
		success:function(data){
			if(data==1){
				alert('성공하였습니다')
				location.href="/myAbout";
			} else{
				alert('실패하였습니다')
			}
		}
	}) 
})
 */
 
function commentLoad(clickedElement) {
    let directid = $(clickedElement).next().find('input#uniq').val(); 
    let commentPre = $(clickedElement).closest('.announcement').next().find('pre#comment');
    let comment_id = $(clickedElement).closest('.announcement').next().find('input#comment_id');
    let qwriter = $(clickedElement).closest('.announcement').next().find('pre.Qwriter');
    
    $.ajax({
        type: 'POST',
        url: '/commentLoad',
        data: {directid: directid}, 
        dataType: 'json',
        success: function(data) { 
            let found = false; // directid가 응답 데이터에 있는지 여부를 추적하는 변수
            for (let i = 0; i < data.length; i++) {
                if (data[i]['id'] == directid) {
                    found = true;  // id가 일치하는 경우 found를 true로 설정
                    comment_id.val(data[i]['Commet_id'])
                    commentPre.text(data[i]['content'])
                    qwriter.text(data[i]['Qwriter'])
                    break;
                }
            }
        }
    });  
}  

$('.announcement').click(function() {
    commentLoad(this);
});

function answerstate() { //답변달면 답변상태 바꾸기. 
	
	console.log($('#cid2').val());
	$.ajax({
        type: 'POST',
        url: '/doAnswer',
        data: {comment_id:$('#cid2').val()}, 
        dataType: 'text',
        success: function(data) { 
          	if(data==1){
          		console.log("성공");
          	}
            
        }
    });  
	
}


</script>
</html>
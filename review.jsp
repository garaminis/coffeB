<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>후기</title>
<style>
	table{border-collapse:collapse;}
	td{border:1px solid block;}
</style>
<script src='https://code.jquery.com/jquery-latest.js'></script>
</head>
<body>

<table id=tblReview>
<tr><td>야호</td></tr>
</table>

<table>
	<tr><td>제목</td><td><input type=text name=title id=title></td></tr>
	<tr><td>내용</td><td><textarea rows="10" cols="30" name=content id=content></textarea></td></tr>
	<tr><td>작성자</td><td><input type=text name=writer id=writer></td></tr>
	<tr><td style='text-align:center' colspan=2><button id=btnAdd>등록</button></td></tr>
</table>

</body>

<script>
$(document)
.ready(function(){
	getReviewList();
})

function getReviewList(){
	$.ajax({
	type : 'Post',
	url : '/list',
	data : {},
	dataType : 'json',
	success : function(data){
		/* $('#tblReview tr:gt(0)').empty(); */
		$.each(data,function(i, ob){
			let str = '<tr>';
		    str += '<td>' + ob.score + '</td>'; 
		    str += '<td>' + ob.userid + '</td>';
		    str += '<td>' + ob.created + '</td></tr>';
		    str += '<tr><td colspan=3>' + ob.content + '</td>';
		    str += '</tr>';
			$('#tblReview').append(str);
		})
	}
	})
}
</script>
</html>
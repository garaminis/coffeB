<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>커피블리스</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="/css/theme.css" rel="stylesheet" type="text/css">
</head>
<style>
		.card {
		    flex: 0 0 calc(23% - 20px);
		    overflow: hidden;
		    transition: transform 0.3s ease;
		    border: 0px;
		}

		.card:hover {
		    transform: translateY(-5px);
		}

		.card-body {
		    height: 250px;
		    display: flex;
		    justify-content: center;
		    align-items: center;
		   	padding: 0;
		}
		
		.card-body img {
		    object-fit: cover;
		    max-width: 100%;
		    max-height: 100%;
		}
		
		.card-content p {
		    font-size: 15px;
		    color: #333;
		    padding: 5px;
		}
		

@media (max-width: 767px) {
  .module-small .col-sm-6 {
    width: 50%;
    float: left; /* 가로로 나열하기 위해 float 속성 추가 */
  }
}

/* 중간과 큰 화면에서는 4개의 열을 가로로 나열 */
@media (min-width: 768px) {
  .module-small .col-md-3,
  .module-small .col-lg-3 {
    width: 25%;
    float: left; /* 가로로 나열하기 위해 float 속성 추가 */
  }
}

/* clearfix 속성을 사용하여 부모 컨테이너의 높이 자동 조절 */
.module-small .row::after {
  content: "";
  display: table;
  clear: both;
}

#middle_area2 .row {
    display: flex;
    flex-wrap: wrap;
    margin: 0 -15px;
}

#middle_area2 .col-sm-6 {
    padding: 0 15px;
    margin-bottom: 20px; /* 각 요소의 아래쪽 여백 추가 */
}
.styled-link {
    color:  rgb(139, 90, 26); /* 링크 색상 */
    text-decoration: none; /* 밑줄 제거 */
    font-weight: bold; /* 폰트 굵기 설정 */
    transition: background-color 0.3s, color 0.3s; /* 호버 효과를 위한 전이 효과 설정 */
}
.styled-link:hover {
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
<div id="container">
  <main>
    <div class="mainContent">
      <div id="middle_top">
          <h1 class="middle_top_title">${itemList[0].name}</h1><input type="hidden" style="display:none" id="catrgoryCheck" value="${itemList[0].id}">
          <hr class="middle_top_hr">
      </div>
			<div id="middle_area2">
      		<div class="row">
							<c:forEach items="${itemList}" var="item">
              		<div class="col-lg-3 col-md-6 mb-4">
                  		<a href="/goods?id=${item.id}" class="styled-link">
											<div class="card h-100" style="margin-top: 15px;">
                      		<div class="card-body" style="height: 250px;">
                          		<img style="object-fit: contain; height: auto; width: 100%; max-height: 100%;" src="${item.img1}" alt="상품이미지" />
                          </div>
		                      <div class="card-content p-3 d-flex flex-column" style="border-top: 1px solid #ccc; height: 120px; padding-left: 7px; padding-right: 7px;">
		                  				<div>
		                          		<h5 class="shop-item-title font-alt">${item.title}</h5>
		                         	</div>
		                      		<div>
		                      				₩<fmt:formatNumber pattern="###,###,###" value="${item.price}" />
		                      		</div>
													</div>
											</div>
											</a>
									</div>
							</c:forEach>
					</div>
			</div>
		</div>
  </main>
</div>
<footer id="footer">
		<%@ include file="include/footer.jsp" %>
</footer>
</body>
<script>
$(document)
.ready(function(){
	
})

let pageCnt = 0;

/* $(window).scroll(function(){
	let currentScrollTop = $(window).scrollTop();
	let lastScrollTop = 0;

	let id = $('#catrgoryCheck').val();
	if(currentScrollTop - lastScrollTop > 0) {
	  lastScrollTop = currentScrollTop;		
	} else {
	  lastScrollTop = currentScrollTop;
	}
	if($(window).scrollTop() >= ($(document).height() - $(window).height())) {
		let lastItem = $(".scrolling:last").attr("item");
		pageCnt += 1;
		$.ajax({
			type:'get', url:'/itemScroll',
			data:{id : $('#catrgoryCheck').val(), page : pageCnt, lastItem: lastItem }, 
			dataType:'json',
			success:function(data){
				alert(pageCnt)
				let str = "";
					for(let i = 0; i < data.length; i++){
						if (lastItem != data[i].id) {
						let price = new Intl.NumberFormat('ko-KR', { style: 'currency', currency: 'KRW' }).format(data[i].price);
						str += '<div class="col-sm-6 col-md-3 col-lg-3 mt-60 mb-40 scrolling" item="' + data[i].id + '" style="padding-left: 10px; padding-right: 10px;">'
			                + '<div class="shop-item">'
			                + '<a href="/goods?id='+ data[i].id +'">'
			                + '<div style="text-align: center; padding: 30px;">'
			                + '<div style="width: 100%; height: 300px; overflow: hidden; display: flex; align-items: center;">'
			                + '<img style="width: 100%;  " src="/img/' + data[i].img1 + '" alt="이미지제대로 넣어라"/></div>'
			                + '<div><h4 class="shop-item-title font-alt">' + data[i].title + '</h4>'
			                + price + '</div></div></a></div></div>'
						}
					}
				$(".module-small").append(str);
				lastItem = $(".scrolling:last").attr("item");
			}
		})
	}
}); */
</script>

</html>
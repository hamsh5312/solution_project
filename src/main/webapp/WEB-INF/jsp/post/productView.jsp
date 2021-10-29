<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
     <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
     <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 화면</title>

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
<script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>

<!-- jQuery -->
<script src="http://code.jquery.com/jquery-1.12.4.min.js"></script>
<script src="http://code.jquery.com/jquery-migrate-1.4.1.min.js"></script>

<!-- slippry.js 추가-->
<link rel='stylesheet' href='https://cdnjs.cloudflare.com/ajax/libs/slippry/1.4.0/slippry.min.css' />
<script src='https://cdnjs.cloudflare.com/ajax/libs/slippry/1.4.0/slippry.min.js'></script>

<!--  -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
<!--  -->
<link rel="stylesheet" href="/static/css/style.css" type="text/css">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.3.0/font/bootstrap-icons.css">

<style>
	*{margin: 0; padding:0; }
	.slide-wrap{
		width: 50%; margin: 0 auto;
	}
	/* 미디어쿼리*/
	@media screen and (max-width: 960px) {.slide-wrap{
		width: 70%; } }
	@media screen and (max-width: 720px) {.slide-wrap{
		width: 80%; } }
	@media screen and (max-width: 480px) {.slide-wrap{
		width: 100%; } }
			
</style>

</head>
<body>

	<div id="wrap">
	
		<c:import url="/WEB-INF/jsp/include/header.jsp" />
		<hr>
		
		<section>
			<div>
				<nav class="mt-1">
					<ul class="nav nav-fill">
                        <li class="nav-item"><a class="nav-link" href="/post/create_view">고민 올리기</a></li>
                        <li class="nav-item"><a class="nav-link" href="/post/list_view">고민 리스트</a></li>
                        <li class="nav-item"><a class="nav-link" href="/post/ranking_view">고민 해결 순위</a></li>
                        <li class="nav-item"><a class="nav-link" href="/post/product_view">이번달 상품 종류</a></li>
                    </ul>
				</nav>
			</div>
		
		<!-- 지난달 상품 사진 올리기 -->
		<h3 class="text-center mt-4">지난달 상품</h3>
		<div>
			<div class="d-flex justify-content-center mt-4">
				<div>
					<img src="/static/images/laptop.jpg" width="200" height="200">
					<div class="text-center mt-2">
						노트북(1)
					</div>
				</div>
				<div class="ml-2">
					<img src="/static/images/camera.jpg" width="200" height="200">
					<div class="text-center mt-2">
						카메라(2)
					</div>
				</div>
				<div class="ml-2">
					<img src="/static/images/microphone.jpg" width="200" height="200">
					<div class="text-center mt-2">
						무선 마이크(3)
					</div>
				</div>
			</div>
		</div>
		<!-- 이번 달 상품 -->
		<div id="slide-wrap">
			<h1 class="text-center mt-4">이번 달 상품</h1>
			<article class="d-flex justify-content-center">
				<!-- 이미지 슬라이드 -->
				<div class="w-50 my-2">
					<ul id="gallery">
						<li><a href="#slide1"><img src="/static/images/TV.jpg" height="400" alt="1등 상품(TV)"></a></li>
						<li><a href="#slide2"><img src="/static/images/iPad.jpg" height="400" alt="2등 상품(아이패드)"></a></li>
						<li><a href="#slide3"><img src="/static/images/AirPods.jpg" height="400" alt="3등 상품(에어팟)"></a></li>
					</ul>
				</div>				
			</article>
		</div>	
			
		<div class="d-flex justify-content-center align-items-center">
			<div class="w-75 my-2 text-center">
				<h2 class="pt-5">TOP 3</h2>
				<img class="pb-3" src="/static/images/product_image.jpg" width="150" height="150">
				<c:forEach var="top3" items="${top3People }" varStatus="status">
					<h2>${top3 }님 ${status.index + 1 } 등 축하드립니다.</h2>
					<br>
				</c:forEach>
			</div>
		</div>
			
		</section>
		
		<c:import url="/WEB-INF/jsp/include/footer.jsp" />
	
	</div>
	
	<script>
		
		$(function(){
			
			// 슬라이드로 실행할 영역을 변수로 지정
			var $slide = $('#gallery');
			
			//실행
			var gal = $slide.slippry({
				// 옵션
				transition: 'fade',  //'kenburns', // 'horizontal',
				speed:1000,
				easing: 'linear'
				
			});
			
		});
		
	
	</script>

</body>
</html>
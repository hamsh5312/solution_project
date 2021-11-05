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

<!-- 뽑기 설정 셋팅 -->
<script src="https://cdn.sobekrepository.org/includes/jquery-rotate/2.2/jquery-rotate.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-easing/1.4.1/jquery.easing.min.js"></script>
<link rel="stylesheet" href="/static/css/circle.css">
  	
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

	<c:choose>
	<c:when test="${not empty top5People }">
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
				
				<c:forEach var="top5" items="${top5People }" varStatus="status">
				
						<c:if test="${top5.commentCreateUserName ne top3People.get(0)}">
							<c:if test="${top5.commentCreateUserName ne top3People.get(1)}">
								<c:if test="${top5.commentCreateUserName ne top3People.get(2)}">
									<h5>${top5.commentCreateUserName }님 ${status.index + 1 } 등 축하드립니다.</h5>
									
								</c:if>
							</c:if>
						</c:if>
						<!-- 4등 5등을 뽑아지는데 다른방법 없나? 다시시도 하자 -->
				</c:forEach>
				
				
			</div>
		</div>
			
		</section>
			
		<!-- 4등 상품 정보 없으면 아래꺼 안내 문구가 뜨지 않게 -->
		<!-- 4등의 상품 정보가 있다면 상품정보를 그냥 출력하고  추가로 원판 돌리시 경고창 뜨게 -->
		<c:choose>
			<c:when test="${empty dateInfo }">
				
				<div>
					<!-- 뽑기 -->
					<h2 class="title">4등은 아쉬우니까! 한 번 더 기회를!</h2>	
				</div>
					
				<div class="box-roulette">
				<div class="markers"></div>
				<c:choose>
					<c:when test="${top5People.get(3).commentCreateUserName eq  userName }">
						<button type="button" id="btn-start" value="fourth">
							뽑기 시작
						</button>
					</c:when>
					<c:otherwise>
						<button type="button" id="btn-start" value="NotFourth">
							뽑기 시작
						</button>
					</c:otherwise>
				</c:choose>
				<div class="roulette" id="roulette"></div>
				</div>
				
				<div>
					<h2 class="text-center">4등은 보너스 게임에 참여해서 추가 상품에 도전하세요!</h2>		
				</div>
				
				<!-- 여기아래에 상품 -->
				<div id="fourthProduct" class="text-center" style="font-weight:bold; font-size:40px;">
					
				</div>
					
			</c:when>
			<c:otherwise>
				<div class="text-center">
					<h2> 4등의 보너스 상품 도전 결과는?</h2>
					<h2> 4등 상품은 ${dateInfo } 입니다.</h2>  
				</div>
			</c:otherwise>
			
		</c:choose>
		
		
		<!-- 4등 상품 정보 있으면 아래꺼가 나오지 않게 -->
		<!-- 4등의 상품정보가 없다면 아래꺼로 돌려서 나오는 결과를 삽입해주고 -->
		<!-- 아래 스크립트에서 바로아래 div 안에  태그를 삽입하는문장이 있음. -->
	
		
		<c:import url="/WEB-INF/jsp/include/footer.jsp" />
	
	</div>
	</c:when>
	
	<c:otherwise>
		<div class="d-flex justify-content-center">
			<img src="/static/images/product_image.jpg" width="300" height="300">
		</div>	
			<h2 class="text-center">데이터 값이 부족합니다. 데이터를 더 입력하세요!</h2>
		
	</c:otherwise>
	
	
	</c:choose>
	
	
	
	
	<script>
		
		$(function(){
			
			
			// 슬라이드로 실행할 영역을 변수로 지정
			var $slide = $('#gallery');
			
			var click = 0;
			  
			//실행
			var gal = $slide.slippry({
				// 옵션
				transition: 'fade',  //'kenburns', // 'horizontal',
				speed:1000,
				easing: 'linear'
				
			});
			
			
			// 아래는 뽑기 관련 코드
			  $.fn.extend({
	
			    roulette: function(options) {
	
			      var defaults = {
			        angle: 0,
			        angleOffset: -45,
			        speed: 5000,
			        easing: "easeInOutElastic",
			      };
	
			      var opt = $.extend(defaults, options);
	
			      return this.each(function() {
			        var o = opt;
	
			        var data = [
								{
			            color: '#3f297e',
			            text: '모니터'    // 12
			          },
			          {
			            color: '#1d61ac',
			            text: '가방'  // 11
			          },
			          {
			            color: '#169ed8',
			            text: '신라면'  // 10
			          },
			          {
			            color: '#209b6c',
			            text: '꽝'  // 9
			          },
			          {
			            color: '#60b236',
			            text: '모니터'   // 8
			          },
			          {
			            color: '#efe61f',
			            text: '가방'   // 7
			          },
			          {
			            color: '#f7a416',
			            text: '신라면'   // 6
			          },
			          {
			            color: '#e6471d',
			            text: '꽝'    // 5
			          },
			          {
			            color: '#dc0936',
			            text: '모니터'   // 4
			          },
			          {
			            color: '#e5177b',
			            text: '가방'    // 3
			          },
			          {
			            color: '#be107f',
			            text: '신라면'   // 2
			          },
			          {
			            color: '#881f7e',
			            text: '꽝'    // 1
			          }
			        ];
					
			        var $wrap = $(this);
			        var $btnStart = $wrap.find("#btn-start");
			        var $roulette = $wrap.find(".roulette");
			        var wrapW = $wrap.width();
			        var angle = o.angle;
			        var angleOffset = o.angleOffset;
			        var speed = o.speed;
			        var esing = o.easing;
			        var itemSize = data.length;
			        var itemSelector = "item";
			        var labelSelector = "label";
			        var d = 360 / itemSize;
			        var borderTopWidth = wrapW;
			        var borderRightWidth = tanDeg(d);
	
			        for (i = 1; i <= itemSize; i += 1) {
			          var idx = i - 1;
			          var rt = i * d + angleOffset;
			          var itemHTML = $('<div class="' + itemSelector + '">');
			          var labelHTML = '';
			              labelHTML += '<p class="' + labelSelector + '">';
			              labelHTML += '	<span class="text">' + data[idx].text + '<\/span>';
			              labelHTML += '<\/p>';
	
			          $roulette.append(itemHTML);
			          $roulette.children("." + itemSelector).eq(idx).append(labelHTML);
			          $roulette.children("." + itemSelector).eq(idx).css({
			            "left": wrapW / 2,
			            "top": -wrapW / 2,
			            "border-top-width": borderTopWidth,
			            "border-right-width": borderRightWidth,
			            "border-top-color": data[idx].color,
			            "transform": "rotate(" + rt + "deg)"
			          });
	
			          var textH = parseInt(((2 * Math.PI * wrapW) / d) * .5);
	
			          $roulette.children("." + itemSelector).eq(idx).children("." + labelSelector).css({
			            "height": textH + 'px',
			            "line-height": textH + 'px',
			            "transform": 'translateX(' + (textH * 1.3) + 'px) translateY(' + (wrapW * -.3) + 'px) rotateZ(' + (90 + d * .5) + 'deg)'
			          });
	
			        }
	
			        function tanDeg(deg) {
			          var rad = deg * Math.PI / 180;
			          return wrapW / (1 / Math.tan(rad));
			        }
	
	
			        $btnStart.on("click", function() {
			        	var BtnValue = $(this).val();
			        	
			       		
			        	
			        	if(BtnValue == "NotFourth"){
			        		alert("4등만 참여할 수 있습니다.");
			        		return ;
			        	}
			        	
			        	
		        	  if(click > 0){
						  alert("이미 이벤트에 참여했습니다.");
						  return ;
					  }	
		        	  
			          rotation();
			          
			        });
	
			        function rotation() {
	
			          var completeA = 360 * r(1, 2) + r(0, 360);
					
			          $roulette.rotate({
			            angle: angle,
			            animateTo: completeA,
			            center: ["50%", "50%"],
			            easing: $.easing.esing,
			            callback: function() {
			              var currentA = $(this).getRotateAngle();
							
			              console.log(angle);
			              console.log(completeA);
			              var currentA_value = (currentA % 360 + 15) / (360 / 12);
			              console.log((currentA % 360 + 15) / (360 / 12));
			              
			              currentA_value = Math.floor(currentA_value);
			              
			              console.log(currentA_value);
			              
			              if(currentA_value == 1 || currentA_value == 5 || currentA_value == 9){  // 1, 3, 5, 7 만 꽝으로 설정
			            	  
			            	//$("#fourthProduct").text("4등의 상품은....꽝입니다 ㅎㅎ ㅠㅠ");
			                var fourthProduct = "꽝";
			                
			              }else if(currentA_value == 2 || currentA_value == 6 || currentA_value == 10){
			            	  
			            	 // $("#fourthProduct").text("4등은 신라면 " + "상품을 드릴게요.");
			            	 var fourthProduct = "신라면"; 
			            	 
			              }else if(currentA_value == 3 || currentA_value == 7 || currentA_value == 11){
			            	  
			            	 // $("#fourthProduct").text("4등은 가방 " + "상품을 드릴게요.");
			            	  var fourthProduct = "가방";
			            	  
			              }else{
			            	  
			            	 // $("#fourthProduct").text("4등은 모니터 " + "상품을 드릴게요.");
			            	  var fourthProduct = "모니터";
			              }    
						  
			              click++;
			              
			              var product = fourthProduct;
			              
			              // AJAX 를 통해서 위에 변수를 가져와서 
							
							$.ajax({
								type:"get",
								url:"/post/bonusGame",
								data:{"product":product},
								success:function(data){
									if(data.result == "success"){
										if(product== "꽝"){
											$("#fourthProduct").text("4등의 상품은....꽝입니다 ㅎㅎ ㅠㅠ");
										}else if(product== "모니터"){
											$("#fourthProduct").text("4등은 모니터 " + "상품을 드릴게요.");
										}else if(product== "가방"){
											$("#fourthProduct").text("4등은 가방 " + "상품을 드릴게요.");
										}else{
											$("#fourthProduct").text("4등은 신라면 " + "상품을 드릴게요.");
										}
										//alert("4등 정보 삽입 성공");
										//location.reload();
									}else{
										alert("4등 정보 삽입 실패");
									}
								},
								error:function(e){
									alert("error");
								}
								
							});
						     
			              
			              
			              // 
			              
			            },
			            duration: speed
			          });
			        }
					
			        function r(min, max) {
			          return Math.floor(Math.random() * (max - min + 1)) + min;
			        }
					
			      });
			    }
			  });
			
			
			
			
			
			$(function() {
						
			  $('.box-roulette').roulette();	
	        	
			});

			
			
			
		});
		
	
	</script>

</body>
</html>
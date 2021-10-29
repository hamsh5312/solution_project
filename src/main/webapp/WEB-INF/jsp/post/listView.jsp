<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
     <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>고민 리스트</title>

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
<script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>

<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>

<link rel="stylesheet" href="/static/css/style.css" type="text/css">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.3.0/font/bootstrap-icons.css">

<style>

	.button-box{
		background-color:#00ff80;
		font-weight:bold;
		width:120px;
		border-radius: 25px;
	}
	
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
		
			<div class="d-flex justify-content-center">
				
				<div class="list-box w-75 my-4">
					<h1 class="text-center mt-3">고민 리스트</h1>
					<img src="/static/images/left.jpg" width="80px;" height="80px;">
					<div class="mb-3 d-flex justify-content-end">
						<c:if test="${userId ne null }">
							<button type="button" class="button-box form-control mr-5" onclick="location.href='/post/my_view';">내 고민 보기</button>
						</c:if>
						<select id="categoryBox" name="worry" style="width:100px;">
							<option>선택</option>
							<option value="all" id="allId">전체선택</option>
							<option value="study" id="studyId">공부</option>
							<option value="exercise" id="exerciseId">운동</option>
							<option value="food" id="foodId">음식</option>
							<option value="hobby" id="hobbyId">취미</option>
							<option value="game" id="gameId">놀이</option>
							<option value="startUp" id="startUpId">창업</option>
							<option value="other" id="otherId">기타</option>
							
						</select>
						
					</div>	
					<table class="table text-center">
						<thead>
							<tr>
								<th>No.</th>
								<th>제목</th>
								<th>작성자</th>
							</tr>
						</thead>
						
						<tbody>
						
							<!-- 아래에 forEach 문을 2개 만들고   만약에 어떤 해당 id 가 클릭한다면 그 id에 해당하는 반복문 실행하고 
								 그 id 가 클릭안되면 그냥 다른 반복문 실행  -->
						
							<c:forEach var="worry" items="${worryList }">
							<tr>
								<td>${worry.id }</td>
								<td><a href="/post/detail_view?id=${worry.id }">${worry.subject }</a></td>
								<td>${worry.userName }</td>
							</tr>
							</c:forEach>
						
							
						</tbody>
					</table>
					
					<c:if test="${userLoginId ne null }">
					<div class="text-right pt-3 mb-3">
						<a href="/post/create_view" class="btn btn-info" id="worryWrite">고민쓰기</a>
					</div>
					</c:if>
					
					 <div class="d-flex justify-content-center">
					 
					 	<ul class="btn-group pagination">
					 	
						    <c:if test="${pageMaker.prev }">
							    <li>
							   		<c:choose>
							        	<c:when test="${param.category ne null }">
							        		<a href='<c:url value="/post/list_view?page=${pageMaker.startPage-1 }&category=${param.category }"/>'><i class=" bi bi-arrow-left-circle" style="font-size:25px;"></i></a>
							        	</c:when>
							        	<c:otherwise>
							        		<a href='<c:url value="/post/list_view?page=${pageMaker.startPage-1 }&category=all"/>'><i class=" bi bi-arrow-left-circle" style="font-size:25px;"></i></a>
							        	</c:otherwise>
						        	</c:choose> 
							    </li>
						    </c:if>
						    
						    <c:forEach begin="${pageMaker.startPage }" end="${pageMaker.endPage }" var="pageNum">
							    <li>
							    	<c:choose>
								    	<c:when test="${param.category ne null }">
								    		<a href='<c:url value="/post/list_view?page=${pageNum }&category=${param.category }"/>'><i class="fa ml-3" style="font-size:25px;" >${pageNum }</i></a>
								    	</c:when>
								    	<c:otherwise>
								    		<a href='<c:url value="/post/list_view?page=${pageNum }&category=all"/>'><i class="fa ml-3" style="font-size:25px;" >${pageNum }</i></a>
								    	</c:otherwise>
							    	</c:choose>
							    </li>
						    </c:forEach>
						    
						    <c:if test="${pageMaker.next && pageMaker.endPage >0 }">
							    <li>
						        	 <c:choose>
							        	 <c:when test="${param.category ne null }">
							        	 	<a href='<c:url value="/post/list_view?page=${pageMaker.endPage+1 }&category=${param.category }"/>'><i class="ml-3 bi bi-arrow-right-circle" style="font-size:25px;"></i></a>
							        	 </c:when>
							        	 <c:otherwise>
							        	 	<a href='<c:url value="/post/list_view?page=${pageMaker.endPage+1 }&category=all"/>'><i class="ml-3 bi bi-arrow-right-circle" style="font-size:25px;"></i></a>
							        	 </c:otherwise>
						        	 </c:choose>
							    </li>
						    </c:if>
						    
						</ul>
						
					 </div>
					
					
					
					<!-- 이전 이후 버튼 -->
				 
					 <!--  
						<div class="pt-3 d-flex justify-content-center">
						
						<i class="mr-5 bi bi-arrow-left-circle" style="font-size:25px;"></i>
						
						<i class="bi bi-arrow-right-circle" style="font-size:25px;"></i>
						
					</div>
					 -->
					
				</div>
				
				
			</div>
		</section>
		
		<c:import url="/WEB-INF/jsp/include/footer.jsp" />	
	</div>
	
	
	
	<script>
	
	// 페이지를 이동  주소를 바꿔주는거 location.herf  하나 파라미터를 추가해서 새로요청해서...
	// 페이징 
		$(document).ready(function(){
			
			$("#categoryBox").change(function(){
				var category = $(this).val();
				
				if(category == "all"){
					
					$("#allId").val("all").prop("selected", true);	
				}
				if(category == "study"){
					
					$("#studyId").val("study").prop("selected", true);
				}
				if(category == "exercise"){
					
					$("#exerciseId").val("exercise").prop("selected", true);
				}
				if(category == "food"){
					
					$("#foodId").val("food").prop("selected", true);
				}
				if(category == "game"){
				
					$("#gameId").val("game").prop("selected", true);
				}
				if(category == "other"){
					
					$("#otherId").val("other").prop("selected", true);
				}
				if(category == "hobby"){
					
					$("#hobbyId").val("hobby").prop("selected", true);
				}
				if(category == "startUp"){
					
					$("#startUpId").val("startUp").prop("selected", true);
				}
				
				location.href="/post/list_view?category="+category;
				
			});
		
			
			
		});
		
	
	</script>
	
	

</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
     
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

	<meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>고민 리스트</title>

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
<script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>

<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>

<link rel="stylesheet" href="/static/css/style.css" type="text/css">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.3.0/font/bootstrap-icons.css">

<link
    rel="stylesheet"
    href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css"
  />
  
</head>
<body>

	<div id="wrap">
		<c:import url="/WEB-INF/jsp/include/header.jsp" />
		<hr>
		
		<section>
		
			<div>
				<nav class="mt-1">
				<div id="horizontal-underline"></div>
					<ul class="nav nav-fill">
                    	<li class="nav-item"><a class="nav-link" href="/post/create_view">고민 올리기</a></li>
                        <li class="nav-item"><a class="nav-link" href="/post/list_view">고민 리스트</a></li>
                        <li class="nav-item"><a class="nav-link" href="/post/ranking_view">고민 해결 순위</a></li>
                        <li class="nav-item"><a class="nav-link" href="/post/product_view">이번달 상품 종류</a></li>
             		</ul>
				</nav>
			</div>
			
			<div class="d-flex justify-content-center">
				
				<div class="list-box w-100 my-4">
				
				<!-- url 을 가져오기 위한 변수 설정 -->
				<c:set var="requestPath" value="${requestScope['javax.servlet.forward.request_uri']}"/>
				
					<c:choose>
						<c:when test="${requestPath eq '/post/my_view' }">
							<h1 class="text-center mt-3 now-title">내 고민 보기</h1>
						</c:when>
						
						<c:when test="${requestPath eq '/post/my_like_view' }">
							<h1 class="text-center mt-3 now-title">내 찜 목록</h1>
						</c:when>
						
						<c:otherwise>
							<h1 class="text-center mt-3 now-title">고민 리스트</h1>
						</c:otherwise>
					</c:choose>
					<div class="text-center">
						<img src="/static/images/worryHand.png" width="200px;" height="60px;">
					</div>
					<div class="d-flex mb-1">
						<img src="/static/images/left.jpg" width="80px;" height="80px;">
						<c:if test="${userId ne null }">
							<div class="d-flex align-items-end">
								<a href="/post/my_view" class="button-myBox form-control">내 고민 보기</a>
								<a href="/post/my_like_view" class="button-likeBox form-control ml-2">내 찜 목록</a>
							</div>
						</c:if>
					</div>
					
					<c:if test="${requestPath eq '/post/list_view' }">
						<div class="mb-3 d-flex justify-content-end">
							<form action="/post/list_view">
								<div class="input-group mr-3" style="width:330px;">		
									<input type="text" id="searchId" name="searchInput" value="${param.searchInput }" class="form-control rounded" placeholder="제목이나 작성자를 검색하세요." aria-label="Search"
										aria-describedby="search-addon" />
									<button type="submit" id="searchBtn" class="btn btn-outline-secondary" style="font-weight:bold;">검색</button>
								</div>
							</form>
							
							
							<select id="categoryBox" name="worry" style="width:100px; height:37.68px;">
							
								<c:choose>
									<c:when test="${param.category eq 'all'}">
										<option value="all"  id="allId" selected>전체선택</option>
									</c:when>
									<c:otherwise>
										<option value="all"  id="allId">전체선택</option>
									</c:otherwise>
								</c:choose>
								
								<c:choose>
									<c:when test="${param.category eq 'study'}">
										<option value="study" id="studyId" selected>공부</option>
									</c:when>
									<c:otherwise>
										<option value="study" id="studyId" >공부</option>
									</c:otherwise>
								</c:choose>
								
								<c:choose>
									<c:when test="${param.category eq 'exercise'}">
										<option value="exercise" id="exerciseId" selected>운동</option>
									</c:when>	
									<c:otherwise>
										<option value="exercise" id="exerciseId">운동</option>
									</c:otherwise>
								</c:choose>	
									
								<c:choose>
									<c:when test="${param.category eq 'food'}">
										<option value="food" id="foodId" selected>음식</option>
									</c:when>	
									<c:otherwise>
										<option value="food" id="foodId">음식</option>
									</c:otherwise>
								</c:choose>	
									
								<c:choose>
									<c:when test="${param.category eq 'hobby'}">
										<option value="hobby" id="hobbyId" selected>취미</option>
									</c:when>	
									<c:otherwise>
										<option value="hobby" id="hobbyId">취미</option>
									</c:otherwise>
								</c:choose>	
										
								<c:choose>
									<c:when test="${param.category eq 'game'}">
										<option value="game" id="gameId" selected>놀이</option>
									</c:when>		
									<c:otherwise>
										<option value="game" id="gameId">놀이</option>
									</c:otherwise>
								</c:choose>	
								
								<c:choose>
									<c:when test="${param.category eq 'startUp'}">
										<option value="startUp" id="startUpId" selected>창업</option>
									</c:when>		
									<c:otherwise>
										<option value="startUp" id="startUpId">창업</option>
									</c:otherwise>
								</c:choose>	
										
								<c:choose>
									<c:when test="${param.category eq 'other'}">
										<option value="other" id="otherId" selected>기타</option>
									</c:when>		
									<c:otherwise>
										<option value="other" id="otherId">기타</option>
									</c:otherwise>
								</c:choose>		
											
							</select>
							
							
						</div>	
					</c:if>
						
							<table class="table text-center">
								<thead>
									<tr>
										<th>No.</th>
										<th>제목</th>
										<th>작성자</th>
										<th>조회수</th>
										<th>생성 날짜</th>
									</tr>
								</thead>
								
								<tbody>
								
									<c:forEach var="worry" items="${worryList }">
									<tr>
										<td>${worry.id }</td>
										<td><a href="/post/detail_view?id=${worry.id }">${worry.subject }</a></td>
										<td>${worry.userName }</td>
										<td>${worry.hit }</td>
										<td><fmt:formatDate value="${worry.createdAt }" pattern="yyyy-MM-dd HH:mm:ss" /></td>
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
					 	
						    <c:if test="${param.searchInput eq null }">
						    	
						    	<c:if test="${pageMaker.prev }">
								    <li>
								   		<c:choose>
								        	<c:when test="${param.category ne null }">
								        		<a href='<c:url value="${requestPath }?page=${pageMaker.startPage-1 }&category=${param.category }"/>'><i class="ml-4 fa-2x bi bi-arrow-left-square" style="color:#5F5F5F;"></i></a>
								        	</c:when>
								        	<c:otherwise>
								        		<a href='<c:url value="${requestPath }?page=${pageMaker.startPage-1 }"/>'><i class="ml-4 fa-2x bi bi-arrow-left-square" style="color:#5F5F5F;"></i></a>
								        	</c:otherwise>
							        	</c:choose> 
								    </li>
							    </c:if>
							    
							    <c:forEach begin="${pageMaker.startPage }" end="${pageMaker.endPage }" var="pageNum">
								    <li class="number-position">
								    	<c:choose>
									    	<c:when test="${param.category ne null }">
									    		<a href='<c:url value="${requestPath }?page=${pageNum }&category=${param.category }"/>'><i class="ml-4 fa-2x fa"  style="color:#5F5F5F;">${pageNum }</i></a>
									    	</c:when>
									    	<c:otherwise>
									    		<a href='<c:url value="${requestPath }?page=${pageNum }"/>'><i class="ml-4 fa-2x fa" style="color:#5F5F5F;" >${pageNum }</i></a>
									    	</c:otherwise>
								    	</c:choose>
								    </li>
							    </c:forEach>
							    
							    <c:if test="${pageMaker.next && pageMaker.endPage >0 }">
								    <li>
							        	 <c:choose>
								        	 <c:when test="${param.category ne null }">
								        	 	<a href='<c:url value="${requestPath }?page=${pageMaker.endPage+1 }&category=${param.category }"/>'><i class="ml-4 fa-2x bi bi-arrow-right-square " style="color:#5F5F5F;"></i></a>
								        	 </c:when>
								        	 <c:otherwise>
								        	 	<a href='<c:url value="${requestPath }?page=${pageMaker.endPage+1 }"/>'><i class="ml-4 fa-2x bi bi-arrow-right-square" style="color:#5F5F5F;"></i></a>
								        	 </c:otherwise>
							        	 </c:choose>
								    </li>
							    </c:if>
						    	
						    </c:if>
						    
						    
						    <c:if test="${param.searchInput ne null }">
						    	
						    	<c:if test="${pageMaker.prev }">
							    	<li>
					        			<a href='<c:url value="${requestPath }?page=${pageMaker.startPage-1 }&searchInput=${param.searchInput }"/>'><i class="ml-4 fa-2x bi bi-arrow-left-circle" style="color:#5F5F5F;"></i></a>	        
								    </li>
							    </c:if>
							    <c:forEach begin="${pageMaker.startPage }" end="${pageMaker.endPage }" var="pageNum">
								    <li>
							    		<a href='<c:url value="${requestPath }?page=${pageNum }&searchInput=${param.searchInput }"/>'><i class="ml-4 fa-2x fa" style="color:#5F5F5F;">${pageNum }</i></a>
								    </li>
							    </c:forEach>
							    <c:if test="${pageMaker.next && pageMaker.endPage >0 }">
								    <li>
						        	 	<a href='<c:url value="${requestPath }?page=${pageMaker.endPage+1 }&searchInput=${param.searchInput }"/>'><i class="ml-4 fa-2x bi bi-arrow-right-circle" style="color:#5F5F5F;"></i></a>						        	 
								    </li>
							    </c:if>   
						    
						    </c:if>
						    
						    
						</ul>
						
					 </div>
					
					
					
				</div>
		
			</div>
			
		</section>
		
		<c:import url="/WEB-INF/jsp/include/footer.jsp" />	
	</div>
	
	
	
	<script>
	
	
		$(document).ready(function(){
			
			$("#categoryBox").change(function(){
				var category = $(this).val();
								
				location.href="/post/list_view?category="+category;
				
			});
		
			
			// 메뉴에 나타나는 효과
			let horizontalBar = document.getElementById("horizontal-underline");
			let horizontalMenus = document.querySelectorAll("nav:first-child a");
			
			function horizontalIndicator(e) {
				  horizontalBar.style.left = e.offsetLeft + "px";
				  horizontalBar.style.width = e.offsetWidth + "px";
				  horizontalBar.style.top = e.offsetTop + e.offsetHeight + "px";
			}
			
			horizontalMenus.forEach((menu) =>
			  menu.addEventListener("mousemove", (e) =>
			    horizontalIndicator(e.currentTarget)
			  )
			);

			
			
			
		});
		
	
	</script>
	
	

</body>
</html>

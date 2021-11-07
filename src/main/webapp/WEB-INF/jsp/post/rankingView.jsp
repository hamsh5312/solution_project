<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
     <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
     <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>고민 추천 순위</title>

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
<script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>

<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>

<link rel="stylesheet" href="/static/css/style.css" type="text/css">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.3.0/font/bootstrap-icons.css">

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
				
<<<<<<< HEAD
				
					<c:choose>
					
					<c:when test="${not empty recommendInfoList }">
						<h1 class="text-center mt-3">고민 추천 순위</h1>
						<div class="d-flex align-items-center">
							<img src="/static/images/solutionPic.png" width="80px;" height="80px;">
							<h1 class="pl-4">TOP 5</h1>
						</div>
						<table class="table text-center">
							<thead>
								<tr>
									<th>순위</th>
									<th>고민해결을 위한 한마디!</th>
									<th>작성자</th>
									<th>추천 개수</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="recommendInfo" items="${recommendInfoList }" varStatus="status">
								<tr>
									<td>${status.index + 1}</td>
									<td>
										<c:forEach var="user" items="${userList }">
											<c:if test="${recommendInfo.recommend.commentCreateUserName eq user.name}">
												${user.introduce }
											</c:if>
										</c:forEach>
									</td>
									<td>${recommendInfo.recommend.commentCreateUserName }</td>
									<td>
										${recommendInfo.personTotalRecommend }
									</td>
								</tr>
								</c:forEach>
							</tbody>
						</table>
					</c:when>
					
					<c:otherwise>
						<div class="d-flex justify-content-center">
							<img src="/static/images/rankingPic.jpg" width="300px;" height="300px;">
						</div>
						<h2 class="text-center">순위를 매기기에는 데이터가 부족합니다.</h2>
					</c:otherwise>
					
					</c:choose>
					
					
=======
					<c:choose>
					
					<c:when test="${not empty recommendInfoList }">
					
					<h1 class="text-center mt-3">고민 추천 순위</h1>
					<div class="d-flex align-items-center">
						<img src="/static/images/solutionPic.png" width="80px;" height="80px;">
						<h1 class="pl-4">TOP 5</h1>
					</div>
					<table class="table text-center">
						<thead>
							<tr>
								<th>순위</th>
								<th>고민해결을 위한 한마디!</th>
								<th>작성자</th>
								<th>추천 개수</th>
							</tr>
						</thead>
						
						<tbody>
							<c:forEach var="recommendInfo" items="${recommendInfoList }" varStatus="status">
							
							<tr>
								<td>${status.index + 1}</td>
								<td>
									<c:forEach var="user" items="${userList }">
										<c:if test="${recommendInfo.recommend.commentCreateUserName eq user.name}">
											${user.introduce }
										</c:if>
									</c:forEach>
								</td>
								<td>${recommendInfo.recommend.commentCreateUserName }</td>
								<td>
									${recommendInfo.personTotalRecommend }
								</td>
							</tr>
							
							</c:forEach>
							
							
						</tbody>
					</table>
				</c:when>
				
				<c:otherwise>
					<div class="d-flex justify-content-center">
						<img src="/static/images/rankingPic.jpg" width="300px;" height="300px;">
					</div>
					<h2 class="text-center">순위를 매기기에는 데이터가 부족합니다.</h2>
				</c:otherwise>
				
				</c:choose>
				
>>>>>>> master
				</div>
				
			</div>
			
		</section>
		
		<c:import url="/WEB-INF/jsp/include/footer.jsp" />	
	
	</div>




</body>
</html>
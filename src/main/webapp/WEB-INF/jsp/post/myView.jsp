<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
      <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
     <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>내 고민 목록</title>

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
					<h1 class="text-center mt-3">내 고민 모아보기</h1>
					<img src="/static/images/left.jpg" width="80px;" height="80px;">
					<div class="mb-3 d-flex justify-content-end">
					
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
						
							<c:forEach var="myWorry" items="${myWorryList }">
							<tr>
								<td>${myWorry.id }</td>
								<td><a href="/post/detail_view?id=${myWorry.id }">${myWorry.subject }</a></td>
								<td>${myWorry.userName }</td>
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
					        		<a href='<c:url value="/post/my_view?page=${pageMaker.startPage-1 }"/>'><i class=" bi bi-arrow-left-circle" style="font-size:25px;"></i></a>	        
							    </li>
						    </c:if>
						    <c:forEach begin="${pageMaker.startPage }" end="${pageMaker.endPage }" var="pageNum">
							    <li>
						    		<a href='<c:url value="/post/my_view?page=${pageNum }"/>'><i class="fa ml-3" style="font-size:25px;" >${pageNum }</i></a>
							    </li>
						    </c:forEach>
						    <c:if test="${pageMaker.next && pageMaker.endPage >0 }">
							    <li>
					        	 	<a href='<c:url value="/post/my_view?page=${pageMaker.endPage+1 }"/>'><i class="ml-3 bi bi-arrow-right-circle" style="font-size:25px;"></i></a>						        	 
							    </li>
						    </c:if>   
						</ul>
					 </div>
					
				</div>
				
				
			</div>
		</section>
		
		<c:import url="/WEB-INF/jsp/include/footer.jsp" />	
	</div>

</body>
</html>
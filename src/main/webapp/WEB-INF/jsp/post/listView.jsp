<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
     <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

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
                        <li class="nav-item"><a class="nav-link" href="#">고민 올리기</a></li>
                        <li class="nav-item"><a class="nav-link" href="#">고민 리스트</a></li>
                        <li class="nav-item"><a class="nav-link" href="#">고민 해결 순위</a></li>
                        <li class="nav-item"><a class="nav-link" href="#">이번달 상품 종류</a></li>
                    </ul>
				</nav>
			</div>
		
			<div class="d-flex justify-content-center">
				
				<div class="list-box w-75 my-4">
					<h1 class="text-center mt-3">고민 리스트</h1>
					<img src="/static/images/left.jpg" width="80px;" height="80px;">
					<div class="mb-3 d-flex justify-content-end">
						<select name="worry" style="width:100px;">
							<option value="study">공부</option>
							<option value="exercise">운동</option>
							<option value="food">음식</option>
							<option value="hobby">취미</option>
							<option value="game">놀이</option>
							<option value="startUp">창업</option>
							<option value="other" >기타</option>
							<option selected value="all">전체목록</option>
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
					
					<!-- 이전 이후 버튼 -->
					<div class="pt-3 d-flex justify-content-center">
						<i class="mr-5 bi bi-arrow-left-circle" style="font-size:25px;"></i>
						<i class="bi bi-arrow-right-circle" style="font-size:25px;"></i>
					</div>
					
				</div>
				
				
			</div>
		</section>
		
		<c:import url="/WEB-INF/jsp/include/footer.jsp" />	
	</div>
	
	
	
	<script>
	// 페이지를 이동  주소를 바꿔주는거 location.herf  하나 파라미터를 추가해서 새로요청해서...
	// 페이징 
		
	
	</script>
	
	

</body>
</html>
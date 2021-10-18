<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
     <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
     <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>worryList</title>

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
<script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>

<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>

<link rel="stylesheet" href="/static/css/style.css" type="text/css">

</head>
<body>

	<div id="wrap">
		<c:import url="/WEB-INF/jsp/include/header.jsp" />
		<hr>
		
		<section>
			<div class="d-flex justify-content-center">
				<div class="w-75 my-5">
					<h1 class="text-center">고민 리스트</h1>
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
							<c:forEach var="post" items="${postList }">
							<tr>
								<td>${post.id }</td>
								<td><a href="/post/worry_detail_view?id=${post.id }">${post.subject }</a></td>
								<td>${post.userName }</td>
							</tr>
							</c:forEach>
						</tbody>
					</table>
					<div class="text-right">
						<a href="/post/create_worry_view" class="btn btn-info">고민쓰기</a>
					</div>
				</div>
			</div>
		</section>
		
		<c:import url="/WEB-INF/jsp/include/footer.jsp" />	
	</div>


</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
     <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>고민 상세 보기</title>

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
<script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>

<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>

<link rel="stylesheet" href="/static/css/style.css" type="text/css">

</head>
<body>
		
	<c:import url="/WEB-INF/jsp/include/header.jsp" />
	<hr>
	
	<div id="wrap">
		<section class="d-flex justify-content-center">
			
			<div class="w-75 my-4">
				<div class="d-flex justify-content-between">
					<h1 class="text-center">고민 보기</h1>
					<div>고민종류 쓰기(예:음식)</div>
					<span>유저이름 : ${w_post.userName}</span>
				</div>
				<div class="d-flex my-3">
					<label class="mr-3">제목 : </label>
					<input type="text" class="form-control col-11" id="titleInput" value="${w_post.subject }">
				</div>
				<textarea class="form-control my-3" rows="5" id="contentInput" >${w_post.content }</textarea>
				<img src="${w_post.imagePath }" class="w-75 h-50">
				<div class="d-flex justify-content-between my-3">
					<div>
						<a href="/post/worry_list_view" class="btn btn-info">목록으로</a>
						<button type="button" class="btn btn-danger" id="deleteBtn" data-post-id="${w_post.id }">삭제</button>
					</div>
					<button type="button" class="btn btn-success" id="updateBtn" data-post-id="${w_post.id }">수정</button>
				</div>
			</div>
			
		</section>
	</div>
	
	<c:import url="/WEB-INF/jsp/include/footer.jsp" />	
	
</body>
</html>
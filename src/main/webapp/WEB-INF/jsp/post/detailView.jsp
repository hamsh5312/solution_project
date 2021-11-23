<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
     <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
     <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>고민 상세 보기</title>

<link rel="stylesheet" href="/static/css/style.css" type="text/css">

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
<script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>

<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>

<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.3.0/font/bootstrap-icons.css">

</head>
<body>

	<div id="wrap">
	
		<c:import url="/WEB-INF/jsp/include/header.jsp" />
		<hr>
		
		<section class="d-flex justify-content-center">
			
			<div class="w-75 my-4">
			
				<div class="d-flex">
					
					<h1 class="text-center" id="postInfo" data-postid-id="${postDetail.post.id }">고민</h1>
					<c:if test="${post.userName ne userName }">
						<c:choose>
							<c:when test="${postDetail.like }">
								<div class="d-flex justify-content-start">
									<a href="#" class="likeBtn pt-1" data-post-id="${postDetail.post.id }">
										<i class="bi bi-heart-fill heart-icon text-danger ml-2" style="font-size:25px;"></i>
									</a>
								</div>
							</c:when>
							<c:otherwise>
								<div class="d-flex justify-content-start">
									<a href="#" class="likeBtn pt-1" data-post-id="${postDetail.post.id }">
										<i class="bi bi-heart heart-icon text-dark ml-2" style="font-size:25px;"></i>
									</a>
								</div>
							</c:otherwise>
						</c:choose>
					</c:if>
					
				</div>
				
				<div class="d-flex justify-content-start">
					<h5 class="pt-2"><span class="word-style">고민종류:</span>${post.sBox }</h5>
					<h5 class="pt-2 ml-5"><span class="word-style">게시자:</span>${post.userName}</h5>
					<h5 class="pt-2 ml-5"><span class="word-style">조회수:</span>${post.hit }</h5>
					<h5 class="pt-2 ml-5"><span class="word-style">생성 날짜:</span><fmt:formatDate value="${post.createdAt }" pattern="yyyy-MM-dd HH:mm:ss" /></h5>					
				</div>
			
				<div class="d-flex my-3">
					<label class="mr-3 mt-1"><h5>제목 : </h5></label>
					<input type="text" class="form-control col-11" id="titleInput" value="${post.subject }">
				</div>
				
				<textarea class="form-control my-3" rows="5" id="contentInput" >${post.content }</textarea>
				
				<div class="d-flex justify-content-around align-items-center">
					<img src="/static/images/left.jpg"  class="left-img">
					<img src="${post.imagePath }"  class="emotion-img">
					<img src="/static/images/right.jpg"  class="right-img">
				</div>
				
				<div class="d-flex justify-content-between my-3">
					<div>
						
						<a href="/post/list_view" class="btn btn-info">목록으로</a>
							
						<c:if test="${userName eq post.userName }">
							<button type="button" class="btn btn-danger" id="deleteBtn" data-post-id="${post.id }">삭제</button>
						</c:if>
						
					</div>
					
						<c:if test="${userName eq post.userName }">
							<button type="button" class="btn btn-success" id="updateBtn" data-post-id="${post.id }">수정</button>
						</c:if>
				</div>
				
				<c:if test="${userName ne null }">
				
				<div class="mb-4 input-group d-flex align-items-center">
					<img src="/static/images/comment.jpg" class="comment-img mr-3">
					<input type="text" id="commentInput" class="form-control mt-2"  placeholder="댓글을 입력하세요.">
					<div class="input-group-append mt-2">
						<button type="button" id="commentBtn"class="btn btn-info " data-post-id="${postDetail.post.id }" >댓글 작성</button>
					</div>
				</div>
				</c:if>
				
				
				<c:forEach var="commentDetail" items="${postDetail.commentDetailList }">
				<div class="card border rounded">
					<span><b>${commentDetail.comment.userName }</b> ${commentDetail.comment.content }</span>
					<div class="d-flex justify-content-end">
						
						<c:if test="${commentDetail.comment.userName ne userName }">
							<c:choose>
								<c:when test="${commentDetail.recommend }">
									<a href="#" class="recommendBtn mr-3" data-comment-id="${commentDetail.comment.id }">
										<i class="bi bi-hand-index-thumb-fill text-success" style="font-size:25px;"></i>
									</a>
								</c:when>
								<c:otherwise>
									<a href="#" class="recommendBtn mr-3" data-comment-id="${commentDetail.comment.id }">
										<i class="bi bi-hand-index-thumb text-dark" style="font-size:25px;"></i>
									</a>
								</c:otherwise>
							</c:choose>
						</c:if>
						<span class="mr-2" style="font-size:20px;">추천 ${commentDetail.recommendCount }개</span>
						
					</div>	
				</div>
				</c:forEach>
				
				
		
			</div>
		
		</section>
		
		<c:import url="/WEB-INF/jsp/include/footer.jsp" />
	</div>
	
	<script>
		$(document).ready(function(){
			
			var postInfoId = $("#postInfo").data("postid-id");
			//alert(postInfoId);
			
			$("#deleteBtn").on("click", function() {
				var postId = $(this).data("post-id");
				
				$.ajax({
					type:"get",
					url:"/post/delete",
					data:{"postId":postId},
					success:function(data) {
						if(data.result == "success") {
							location.href="/post/list_view";
						} else if(data.result == "noMatch"){
							alert("게시자만 삭제할 수 있습니다.");
						}else{
							alert("삭제 실패");
						}
					},
					error:function(e) {
						alert("error");
					}
				});
			});
			
			$("#updateBtn").on("click", function(){
				var postId = $(this).data("post-id");
				
				$.ajax({		
					type:"post",
					url:"/post/update",
					data:{"postId":postId, "subject":$("#titleInput").val(), "content":$("#contentInput").val() },
					success:function(data){
						
						if(data.result == "success"){
							alert("수정성공");
						}else{
							alert("작성자만 수정 가능합니다.");
						}
						
					},
					error:function(e){
						alert("error");
					}
					
				});
				
			});
			
			
			$("#commentBtn").on("click", function(){
				
				var content = $("#commentInput").val().trim();
				var postId = $(this).data("post-id");
				
				if(content == null || content == "") {
					alert("댓글 내용을 입력하세요.");
					return ;
				}
				
				$.ajax({
					type:"post",
					url:"/post/comment/create",
					data:{"postId":postId, "content":content},
					success:function(data){
						if(data.result == "success"){
							//alert("댓글 작성 성공");
							//location.reload();
							location.href="/post/detail_view?id=" + postInfoId + "&NotCount=1";
						}else{
							alert("댓글 작성 실패");
						}
					},
					error:function(e){
						alert("error");
					}
					
				});
			});
		


			$(".recommendBtn").on("click", function(e){
				e.preventDefault();
				
				var commentId = $(this).data("comment-id");
				
				$.ajax({
					type:"get",
					url:"/post/recommend",
					data:{"commentId":commentId},
					success:function(data){
						if(data.result == "success"){
							location.href="/post/detail_view?id=" + postInfoId + "&NotCount=1";
							//location.href="/post/detail_view?id=postInfoId";
							//location.reload();
						}else if(data.result == "fail"){
							alert("추천 실패");
						}else{  // data.result == "noLogin"
							alert("로그인한 경우만 추천을 할 수 있습니다.");
						}
					},
					error: function(e){
						alert("error");
					}
					
				});
				
			});
			
			
			$(".likeBtn").on("click", function(e){
				e.preventDefault();
				
				var postId = $(this).data("post-id");
				
				$.ajax({
					type:"get",
					url:"/post/like",
					data:{"postId":postId},
					success:function(data){
						if(data.result == "success"){
							// /post/detail_view?id=4&NotCount=1
							location.href="/post/detail_view?id=" + postInfoId + "&NotCount=1";
							//location.reload();
						}else if(data.result == "fail"){
							alert("좋아요 실패");
						}else{  // data.result == "noLogin"
							alert("로그인한 경우만 좋아요를 할 수 있습니다.");
						}
					},
					error: function(e){
						alert("error");
					}
					
				});
				
			});
			
			
			
		});
	
	
	</script>
	
	
	
</body>
</html>
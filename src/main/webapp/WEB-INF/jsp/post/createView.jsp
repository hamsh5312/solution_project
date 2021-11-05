<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
     <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
     <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>고민 입력</title>

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
		
		<section class="d-flex justify-content-center">
			<div class="w-75 my-4">
				<h1 class="text-center">고민 작성</h1>
				
				<div class="d-flex justify-content-center my-3">
					<label class="mr-3 mt-2"><h5>제목 : </h5></label>
					<input type="text" class="form-control col-10" id="titleInput">
				</div>
				<textarea class="form-control my-3" rows="7" id="contentInput"></textarea>
				<!-- MIME text/html image/jpeg -->
				<div class="d-flex justify-content-between my-3">
					<input type="file" accept="image/*" id="fileInput" multiple>
					<select name="worry" style="width:100px;">
						<option value="study">공부</option>
						<option value="exercise">운동</option>
						<option value="food">음식</option>
						<option value="hobby">취미</option>
						<option value="game">놀이</option>
						<option value="startUp">창업</option>
						<option value="other" selected>기타</option>
						
					</select>
				</div>
				<div class="d-flex justify-content-between my-3">
					<a href="/post/list_view" class="btn btn-info">목록으로</a>
					<button type="button" class="btn btn-success" id="saveBtn" style="width:80px;">저장</button>
				</div>
			</div>
		</section>
		
		<c:import url="/WEB-INF/jsp/include/footer.jsp" />
		
	</div>

	<script>
	
		$(document).ready(function(){
			
			$("#saveBtn").on("click", function(){
				
				var title = $("#titleInput").val();
				var content = $("#contentInput").val().trim();
				var sBox = $('select[name="worry"]').val(); 
				
				if(title == null || title == ""){
					alert("제목을 입력하세요.");
					return ;
				}
				
				if(content == null || content == ""){
					alert("내용을 입력하세요.");
					return ;
				}
				
				// 파일이 무조건 있어야한다고 생각하고 설계했을때, 유효성검사하기
				if($("#fileInput")[0].files.length == 0) {
					alert("파일을 추가하세요");
					return ;
				}	
				
				if(sBox == "all"){
					alert("고민 종류를 선택하세요.");
					return ;
				}
				
				
				var formData = new FormData();
				formData.append("subject", title);
				formData.append("content", content);
				formData.append("file", $("#fileInput")[0].files[0]);
				formData.append("sBox", sBox);
				
				// enctype 은  인코딩 타입
				$.ajax({
					enctype:"multipart/form-data",   // 파일 업로드 필수
					processData:false,    //  파일 업로드 필수  
					contentType:false,    //  파일 업로드 필수 
					type:"post",
					url:"/post/worry_create",
					data:formData,
					success:function(data){
						if(data.result == "success"){
							location.href="/post/list_view";
						}else if(data.result == "noUserId"){
							alert("로그인해야 합니다.");
						}else{
							alert("삽입실패");
						}
						
					},
					error:function(e){
						alert("error");
					}
					
				});		
				
			});
				
			
			$(".commentBtn").on("click", function(){
				// 지금 이벤트가 발생한 객체
				// 클릭된 버튼 객체
				var postId = $(this).data("post-id");
				
				//alert(postId);
				//대응되는 input 의 value
				// ex) postId = 5;
				//  "#commentInput-5"
				var content = $("#commentInput-" + postId).val();
				
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
							location.reload();
						}else{
							alert("댓글 작성 실패");
						}
					},
					error:function(e){
						alert("error");
					}
					
				});
			});
			
		
			
		});
	
	</script>
	

</body>
</html>
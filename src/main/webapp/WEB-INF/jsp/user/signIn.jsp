<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
      
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>

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
			<div class="login-box my-4">
				<img src="/static/images/loginPic1.jpg" class="login-img">
				<div class="mt-3">
					<form id="loginForm">
						<input type="text" id="loginIdInput" class="form-control" placeholder="아이디를 입력하세요.">
						<input type="password" id="passwordInput" class="form-control mt-3" placeholder="비밀번호를 입력하세요.">
						<button id="loginBtn" type="submit" class="btn btn-dark btn-block mt-3" >로그인</button>
					</form>
					<div class="d-flex justify-content-center mt-2">
						<span class="mt-2">비밀번호를 잊으셨나요?</span>
					</div>
				</div>
				<div class="text-center mt-2">
					<a href="/user/signup_view" style="text-decoration-line:none;"><input type="submit" class="btn btn-secondary btn-block mt-3" value="가입하기"></a>
				</div>
			</div>
		</section>
		
		<c:import url="/WEB-INF/jsp/include/footer.jsp" />	
		
	</div>
	
	
	<script>
	
	
		$(document).ready(function(){
			
			$("#loginForm").on("submit",function(e){
				
				e.preventDefault();
				
				var loginId = $("#loginIdInput").val();
				var password = $("#passwordInput").val();
				
				if(loginId == null || loginId == ""){
					alert("아이디를 입력하세요.");
					return;
				}
				
				if(password == null || password == ""){
					alert("패스워드를 입력하세요.");
					return;
				}
				
				$.ajax({
					type:"post",
					url:"/user/sign_in",
					data:{"loginId":loginId, "password":password},
					success:function(data){
						if(data.result == "success"){
							
							location.href="/post/list_view";
							
						}else{
							alert("아이디와 비밀번호를 확인해주세요");
						}
						
					},
					error:function(e){
						alert("로그인실패");
					}
					
				});
				
			});
			
		});
	
	</script>
	

</body>
</html>
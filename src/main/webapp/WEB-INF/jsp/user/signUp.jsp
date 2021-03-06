<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>

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
			<div class="join-box">
				
				<form id="signUpForm">
					<h4 class="text-center pt-3" style="font-weight:bold;">회원가입</h4>
					
					<div class="d-flex">	
						<input type="text" id="loginIdInput" class="form-control mt-3 mr-3" placeholder="아이디를 입력하세요.">
						<button type="button" id="isDuplicateBtn" style="width:100px;" class="btn btn-primary btn-block mt-3" >중복확인</button>		
					</div>
					<div id="duplicateDiv" class="d-none"><small class="text-danger">중복된 ID 입니다.</small></div>
					<div id="noneDuplicateDiv" class="d-none"><small class="text-success">사용 가능한 ID 입니다.</small></div>
						
					<input type="password" id="passwordInput" class="form-control mt-3" placeholder="비밀번호를 입력하세요.">
					<input type="password" id="passwordConfirmInput" class="form-control mt-3" placeholder="비밀번호 확인">
					<small id="errorPassword" class="text-danger d-none">비밀번호가 일치하지 않습니다.</small>
					<small id="correctPassword" class="text-success d-none">비밀번호가 일치합니다.</small>
					
					<div class="d-flex">
						<input type="text" id="nameInput" class="form-control mt-3 mr-3" placeholder="닉네임">
						<button type="button" id="isNameDuplicateBtn" style="width:100px;" class="btn btn-primary btn-block mt-3">중복확인</button>
					</div>
					<div id="duplicateNameDiv" class="d-none"><small class="text-danger">중복된 닉네임 입니다.</small></div>
					<div id="noneDuplicateNameDiv" class="d-none"><small class="text-success">사용 가능한 닉네임 입니다.</small></div>	
					
					<input type="text" id="emailInput" class="form-control mt-3" placeholder="이메일">
					<input type="text" id="introduceInput" class="form-control mt-3" placeholder="자기 소개">
					
					<button type="submit" id="signUpBtn" class="btn btn-info btn-block mt-3" >회원가입</button>
				</form>
					
				<div class="d-flex justify-content-between align-items-center mt-3">
					<div class="ml-3">
						<span>계정이 있으신가요?</span>
					</div>
					<div class="mr-3">
						<a href="/user/signin_view" style="text-decoration-line:none;"><input type="submit" style="height:40px;" class="btn btn-info btn-block" value="로그인"></a>
					</div>
				</div>
			
			</div>
		</section>
		
		<c:import url="/WEB-INF/jsp/include/footer.jsp" />	
	
	</div>
	
	<script type="text/javascript">
		$(document).ready(function() {
		
				
			// 실시간 비밀번호 확인
			$("#passwordInput").on("input", function() {
				var passwordStatus = $("#passwordInput").val();
				var passwordConfirmInput = $("#passwordConfirmInput").val();
				
				if(passwordStatus == passwordConfirmInput){
					$("#errorPassword").addClass("d-none");
					$("#correctPassword").removeClass("d-none");
				}else{
					$("#correctPassword").addClass("d-none");
					$("#errorPassword").removeClass("d-none");
				}
				
			});
			
			// 실시간 비밀번호 확인
			$("#passwordConfirmInput").on("input", function() {
				var passwordStatus = $("#passwordInput").val();
				var passwordConfirmInput = $("#passwordConfirmInput").val();
				
				if(passwordStatus == passwordConfirmInput){
					$("#errorPassword").addClass("d-none");
					$("#correctPassword").removeClass("d-none");
				}else{
					$("#correctPassword").addClass("d-none");
					$("#errorPassword").removeClass("d-none");
				}
				
			});
			
			
			var isIdCheck = false;
			var isDuplicateId = true;
			
			var isNameCheck = false;
			var isDuplicateName = true;
			
			// 아이디에 입력이 있을경우 중복체크 상태를 초기화 한다
			$("#loginIdInput").on("input", function() {
				$("#duplicateDiv").addClass("d-none");
				$("#noneDuplicateDiv").addClass("d-none");
				isIdCheck = false;
				isDuplicateId = true;
			});
				
			
			// 닉네임에 입력이 있을경우 중복체크 상태를 초기화 한다
			$("#nameInput").on("input", function() {
				$("#duplicateNameDiv").addClass("d-none");
				$("#noneDuplicateNameDiv").addClass("d-none");
				isNameCheck = false;
				isDuplicateName = true;
			});
			
			
			$("#signUpForm").on("submit", function(e) {
				
				e.preventDefault();
				
				var loginId = $("#loginIdInput").val();
				var password = $("#passwordInput").val();
				var passwordConfirm = $("#passwordConfirmInput").val();
				var name = $("#nameInput").val().trim();
				var email = $("#emailInput").val().trim();
				var introduce = $("#introduceInput").val().trim();
				
				if(loginId == null || loginId == "") {
					alert("아이디를 입력하세요");
					return ;
				}
				
				if(password == null || password == "") {
					alert("비밀번호를 입력하세요");
					return ;
				}
				
				if(passwordConfirm == null || passwordConfirm == ""){
					alert("비밀번호를 입력하세요.");
					return;
				}
				
				if(password != passwordConfirm) {
					alert("비밀번호가 일치하지 않습니다.");
					return ;
				}
				
				if(name == null || name == "") {
					alert("이름을 입력하세요");
					return ;
				}
				
				if(email == null || email == "") {
					alert("이메일을 입력하세요");
					return ;
				}
				
				if(introduce == null || introduce == "") {
					alert("자기소개를 입력하세요");
					return ;
				}
				
				// id 중복체크 했는지?
				if(isIdCheck == false) {
					alert("아이디 중복체크를 진행하세요");
					return ;
				}
						
				// id 중복이 되었는지 안되었는지?
				if(isDuplicateId == true) {
					alert("아이디가 중복되었습니다.");
					return ;
				}
				
				// 닉네임 중복체크 했는지?
				if(isNameCheck == false) {
					alert("닉네임 중복체크를 진행하세요");
					return ;
				}
				
				// 닉네임 중복이 되었는지 안되었는지?
				if(isDuplicateName == true) {
					alert("닉네임이 중복되었습니다.");
					return ;
				}
				
				
				$.ajax({
					type:"post",
					url:"/user/sign_up",
					data:{"loginId":loginId, "password":password, "name":name, "email":email, "introduce":introduce},
					success:function(data) {
						
						if(data.result == "success") {
							location.href="/user/signin_view";
							
						} else {
							alert("회원 가입 실패");
						}
						
					}, 
					error:function(e) {
						alert("error");
					}
				});
			});
			
			
			// id 중복확인 버튼
			$("#isDuplicateBtn").on("click", function() {
				var loginId = $("#loginIdInput").val();
				
				if(loginId == null || loginId == "") {
					alert("아이디를 입력하세요");
					return ;
				}
				
				$.ajax({
					type:"get",
					url:"/user/is_duplicate_id",
					data:{"loginId":loginId},
					success:function(data) {
						
						isIdCheck = true;
						
						if(data.is_duplicate) {
							isDuplicateId = true;
							$("#duplicateDiv").removeClass("d-none");
							$("#noneDuplicateDiv").addClass("d-none");
						} else {
							isDuplicateId = false;
							$("#duplicateDiv").addClass("d-none");
							$("#noneDuplicateDiv").removeClass("d-none");
						}
						
						
					},
					error:function(e){
						alert("중복확인 실패");
					}
					
					
				});
			});
			
			
			
			// 닉네임 중복확인 버튼
			$("#isNameDuplicateBtn").on("click", function() {
				var name = $("#nameInput").val();
				
				if(name == null || name == "") {
					alert("닉네임을 입력하세요");
					return ;
				}
				
				$.ajax({
					type:"get",
					url:"/user/is_duplicate_name",
					data:{"name":name},
					success:function(data) {
						
						isNameCheck = true;
						
						if(data.is_duplicate) {
							isDuplicateName = true;
							$("#duplicateNameDiv").removeClass("d-none");
							$("#noneDuplicateNameDiv").addClass("d-none");
						} else {
							isDuplicateName = false;
							$("#duplicateNameDiv").addClass("d-none");
							$("#noneDuplicateNameDiv").removeClass("d-none");
						}
						
						
					},
					error:function(e){
						alert("중복확인 실패");
					}
					
					
				});
			});
			
			
			
	
		});
		
	</script>
	
	
</body>
</html>
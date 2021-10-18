<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 


    <header class="d-flex pt-2">
    
    	<div class="header-left">
    	
    	</div>
    	
		<div class="header-center d-flex justify-content-center align-items-center">
			<img src="/static/images/headerPic.jpg" width="70px;" height="70px;">
			<div class="display-4 pl-3" style="font-weight:bolder; font-family:cursive;">
				고 해
			</div>
		</div>
		
		<div class="header-right">
			<c:if test="${not empty userName }" >
				<div class="text-dark mt-4 mr-3">
					${userName } 님 <a href="/user/sign_out">[로그아웃] </a>
				</div>
			</c:if>
		</div>
		
	</header>
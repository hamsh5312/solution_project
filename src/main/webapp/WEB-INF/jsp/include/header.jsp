<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

    <header class="d-flex pt-2">
    
    	<div class="header-left">
    	
    	</div>
		    	
		<div class="header-center d-flex justify-content-center align-items-center">
			<a href="/post/list_view"><img src="/static/images/headerPic.jpg" width="70px;" height="70px;"></a>
			<div class="display-4 pl-3" style="font-weight:bolder; font-family:Monospace;">
				고해
			</div>
		</div>
		
		<div class="header-right">
			<c:choose>
				<c:when test = "${not empty userName }">	
					<div class="text-dark mt-4">
						<span>${userName }님 안녕하세요.</span>
					</div>
					<a href="/user/sign_out">[log-out]</a>
				</c:when>
				<c:otherwise>
					<div class="text-dark d-flex justify-content-center mt-3 pt-1">
						<a href="/user/signin_view">[로그인 하기] </a>
					</div>
				</c:otherwise>
			</c:choose>
			
		</div>
		
	</header>
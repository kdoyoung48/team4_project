<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>  
<!-------------navbar 네비바------------->
<nav class="navbar navbar-expand-lg navbar-dark ftco_navbar bg-dark ftco-navbar-light site-navbar-target" id="ftco-navbar">
	<div class="container">
		<!-- 상단 왼쪽 로고 타이틀 -->
		<a class="navbar-brand" href="${pageContext.request.contextPath }/">TRIBUS</a>
			<!-- menu(메뉴) 버튼 상단 -->
			<button class="navbar-toggler js-fh5co-nav-toggle fh5co-nav-toggle" type="button" data-toggle="collapse" 
				data-target="#ftco-nav" aria-controls="ftco-nav" aria-expanded="false" aria-label="Toggle navigation">
				 <span class="oi oi-menu"></span>Menu
			</button>
		
		<!-- 네비바 메뉴 -->
		<div class="collapse navbar-collapse" id="ftco-nav">
			<ul class="navbar-nav nav ml-auto">
				<li class="nav-item"><a href="${pageContext.request.contextPath }/" class="nav-link"><span>Home</span></a></li>
				<li class="nav-item"><a href="#about-section" class="nav-link"><span>about</span></a></li>
				<li class="nav-item"><a href="#contents-section" class="nav-link"><span>contents</span></a></li>
				<li class="nav-item"><a href="#Reservation-section" class="nav-link"><span>Reservation</span></a></li>
				<li class="nav-item"><a href="#service-section" class="nav-link"><span>service</span></a></li>
				<li class="nav-item"><a href="#" class="btn btn-primary px-5 py-8 mt-1" style="width:160px; height: 40px; text-align: center;" >Login</a></li>
				<li class="nav-item"><a href="#" class="btn btn-white px-5 py-8 mt-1" style="width:160px; height: 40px; text-align: center;">Sign up</a></li>
			</ul>
		</div>
	</div><!-- div container -->
</nav><!-- navbar -->


<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>   
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<title>Gallery</title>
<!------------- css 영역------------->  
<jsp:include page="../include/resource.jsp"></jsp:include>
<!-- css  -->

<style>	
	/*한글 폰트 적용 (사용법 id="font_1")*/
	#font_1{
		font-family: 'Noto Sans KR', sans-serif;
	}
	/*보이는 이미지 사이즈  가운데 정렬*/
	.img{
		height: 250px;
		text-align: center;
	}			
</style>
</head>
<!-------------body 바디 영역 ------------->
<body data-spy="scroll" data-target=".site-navbar-target" data-offset="300">


<!-------------navbar 네비바------------->
<jsp:include page="../include/navbar.jsp"></jsp:include>

<!-------------contents1 컨텐츠 유료 ------------->
<section class="ftco-section" id="contents-section">
  	<div class="container">
		<!---- 제목 부분 ---->
		<div class="row justify-content-center pb-5">
			<div class="col-md-12 heading-section text-center ftco-animate">
				<!--대분류-->
				<span class="subheading">contents</span>
				<!--소분류 영어-->
				<h2 class="mb-4"><a href="${pageContext.request.contextPath }/gallery/list.do">Gallery</a></h2>
				<!--소분류 한글 -->
				<p id="font_1">갤러리</p>
				<!-- 버튼 -->
				
				<a id="font_1" href="${pageContext.request.contextPath }/gallery/private/ajax_form.do" class="btn btn-primary px-5 py-8 mt-1"> Image upload</a>				
			</div>
		</div>	
		<div class="row">	
			<!-- 반복문 돌면서 사진 목록 출력 -->
			<c:forEach var="tmp" items="${list }">
				<!---- POST ---->
				<div class="col-md-6 col-lg-4 ftco-animate">
					<div class="project">
						<!-- 이미지1 -->
						<div class="img">
							<a href="detail.do?num=${tmp.num }">
								<img src="${pageContext.request.contextPath }${tmp.imagePath}" 
									class="img-fluid" alt="Colorlib Template">
							</a>
						</div>
						<!-- 텍스트 -->
						<div class="text">
							<h4 class="price">${tmp.writer }</h4>
							<span id="font_1">${tmp.regdate }"</span>
							<h3 id="font_1"><a href="hotel.html">${tmp.caption }</a></h3>
	
						</div>
						<!-- 이미지1-1 -->
						<a href="${pageContext.request.contextPath }${tmp.imagePath}" 
							class="icon image-popup d-flex justify-content-center align-items-center">
							<!--이미지 오른쪽 상단 확대 아이콘2-->
							<span class="icon-expand"></span>
						</a>
					</div><!--project -->
				</div><!--POST -->
			</c:forEach>			
		</div><!--row -->
		<!-- 페이징 처리 -->
		<div class="row mt-5">	
			<div class="col text-center">
				<div class="block-27">
					<ul>
						<c:choose>
							<c:when test="${startPageNum ne 1 }">
								<li>
									<a href="${pageContext.request.contextPath }/gallery/list.do?pageNum=${startPageNum-1 }">&lt;</a>
								</li>
							</c:when>
						<c:otherwise>
							<li>
								<a href="javascript:">&lt;</a>
							</li>
						</c:otherwise>
						</c:choose>
						
						<c:forEach var="i" begin="${startPageNum }" end="${endPageNum }">
							<c:choose>
								<c:when test="${i eq pageNum }">
									<li class="active">
										<a href="${pageContext.request.contextPath }/gallery/list.do?pageNum=${i }">${i }</a>
									</li>
								</c:when>
								<c:otherwise>
									<li>
										<a href="${pageContext.request.contextPath }/gallery/list.do?pageNum=${i }">${i }</a>
									</li>
								</c:otherwise>
							</c:choose>
						</c:forEach>
						
						<c:choose>
							<c:when test="${endPageNum lt totalPageCount }">						
								<li>
									<a href="${pageContext.request.contextPath }/gallery/list.do?pageNum=${endPageNum+1 }">&gt;</a>
								</li>
							</c:when>
							<c:otherwise>
								<li>
									<a href="javascript:">&gt;</a>
								</li>
							</c:otherwise>
						</c:choose>
					</ul>
				</div>
			</div>
		</div><!-- 페이징처리 -->
	</div><!--container -->	  	
</section><!-- contents1 섹션-->
    			
<!------------- footer ------------->    
<jsp:include page="../include/footer.jsp"></jsp:include>


<!-------------script 스크립트------------->
<jsp:include page="../include/resource_script.jsp"></jsp:include> 

</body>
</html>
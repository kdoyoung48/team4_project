<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%> 
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>WithBoard Post</title>
<jsp:include page="../include/resource.jsp"></jsp:include>
<script src="${pageContext.request.contextPath }/resources/js/jquery-3.5.1.js"></script>
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
	/* 글 내용을 출력할 div 에 적용할 css */
	.contents{
		width: 100%;
		border: 1px solid #f2f2f2; 
	}
	/* 댓글 프로필 이미지를 작은 원형으로 만든다. */
	.profile-image{
		width: 50px;
		height: 50px;
		border: 1px solid #cecece;
		border-radius: 50%;
	}
	/* ul 요소의 기본 스타일 제거 */
	.comments ul{
		padding: 0;
		margin: 0;
		list-style-type: none;
	}
	.comments dt{
		margin-top: 5px;
	}
	.comments dd{
		margin-left: 50px;
	}
	.comment-form textarea, .comment-form button{
		float: left;
		
	}
	.comments li{
		clear: left;
	}
	.comments ul li{
		border-top: 1px solid #f2f2f2;
	}
	.comment-form textarea{
		width: 80%;
		height: 50px;
		border: 1px solid #cecece;
		
	}
	.comment-form button{
		width: 15%;
		height: 50px;
	}
	/* 댓글에 댓글을 다는 폼과 수정폼은 일단 숨긴다. */
	.comments .comment-form{
		display: none;
	}
	/* .reply_icon 을 li 요소를 기준으로 배치 하기 */
	.comments li{
		position: relative;
	}
	.comments .reply-icon{
		position: absolute;
		top: 1em;
		left: 1em;
		color: red;
	}
	pre {
	  display: block;
	  padding: 9.5px;
	  margin: 0 0 10px;
	  font-size: 13px;
	  line-height: 1.42857143;
	  color: #333333;
	  word-break: break-all;
	  word-wrap: break-word;
	  background-color: #f5f5f5;
	  border: 1px solid #f2f2f2;
	  border-radius: 4px;
	}
	/* 글 내용중에 이미지가 있으면 최대 폭을 100%로 제한하기 */
	.contents img{
		max-width: 100%;
	}
	.loader{
		position: fixed; /* 좌하단 고정된 위치에 배치 하기 위해 */
		width: 100%;
		left: 0;
		bottom: 0;
		text-align: center; /* 이미지를 좌우로 가운데  정렬 */
		z-index: 1000;
		display: none; /* 일단 숨겨 놓기 */
	}	
</style>	
</head>
<!-------------body 바디 영역 ------------->
<body data-spy="scroll" data-target=".site-navbar-target" data-offset="300">

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
				<h2 class="mb-4"><a href="${pageContext.request.contextPath }/withboard/list.do">withboard</a></h2>
				<!--소분류 한글 -->
				<p id="font_1">동행게시판</p>
				<!--수정,삭제 버튼  -->
				<!-- 아이디가 같으면 수정or삭제 -->
				<c:if test="${dto.writer eq id }">
					<a id="font_1" href="private/updateform.do?num=${dto.num}" class="btn btn-primary px-5 py-8 mt-1"> Update Post</a>	
					<a id="font_1" href="javascript:deleteConfirm()" class="btn btn px-5 py-8 mt-1"> Delete Post</a>							
				</c:if>
			</div>
		</div>	

		<!-- Post 메인 -->		
		<div id="font_1" class="row">			
			<!-- 사이드 컨텐츠 메뉴바 Side bar Contents Categories  -->
			<div class="col-lg-3 sidebar ftco-animate">
				<div class="sidebar-box ftco-animate">
					<h3 class="heading-sidebar">Contents Categories</h3>
					<ul class="categories">
						<li><a href="#">Review</a></li>
						<li><a href="${pageContext.request.contextPath }/withboard/list.do">With Us</a></li>
						<li><a href="${pageContext.request.contextPath }/freeboard/list.do">withboard</a></li>
						<li><a href="${pageContext.request.contextPath }/gallery/list.do">Gallery</a></li>
					</ul>
				</div>
			</div>	

			<div class="col-lg-8 ftco-animate">
			<!-- 글 제목 -->
			<h2 id="font_1" class="mb-3" style="text-align: center;">${dto.title }</h2>			            
				<div class="about-author d-flex p-6 bg-light">
					<table id="font_1" class="board_list">
						<thead>
							<tr>
								<th>${dto.category }</th>
								<th>ID: ${dto.writer }</th>
								<th>${dto.regdate }</th>
								<th>VEIW: ${dto.viewCount }</th>
							</tr>
						</thead>					
					</table>			
				</div>
	            <!-- 컨텐츠 내용 -->
	            <p>${dto.content } </p>
			</div> 	
		</div><!-- row -->	
		<br>
		<h3 class="mb-3" style="border-bottom: 1px solid #f2f2f2;">Comments</h3>
		<!--댓글 form -->
		<form class="comment-form insert-form" action="private/comment_insert.do" method="post">					
			<input type="hidden" name="ref_group" value="${dto.num }"/>		
			<input type="hidden" name="target_id" value="${dto.writer }"/>
			<textarea name="content"><c:if test="${empty id }">로그인이 필요합니다</c:if></textarea>
			<button class="btn btn-primary" type="submit">등록</button>
		</form>		
		<!-- 댓글 목록 -->
		<div class="comments" style="border-bottom: 1px solid #f2f2f2;">
			<ul>
				<c:forEach var="tmp" items="${commentList }">
					<c:choose>
						<c:when test="${tmp.deleted eq 'yes' }">
							<li>삭제된 댓글 입니다.</li>
						</c:when>
						<c:otherwise>
							<li id="comment${tmp.num }" <c:if test="${tmp.num ne tmp.comment_group }">style="padding-left:50px;"</c:if>>
								<c:if test="${tmp.num ne tmp.comment_group }"><svg class="reply-icon" width="1em" height="1em" viewBox="0 0 16 16" class="bi bi-arrow-return-right" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
			  						<path fill-rule="evenodd" d="M10.146 5.646a.5.5 0 0 1 .708 0l3 3a.5.5 0 0 1 0 .708l-3 3a.5.5 0 0 1-.708-.708L12.793 9l-2.647-2.646a.5.5 0 0 1 0-.708z"/>
			  						<path fill-rule="evenodd" d="M3 2.5a.5.5 0 0 0-.5.5v4A2.5 2.5 0 0 0 5 9.5h8.5a.5.5 0 0 0 0-1H5A1.5 1.5 0 0 1 3.5 7V3a.5.5 0 0 0-.5-.5z"/></svg>
								</c:if>
								<dl>
									<dt>
										<c:choose>
											<c:when test="${empty tmp.profile }">
												<svg class="profile-image"  width="1em" height="1em" viewBox="0 0 16 16" class="bi bi-person-fill" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
						  							<path fill-rule="evenodd" d="M3 14s-1 0-1-1 1-4 6-4 6 3 6 4-1 1-1 1H3zm5-6a3 3 0 1 0 0-6 3 3 0 0 0 0 6z"/>
												</svg>
											</c:when>
											<c:otherwise>
												<img class="profile-image" 
													src="${pageContext.request.contextPath }${tmp.profile }"/>
											</c:otherwise>
										</c:choose>
										<span>${tmp.writer }</span>
										<c:if test="${tmp.num ne tmp.comment_group }">
											@<i>${tmp.target_id }</i>
										</c:if>
										<span>${tmp.regdate }</span>
										<a data-num="${tmp.num }" href="javascript:" class="reply-link">Reply</a>
										<c:if test="${tmp.writer eq id }">
											| <a data-num="${tmp.num }" href="javascript:" class="comment-update-link">Update</a>
											| <a data-num="${tmp.num }" href="javascript:" class="comment-delete-link">Delete</a>
										</c:if>
									</dt>
									<dd>
										<pre>${tmp.content }</pre>
									</dd>
								</dl>
								<form class="comment-form re-insert-form" 
									action="private/comment_insert.do" method="post">
									<input type="hidden" name="ref_group"
										value="${dto.num }"/>
									<input type="hidden" name="target_id"
										value="${tmp.writer }"/>
									<input type="hidden" name="comment_group"
										value="${tmp.comment_group }"/>
									<textarea name="content"></textarea>
									<button class="btn btn-primary" type="submit">등록</button>
								</form>
								<!-- 로그인된 아이디와 댓글의 작성자가 같으면 수정 폼 출력 -->
								<c:if test="${tmp.writer eq id }">
									<form class="comment-form update-form" 
										action="private/comment_update.do" method="post">
										<input type="hidden" name="num" value="${tmp.num }"/>
										<textarea name="content">${tmp.content }</textarea>
										<button class="btn btn-primary" type="submit">수정</button>
									</form>
								</c:if>
							</li>						
						</c:otherwise>
					</c:choose>
				</c:forEach>
			</ul>
		</div><!-- 댓글목록 -->	

	</div><!--container -->	  	
</section><!-- contents1 섹션-->
<div class="loader">
	<img src="${pageContext.request.contextPath }/resources/images/ajax-loader.gif"/>
</div>
<!------------- footer ------------->    
<jsp:include page="../include/footer.jsp"></jsp:include>
<script src="${pageContext.request.contextPath }/resources/js/jquery.form.min.js"></script>

<script>
	//댓글 수정 링크를 눌렀을때 호출되는 함수 등록
	$(document).on("click",".comment-update-link", function(){
		/*
			click 이벤트가 일어난 댓글 수정 링크에 저장된 data-num 속성의 값을 
			읽어와서 id 선택자를 구성한다.
		*/
		var selector="#comment"+$(this).attr("data-num");
		//구성된 id  선택자를 이용해서 원하는 li 요소에서 .update-form 을 찾아서 동작하기
		$(selector)
		.find(".update-form")
		.slideToggle();
	});
	//로딩한 jquery.form.min.js jquery플러그인의 기능을 이용해서 댓글 수정폼을 
	//ajax 요청을 통해 전송하고 응답받기
	$(document).on("submit", ".update-form", function(){
		//이벤트가 일어난 폼을 ajax로 전송되도록 하고 
		$(this).ajaxSubmit(function(data){
			//console.log(data);
			//수정이 일어난 댓글의 li 요소를 선택해서 원하는 작업을 한다.
			var selector="#comment"+data.num; //"#comment6" 형식의 선택자 구성
			
			//댓글 수정 폼을 안보이게 한다. 
			$(selector).find(".update-form").slideUp();
			//pre 요소에 출력된 내용 수정하기
			$(selector).find("pre").text(data.content);
		});
		//폼 전송을 막아준다.
		return false;
	});
	
	$(document).on("click",".comment-delete-link", function(){
		//삭제할 글번호 
		var num=$(this).attr("data-num");
		var isDelete=confirm("댓글을 삭제 하시겠습니까?");
		if(isDelete){
			location.href="${pageContext.request.contextPath }"+
			"/withboard/private/comment_delete.do?num="+num+"&ref_group=${dto.num}";
		}
	});
	//답글 달기 링크를 클릭했을때 실행할 함수 등록
	$(document).on("click",".reply-link", function(){
		//로그인 여부
		var isLogin=${not empty id};
		if(isLogin == false){
			alert("로그인 페이지로 이동합니다.")
			location.href="${pageContext.request.contextPath }/users/loginform.do?"+
					"url=${pageContext.request.contextPath }/withboard/detail.do?num=${dto.num}";
		}
		
		var selector="#comment"+$(this).attr("data-num");
		$(selector)
		.find(".re-insert-form")
		.slideToggle();
		
		if($(this).text()=="답글"){//링크 text를 답글일때 클릭하면 
			$(this).text("취소");//취소로 바꾸고 
		}else{//취소일때 크릭하면 
			$(this).text("답글");//답들로 바꾼다.
		}	
	});
	$(document).on("submit",".insert-form", function(){
		//로그인 여부
		var isLogin=${not empty id};
		if(isLogin == false){
			alert("로그인 페이지로 이동합니다.")
			location.href="${pageContext.request.contextPath }/users/loginform.do?"+
					"url=${pageContext.request.contextPath }/withboard/detail.do?num=${dto.num}";
			return false; //폼 전송 막기 		
		}
	});
	function deleteConfirm(){
		var isDelete=confirm("이 글을 삭제 하시겠습니까?");
		if(isDelete){
			location.href="${pageContext.request.contextPath }/withboard/private/delete.do?num=${dto.num}";
		}
	}
	
	//페이지가 처음 로딩될때 1page 를 보여준다고 가정
	var currentPage=1;
	//전체 페이지의 수를 javascript 변수에 담아준다.
	var totalPageCount=${totalPageCount};
	//현재 로딩중인지 여부
	var isLoading=false;
	
	/*
	페이지 로딩 시점에 document 의 높이가 window 의 실제 높이 보다 작고
	전체 페이지의 갯수가(totalPageCount) 현재페이지(currentPage)
	보다 크면 추가로 댓글을 받아오는 ajax 요청을 해야한다.
	*/
	var dH=$(document).height();//문서의 높이
	var wH=window.screen.height;//window 의 높이
	
	if(dH < wH && totalPageCount > currentPage){
		//로딩 이미지 띄우기
		$(".loader").show();
		
		currentPage++; //페이지를 1 증가 시키고 
		//해당 페이지의 내용을 ajax  요청을 해서 받아온다. 
		$.ajax({
			url:"ajax_comment_list.do",
			method:"get",
			data:{pageNum:currentPage, ref_group:${dto.num}},
			success:function(data){
				console.log(data);
				//data 가 html 마크업 형태의 문자열 
				$(".comments ul").append(data);
				//로딩 이미지를 숨긴다. 
				$(".loader").hide();
			}
		});		
	}	
	
	//웹브라우저에 scoll 이벤트가 일어 났을때 실행할 함수 등록 
	$(window).on("scroll", function(){
		
		//위쪽으로 스크롤된 길이 구하기
		var scrollTop=$(window).scrollTop();
		//window 의 높이
		var windowHeight=$(window).height();
		//document(문서)의 높이
		var documentHeight=$(document).height();
		//바닥까지 스크롤 되었는지 여부
		var isBottom = scrollTop+windowHeight + 10 >= documentHeight;
		if(isBottom){//만일 바닥까지 스크롤 했다면...
			if(currentPage == totalPageCount || isLoading){//만일 마지막 페이지 이면 
				return; //함수를 여기서 종료한다. 
			}
			//현재 로딩 중이라고 표시한다. 
			isLoading=true;
			//로딩 이미지 띄우기
			$(".loader").show();
			
			currentPage++; //페이지를 1 증가 시키고 
			//해당 페이지의 내용을 ajax  요청을 해서 받아온다. 
			$.ajax({
				url:"ajax_comment_list.do",
				method:"get",
				data:{pageNum:currentPage, ref_group:${dto.num}},
				success:function(data){
					console.log(data);
					//data 가 html 마크업 형태의 문자열 
					$(".comments ul").append(data);
					//로딩 이미지를 숨긴다. 
					$(".loader").hide();
					//로딩중이 아니라고 표시한다.
					isLoading=false;
				}
			});
		}
	});			
</script>

<script src="${pageContext.request.contextPath }/resources/js7/jquery-migrate-3.0.1.min.js"></script>
<script src="${pageContext.request.contextPath }/resources/js7/popper.min.js"></script>
<script src="${pageContext.request.contextPath }/resources/js7/bootstrap.min.js"></script>
<script src="${pageContext.request.contextPath }/resources/js7/jquery.easing.1.3.js"></script>
<script src="${pageContext.request.contextPath }/resources/js7/jquery.waypoints.min.js"></script>
<script src="${pageContext.request.contextPath }/resources/js7/jquery.stellar.min.js"></script>
<script src="${pageContext.request.contextPath }/resources/js7/owl.carousel.min.js"></script>
<script src="${pageContext.request.contextPath }/resources/js7/jquery.magnific-popup.min.js"></script>
<script src="${pageContext.request.contextPath }/resources/js7/aos.js"></script>
<script src="${pageContext.request.contextPath }/resources/js7/jquery.animateNumber.min.js"></script>
<script src="${pageContext.request.contextPath }/resources/js7/scrollax.min.js"></script>
<script src="${pageContext.request.contextPath }/resources/js7/main.js"></script>
</body>
</html>










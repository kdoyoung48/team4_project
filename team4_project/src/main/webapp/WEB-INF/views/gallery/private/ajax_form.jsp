<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<head>
<!-------------타이틀 (페이지 제목)------------->
<title>Image upload</title>
<!------------- css 영역------------->  
<jsp:include page="../../include/resource.jsp"></jsp:include>

<style>	
/*한글 폰트 적용 (사용법 id="font_1")*/
	#font_1{
		font-family: 'Noto Sans KR', sans-serif;
	}
	.img-wrapper{
		height: 800px;
	}
</style>
</head>
<body>
<!-------------navbar 네비바------------->
<jsp:include page="../../include/navbar.jsp"></jsp:include>
<section class="ftco-section" id="contents-section">
	<div class="container">
		<div class="comment-form-wrap pt-5">
			<!---- 제목 부분 ---->
			<div class="row justify-content-center pb-5">
				<div class="col-md-12 heading-section text-center ftco-animate">
					<!--소제목-->
					<span class="subheading"><a href="${pageContext.request.contextPath }/gallery/list.do">Gallery</a></span>
					<!--제목-->
					<h2 class="mb-4">Image Upload</h2>			
				</div>
			</div>		
		</div>
		<!-- 이미지 업로드 폼 -->
		<form action="insert.do" method="post" id="insertForm">
		<input type="hidden" name="imagePath" id="imagePath"/>
			<div class="form-group">
				<label for="caption">Caption</label>
				<input class="form-control" type="text" name="caption" id="caption"/>
			</div>
		</form>
		<form action="ajax_upload.do" method="post" id="ajaxForm" enctype="multipart/form-data">
			<div class="form-group">
				<label for="image">Image</label>
				<input class="form-control" type="file" name="image" id="image" 
					accept=".jpg, .jpeg, .png, .JPG, .JPEG"/>
			</div>
		</form>
		<button class="btn py-3 px-4 btn-primary" id="submitBtn">Upload</button>
		<div class="img-wrapper">
			<img />
		</div>
	</div><!-- container -->
</section>
<!-- jquery form 플러그인 javascript 로딩 -->
<!-------------script 스크립트------------->
<jsp:include page="../../include/resource_script.jsp"></jsp:include>
<script src="${pageContext.request.contextPath }/resources/js/jquery-3.5.1.js"></script>
<script src="${pageContext.request.contextPath }/resources/js/jquery.form.min.js"></script>
<script>
	//form 플러그인을 이용해서 form 이 ajax 전송(페이지 전환없이) 되도록 한다.
	$("#ajaxForm").ajaxForm(function(data){
		// data 는 {imagePath:"업로드된 이미지경로"} 형태의 object 이다.
		console.log(data);
		//로딩할 이미지의 경로 구성
		let src="${pageContext.request.contextPath}"+data.imagePath;
		// img 요소의 src 속성으로 지정을 해서 이미지를 표시한다.
		$(".img-wrapper img").attr("src", src);
		// 업로드 경로를 insertForm 에 input type="hidden" 에 value 로 넣어준다.
		$("#imagePath").val(data.imagePath);
	});
	
	//이미지를 선택하면 강제로 폼 전송 시키기
	$("#image").on("change", function(){
		// id 가 ajaxForm  인 form 을 강제 submit 시키기
		$("#ajaxForm").submit();
	});
	
	//버튼을 누르면 insertForm 강제 제출해서 이미지 정보가 저장되도록 한다.
	$("#submitBtn").on("click", function(){
		$("#insertForm").submit();
	});
</script>
</body>
</html>
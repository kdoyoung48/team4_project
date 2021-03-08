<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<head>
<!-------------타이틀 (페이지 제목)------------->
<title>Post Update </title>
<!------------- css 영역------------->  
<jsp:include page="../../include/resource.jsp"></jsp:include>

<style>	
/*한글 폰트 적용 (사용법 id="font_1")*/
	#font_1{
		font-family: 'Noto Sans KR', sans-serif;
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
					<!--대분류-->
					<span class="subheading"><a href="${pageContext.request.contextPath }/freeboard/list.do">FreeBoard</a></span>
					<!--소분류 영어-->
					<h2 class="mb-4">Post</h2>					
				</div>
			</div>	
			<form action="update.do" method="post">				
				<div class="form-group">
				<label for="category">Category</label>
				<select class="form-control" id="font_1" name="category" id="category">
						<option value="">선택</option>
						<option value="잡담">잡담</option>
						<option value="정보">정보</option>
						<option value="나눔">나눔</option>
				</select>
				<br>
				<input type="hidden" name="num" value="${dto.num }"/>
				<label for="title">Writer</label>
				<input class="form-control" type="text" id="writer" value="${dto.writer }" disabled/>							
				<br>
				<label for="title">Title</label>
				<input class="form-control" type="text" name="title" id="title" value="${dto.title }"/>
				<br>
				<label for="content">Content</label>
				<textarea class="form-control" name="content" id="content">${dto.content }</textarea>
				</div>
				<br>
				<button class="btn btn-primary" type="submit" onclick="submitContents(this);">수정확인</button>
				<button class="btn btn" type="reset">취소</button>
			</form>							
		</div>	
	</div><!-- container -->
</section>
<!------------- footer ------------->    
<jsp:include page="../../include/footer.jsp"></jsp:include>   

<!-------------script 스크립트------------->
<jsp:include page="../../include/resource_script.jsp"></jsp:include>
<!-- SmartEditor 에서 필요한 javascript 로딩  -->
<script src="${pageContext.request.contextPath }/SmartEditor/js/HuskyEZCreator.js"></script>
<script>
	var oEditors = [];
	
	//추가 글꼴 목록
	//var aAdditionalFontSet = [["MS UI Gothic", "MS UI Gothic"], ["Comic Sans MS", "Comic Sans MS"],["TEST","TEST"]];
	
	nhn.husky.EZCreator.createInIFrame({
		oAppRef: oEditors,
		elPlaceHolder: "content",
		sSkinURI: "${pageContext.request.contextPath}/SmartEditor/SmartEditor2Skin.html",	
		htParams : {
			bUseToolbar : true,				// 툴바 사용 여부 (true:사용/ false:사용하지 않음)
			bUseVerticalResizer : true,		// 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음)
			bUseModeChanger : true,			// 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음)
			//aAdditionalFontList : aAdditionalFontSet,		// 추가 글꼴 목록
			fOnBeforeUnload : function(){
				//alert("완료!");
			}
		}, //boolean
		fOnAppLoad : function(){
			//예제 코드
			//oEditors.getById["ir1"].exec("PASTE_HTML", ["로딩이 완료된 후에 본문에 삽입되는 text입니다."]);
		},
		fCreator: "createSEditor2"
	});
	
	function pasteHTML() {
		var sHTML = "<span style='color:#FF0000;'>이미지도 같은 방식으로 삽입합니다.<\/span>";
		oEditors.getById["content"].exec("PASTE_HTML", [sHTML]);
	}
	
	function showHTML() {
		var sHTML = oEditors.getById["content"].getIR();
		alert(sHTML);
	}
	//폼 전송 버튼을 눌렀을때 호출되는 함수 
	//<button type="submit" onclick="submitContents(this);"></button>	
	function submitContents(elClickedObj) {
		oEditors.getById["content"].exec("UPDATE_CONTENTS_FIELD", []);	// 에디터의 내용이 textarea에 적용됩니다.
		
		// 에디터의 내용에 대한 값 검증은 이곳에서 document.getElementById("content").value를 이용해서 처리하면 됩니다.
		
		try {
			elClickedObj.form.submit();
		} catch(e) {}
	}
	
	function setDefaultFont() {
		var sDefaultFont = '궁서';
		var nFontSize = 24;
		oEditors.getById["content"].setDefaultFont(sDefaultFont, nFontSize);
	}
</script>
</body>
</html>

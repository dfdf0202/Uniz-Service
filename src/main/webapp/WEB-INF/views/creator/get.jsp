<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>    
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
	<link rel="stylesheet" href="/resources/css/Navbar.css">
    <link rel="stylesheet" href="/resources/css/applyGet.css">
    <link rel="stylesheet" href="/resources/css/Footer.css">
</head>
<body>

	<%@ include file="/WEB-INF/views/includes/nav.jsp"%>
	
<div class="mainPage" style="margin-bottom: 40px;">
	<div class="leftSidebar">
		<div class="fixed">
		    <div class="SideHd">커뮤니티</div>
		    <button id="channelPost" class="moveChannel">채널 게시판</button>
		    <button id="channelPost" class="moveCategory">카테고리 별 게시판</button>
		</div>
    </div>
    <div class="comPage">
    	<div class="FForm">
    		<div class="creatorRegisterHeader">
        		<h1>등록 조회 페이지</h1>
    		</div>
	
			<div class="createForm">
    			<div class="registerForm">
	        		<label class="label">(운영하는)채널 이름</label>
						<input class="form-control" name='channelTitle' id='channelTitle' value="<c:out value="${apply.channelTitle}" />" readonly="readonly">
						<input type='hidden' class="form-control" name='userSN' id='userSN' value="<c:out value="${apply.userSN}" />" readonly="readonly">
					<label class="label">채널 운영 주 카테고리 목록</label>
						<input  class="form-control" name='category' value='<c:out value="${apply.category}"/>' readonly="readonly">
					<label class="label">[연락 받을 이메일 주소를 입력하세요]</label>
						<input  class="form-control" name='email' value='<c:out value="${apply.email}"/>' readonly="readonly">
	
					<div class="uploadResult">
						<ul>
						</ul>
					</div>
	
					<div class="applyBtnBox" style="margin-top: 40px;">
						<button class="submitBtn" id="modify">수정하기</button>
						<button class="submitBtn" id="list">채널 게시판으로 이동</button>
					</div>
				</div>
			</div>
		</div>
	</div>	
	
	
</div>

<div class="footer">

<div class="foot">
    <div class="header">
        <h3 class="font_h3"> 고객센터</h3> <span class="font_span">|</span> <h3 class="font_h3">공지사항</h3>
    </div>
    <div class="midInfo">
        <p>콘텐츠 제공 문의</p>
        <p>페이스북</p>
        <p>회사 소개 </p>
        <p>인스타그램</p>
        <p>인재 채용</p>
        <p>사업 제휴 문의 </p>
    </div>
    
    <div class="address">
        <p>서울특별시 종로구 종로2가 9 YMCA 7F</p>
        <div class="conf">

            <p>@uniz Corp</p>
            <p>이용 약관</p>
            <p>|</p>
            <p>개인정보 처리방침</p>
            <p>|</p>
            <p>청소년 보호 정책</p>
            <p>|</p>
            <p>사업자 정보 확인</p>
        </div>
    </div>
</div>
</div>
		
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>	
<script type="text/javascript">

	$(document).ready(function(e){
		
		let userSN = "${apply.userSN}";
		
		$("#modify").on("click", function(){
			
			self.location = "/creator/modify?userSN=" + userSN;
			
		});
		
		$("#list").on("click", function(){
			
			self.location = "/channel/ch";
			
		});
		
	});
	
</script>
<script>

$(document).ready(function(){
	
	(function(){
		
		var applySN = "${apply.applySN}";
		
		console.log("applySN : " + applySN);
		
		$.getJSON("/creator/getAttachList", {applySN: applySN}, function(arr){
		
			console.log(arr);
			
			var str = "";
			
			$(arr).each(function(i, attach){
				
				if(attach.fileType){
					
					var fileCallPath = encodeURIComponent( attach.uploadPath+"/"+ attach.uuid + "_" + attach.fileName);
					
					str += "<li data-path='"+attach.uploadPath+"' data-uuid='"+attach.uuid+"' data-filename='"+attach.fileName+"'data-type'"+attach.fileType+"'><div>";
					str += "<img src='/apDisplay?fileName="+fileCallPath+"'>";
					str += "</div>";
					str += "</li>";
					str += "<br>";
					
					console.log("str : " + str);
				}
				
			});
			
			$(".uploadResult ul").html(str);
	
		});
	
	})();
	
});

$(".moveChannel").on("click" , function(){
	self.location="/channel/ch";
});

$(".moveCategory").on("click", function(){
	self.location="/category/main";
});

</script>
</body>
</html>

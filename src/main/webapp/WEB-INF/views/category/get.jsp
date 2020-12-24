<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<link rel="stylesheet" href="/resources/css/Navbar.css">
    <link rel="stylesheet" href="/resources/css/categoryGet2.css">
    <link rel="stylesheet" href="/resources/css/Footer.css">

</head>
<body>


<!-- 여기 카테고리 게시판  -->
<%@ include file="/WEB-INF/views/includes/nav.jsp"%>

<div class="mainPage">
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
		<h1> <c:out value="${board.boardComment}"/></h1>
	</div>
 		
					
		<div class="createForm">
				<div class="registerForm">
	<p class="ReadInfo postSN">#<c:out value="${board.postSN}" /></p>
	<p class="ReadInfo title"><c:out value="${board.title}" /></p>
	
	<div class="flexBox">
	<img  id="proImg" class="rg_i Q4LuWd" src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT7kzhoTZI7LgGuON4WD80O0DSUTy8_3LeFMw&amp;usqp=CAU" jsname="Q4LuWd" width="226" height="150" alt="지브리 영화 추천>_귀를 기울이면(Whisper Of The Heart) 1편 : 네이버 ..." data-iml="14948.429999996733">
	<p class="ReadInfo nick"><c:out value="${board.nick}" /></p>
	</div>
					<div class="content">
					<p><c:out value="${board.postContent}" /></p>
						<ul>
						</ul>
					</div>
	
	
	<div class="applyBtnBox">
	
		<c:if test = "${user.userSN eq board.userSN}" >

			<button class="submitBtn" id='modify'>글 수정</button>
			
		</c:if>
		
			<button class="submitBtn" id='list'>목록으로</button>
		
	</div>
	<div></div>
	 <div class="line"></div> -
	
	<div class="Cmtcontainer">
        <label class="comment" for="content">댓글</label>
        <form class="Cform" name="commentInsertForm" >
            <div class="input-group">
               <input class='postSN' type="hidden" name="postSN" value="${postSN}"/>
               <input class='userSN' type="hidden" id="userSN" name="userSN" value="${user.userSN}"/>
               <input class="registerReply" type="text" id="replyContent" name="replyContent" placeholder="내용을 입력하세요." onclick="return checkSession();" >
               <span class="input-group-btn">
                    <button class='registerBtn' id='registerBtn' type="submit" >등록</button>
               </span>
             </div>
        </form>
    </div>
			
				<div class="reply">	
			</div>
			
			<div class="postFooter"></div>	
		</div> <!-- registerForm end -->
	</div> <!-- createForm end -->
	
	</div>
	<!-- FForm end  -->

</div> <!-- comPage end  -->
</div>

	<div class="footer">
        <div class="foot">
            <div class="header">
                <h3> 고객센터</h3> <span>|</span> <h3>공지사항</h3>
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
<script type="text/javascript" src="/resources/js/category.js"></script>	
<script type="text/javascript" src="/resources/js/reply.js"></script>
<script type="text/javascript">

$(document).ready(function(){
	
	var postSN = '<c:out value="${postSN}"/>';
	var boardSN = '<c:out value="${board.boardSN}"/>';
	
	showList(1);
	
}); // ready end

	var postSN = '<c:out value="${postSN}"/>';
	var boardSN = '<c:out value="${board.boardSN}"/>';
	
	var str = "";
	var newReply = $(".Cmtcontainer");

	var inputReply = newReply.find("input[name='replyContent']");
	var inputUserSN = newReply.find("input[name='userSN']");
	var inputReplySN = newReply.find("input[name='replySN']");
	var registerBtn = $("#registerBtn");

	
	
function showList(page){
	
	
	var chSession = '<c:out value="${user.userSN}"/>';
	
	sessionStorage.setItem('user', chSession);
	
	var session = parseInt(sessionStorage.getItem('user'));
	
	replyService.commentList({postSN : postSN, page : page || 1} ,function(replyCnt, list){
		
		if(page == -1 ){
			pageNum = Math.ceil(replyCny / 10.0);
			showList(pageNum);
			return;
		}
		
		var a = "";
		
		if(list == null || list.length == 0){
			return;
		}
		
		for (var i = 0, len = list.length || 0; i < len; i++){
			console.log("userSN : " + list[i].userSN);
			  a += '<div class="commentArea">';
                a += '<div class="commentInfo'+list[i].replySN+'">';
                a += '<span class="userName">' + list[i].nick + '</span>';
                a += '<div class="commentContent'+list[i].replySN+'">';
                a += '<p class="replyCont">'+ list[i].replyContent + '</p></div>';
                
                if(session == list[i].userSN){
                	
	                a += '<a class="a mod" onclick="commentUpdate('+list[i].replySN+',\''+list[i].replyContent+'\');"> 수정 </a>';
	                a += '<a class="a del" role="button" class="deleteBtn" onclick="remove('+list[i].replySN+');"> 삭제 </a> </div>';
                	
                }
                
                a += '</div></div>';
		}

		 $(".reply").html(a);
		 showReplyPage(replyCnt);
	});

}

	$("#modify").on("click", function(){
		self.location = "/category/modify/" + postSN + "/"+ boardSN;
	});
	
	$("#list").on("click", function(){
		self.location = "/category/board/"+boardSN;
	});
	
	
	
	registerBtn.on("click" , function(e){
		var str = /^\s+|\s+$/g;
		var reply ={
				replyContent : inputReply.val(),
				userSN : inputUserSN.val(),
				postSN : postSN
		};
	
		if(reply.replyContent == '' || reply.replyContent.replace(str, '').length == 0 ){
			console.log("test======" + reply.replyContent);
			alert("댓글 내용을 입력해주세요");
			return false;
		}
	
		replyService.add(reply, function(result){
			showList(1);
		});
	
	});
	
	
	
	
	var pageNum = 1;
	var replyPageFooter = $(".postFooter");
	
	function showReplyPage(replyCnt){
		var endNum = Math.ceil(pageNum / 10.0) * 10;
		var startNum = endNum -9;
		
		var prev = startNum != 1;
		var next = false;
		
		if(endNum * 10 >= replyCnt){
			endNum = Math.ceil(replyCnt/10.0);
		}
		if(endNum * 10 < replyCnt){
			next = true;
		}
		var str = "<ul>";
		if(prev){
			str += "<li class='page-item'><a class='borderR' href='"+(startNum -1) +"'>Previous</a></li>";
		}
		for ( var i = startNum; i <= endNum; i++){
			var active = pageNum == i ? "active":"";
			str += "<li class='page-item "+active +" '><a class='page-link' href='"+i+"'>"+i+"</a></li>";
		}
		if(next){
			str += "<li><a class='borderR2' href='"+ (endNum + 1) + "'>Next</a></li>";
		}
		str += "</ul>";
		
		replyPageFooter.html(str);
	}
		replyPageFooter.on("click", "li a", function(e){
		e.preventDefault();
		
		
		var targetPageNum = $(this).attr("href");
		
		pageNum = targetPageNum;
		showList(pageNum);
	});
	
	function remove(replySN){
		
		if(confirm("삭제하시겠습니까?")){
			replyService.remove(replySN , function(result){
				showList(1);			
			});
		}
	
	}
	
	function commentUpdate(replySN, replyContent){
		
	    var a ='';
	    

	    a += '<div class="input-group comment">';
	    a += '<input type="text" class="form-control repForm" name="content_'+replySN+'" value="'+replyContent+'"/>';
	    a += '<input type="hidden" class="form-control repForm" name="replySN_'+replySN+'" value="'+replySN+'"/>';
	    a += '<button class="confirm" type="button" onclick="return replyUpdate('+replySN+');">확인</button>';
	    a += '</div>';
	    
	    $('.commentContent'+replySN).html(a);
	    
	}
	
	function replyUpdate(replySN){

		var str = /^\s+|\s+$/g;
		var check =  $('[name=content_'+replySN+']').val();
		
		if(check = '' || check.replace(str, '').length == 0){
			alert("수정 할 내용을 입력해 주세요");
			return false;
		}
		replyService.commentUpdateProc(replySN);
		showList(1);
		
	}
	
	
	

	function checkTitle(){
		
		var str = document.getElementById('replyContent');
		var blank_pattern = /^\s+|\s+$/g;
		
		if(str.value == '' || str.value == null || str.value.replace(blank_pattern, '').length == 0){
			alert("댓글 내용을 입력하세요");
			return false;
		}
	}
	
	var chSession = '<c:out value="${user.userSN}"/>';
	
	sessionStorage.setItem('user', chSession);
	
	var session = sessionStorage.getItem('user');
	
	function checkSession(){
		
		console.log("~~~~~ " + session);
		
		if(session == '' ){
			alert("로그인이 필요합니다");
			return false;
		}
	}


</script>
<script>

$(document).ready(function(){
	
	(function(){
		
		var postSN = '<c:out value="${postSN}"/>';
		
		$.getJSON("/category/getAttachList", {postSN: postSN}, function(arr){
		
			console.log(arr);
			
			var str = "";
			
			$(arr).each(function(i, attach){
				
				if(attach.fileType){
					
					var fileCallPath = encodeURIComponent( attach.uploadPath+"/s_"+ attach.uuid + "_" + attach.fileName);
					
					str += "<li data-path='"+attach.uploadPath+"' data-uuid='"+attach.uuid+"' data-filename='"+attach.fileName+"'data-type'"+attach.fileType+"'><div>";
					str += "<img src='/display?fileName="+fileCallPath+"'>";
					str += "</div>";
					str += "</li>";
				}
				
			});
			
			$(".thumbNail ul").html(str);
	
		});
	
	})();
	
});

</script>
</body>
</html>

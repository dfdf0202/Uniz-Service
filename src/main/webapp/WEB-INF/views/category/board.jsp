<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div id ="board"></div>
	
	
	<div></div>
	<h3>게시글 목록</h3>
	<div id ='postList'></div>
	
	<div id="postFooter"></div>
	
	<div>
		<button id="createBtn" type="button">게시글 작성</button>
		<button id="listBtn" type="button">채널 게시판으로 이동</button>
	</div>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script type="text/javascript" src="/resources/js/category.js"></script>	
<script type="text/javascript">
	
	
$(document).ready(function(){
		
		var boardSN = ${boardSN}; 
		
		var postList = $("#postList");
		
		showList(1);
		
		
		function showList(page){
			
			console.log("show List " + page);
			
			categoryService.getBoardPostList( { boardSN : boardSN ,page: page || 1 }, function(postCnt, list){
			
				console.log("postCnt= " + postCnt);
				
				if(page == -1 ){
					pageNum = Math.ceil(postCnt / 10.0);
					showList(pageNum);
					return;
				}
				
				var str = "";
				
				if(list == null || list.length == 0){
					return;
				}
				
				str += "<thead><tr><th>글 번호</th><th>글 제목</th><th>작성자</th><th>작성 일</th></tr></thead>"
					
					for ( var i = 0, len = list.length || 0; i < len; i ++){
						str += "<th>"+list[i].postSN + "</th>";
						str +=  "<th><a class='move' href='/category/get/"+list[i].postSN+"'>"+list[i].title+"["+list[i].replyCnt+"]"+"</a></th>";
						str += "<th>"+list[i].nick + "</th>";
						str += "<th>"+categoryService.displayTime(list[i].createDateTime) +"</th></tr></thead>";	
						
					}
				
				postList.html(str);
				showPostPage(postCnt);
				
			});
				
			}
		
		var pageNum = 1;
		
		var postFooter = $("#postFooter");
		
		function showPostPage(postCnt){
			
			var endNum = Math.ceil(pageNum / 10.0) * 10;
			var startNum = endNum -9;
			
			var prev = startNum != 1;
			var next = false;
			
			if(endNum * 10 >= postCnt){
				endNum = Math.ceil(postCnt/10.0);
			}
			if(endNum * 10 < postCnt){
				next = true;
			}
			
			var str = "<ul class='pagaination pull-right'>";
			
			if(prev){
				str += "<li class='page-item'><a class='page-link' href='"+(startNum -1) +"'>Previous</a></li>";
			}
			for ( var i = startNum; i <= endNum; i++){
				var active = pageNum == i ? "active":"";
				str += "<li class='page-item "+active +" '><a class='page-link' href='"+i+"'>"+i+"</a></li>";
			}
			if(next){
				str += "<li class='page-item'><a class='page-link' href='"+ (endNum + 1) + "'>Next</a></li>";
			}
			str += "</ul></div>";
			
			postFooter.html(str);
		}
		
		postFooter.on("click", "li a", function(e){
			e.preventDefault();
			
			var targetPageNum = $(this).attr("href");
			
			pageNum = targetPageNum;
			showList(pageNum);
		});
		
		
		
		
		
		$("#listBtn").on("click", function(){
			self.location ="/category/main";
		});
		
		$("#createBtn").on("click",function(){
			self.location = "/category/register/"+boardSN;
		});
		
});
	
</script>
</body>
</html>
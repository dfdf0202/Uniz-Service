<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Uniz-회원가입페이지</title>
	<link rel="stylesheet" href="/resources/css/registerForm.css">
	<link rel="stylesheet" href="/resources/css/RegisterModel.css">
	
    <script src="https://use.fontawesome.com/releases/v5.2.0/js/all.js"></script>
</head>
<body>

<div class="bg">
    <div class="register-box">
        <form id="form" class="registerForm" action="/user/register" method="post">
       
        <h1 class="unizReg">
        <p>Uniz</p>
        </h1>
       
        <div class="regTextBox">
            <input type="text" id="userId" name="userId" placeholder="아이디" size="70">
            <button type="button" class="duplicateBtn" id="userIdCheckBtn">중복확인</button>
        </div>
        
        <div class="regTextBox">
            <input type="password" id="password" name="password" placeholder="비밀번호">
        </div>
    
        <div class="regTextBox">
            <input type="password" id="password2" name="password2"placeholder="비밀번호 확인">
        </div>
    
        <div class="regTextBox">
            <input type="text" id="nick" name="nick" placeholder="닉네임" size="70">
            <button type="button" class="duplicateBtn" id="userNickCheckBtn">중복확인</button>
        </div>
        
         <div class="soso">
            <img src="http://pepem1.cafe24.com/web/upload/da_image/sns_join01.jpg" alt="카카오계정 로그인">
            <img src="http://pepem1.cafe24.com/web/upload/da_image/sns_join02.jpg" alt="네이버계정 로그인">
        </div>
        
        <div class="btnBox">
            <button type="button" class="nextBtn" id="myBtn"onclick="">다음</button>
            <button class="cancelBtn" type="reset">취소</button>
        </div>
        
       
        
        
    </div> 
    
    <!-- The Modal -->
		<div id="myModal" class="modal">
		
		  <!-- Modal content -->
		  <div class="modal-content">
		    <div class="title">
		      <p>마지막 단계입니다! 당신의 유튜브 취향을 선택해주세요!</p>
		    </div>
			<div class="gridContainer">
				<c:forEach items="${PresetList}" var="preset" varStatus="status">
					<input type="checkbox" id="uniz${status.count}" name ="unizSN" value="${preset.unizSN}">
      					<label for="uniz${status.count}" class="item uniz${status.count}"><p class="p${status.count}">${preset.unizKeyword}</p></label>
      					
				</c:forEach>
				
				<input type="hidden" name="state" value="1">
		        <button class="submitBtn"type="submit">완료</button>
		    </div>
		    <!-- end gridContainer -->
		    
		  </div>
		
		</div>
      	<input type="hidden" value="" id="idcheck">
		<input type="hidden" value="" id="nickcheck">
      
    </form>
</div>
	
<script src="https://code.jquery.com/jquery-3.3.1.js"></script>
<script>
	
	
	
    // Get the modal
    var modal = document.getElementById("myModal");
    
    // Get the button that opens the modal
    var btn = document.getElementById("myBtn");
    
    function checkForm(){
		let form = document.getElementById("form");
		
		if(form.userId.value == ""){
			alert("아이디를 입력하세요");
			modal.style.display = "none";
			form.userId.focus();
			return false;
		}
		
		if(form.userId.value.length < 4 || form.userId.value.length > 12){
			alert("아이디는 4~12자 이내로 입력 가능합니다!");
			modal.style.display = "none";
			form.userId.select(); 
			return false;
		}
		
		
		 if (form.password.value == "")
            {
                 alert("비밀번호를 입력해주세요");
                 modal.style.display = "none";
                 form.password.focus();//포커스를 Password박스로 이동.
                 return false;
            }
		 
		 if (form.password.value.length < 4 || form.password.value.length > 12)
            {
                 alert("비밀번호는 4~12자 이내로 입력 가능 합니다!");
                 modal.style.display = "none";	
                 form.password.select();
                 return false;
            }
		 
		 if(form.nick.value == ""){
				alert("닉네임을 입력해주세요");
				modal.style.display = "none";
				form.nick.focus();
				return false;
			}
			
			if(form.nick.value.length < 2 || form.nick.value.length > 9){
				alert("닉네임은는 2~8자 이내로 입력 가능합니다!");
				modal.style.display = "none";
				form.nick.select(); 
				return false;
			}
			
			if(form.password.value != form.password2.value){
				alert("비밀번호가 일치하지 않습니다. 비밀번호를 확인해주세요");
				return false;
			}
			
			if($("#userIdCheckBtn").is(":disabled") == false){
				alert("아이디 중복체크를 해주세요");
				return false;
			}
			
			if($("#userNickCheckBtn").is(":disabled") == false){
				alert("닉네임 중복체크를 해주세요");
				return false;
			}
			if($("#idcheck").val() != $("#userId").val()){
				alert("아이디 중복체크를 해주세요");
				$("#userIdCheckBtn").attr("disabled", false);
				return false;
			}
			if($("#nickcheck").val() != $("#nick").val()){
				alert("닉네임 중복체크를 해주세요");
				$("#userNickCheckBtn").attr("disabled", false);
				return false;
			}
			
		 
		 for (i=0; i<form.userId.value.length; i++)
            {
                   var ch = form.userId.value.charAt(i);//문자를 반환(정수형), 범위 검사 가능

                   //입력된 문자를 검사

                   if ( (ch < "a" || ch > "z") && (ch < "A" || ch > "Z") && (ch < "0" || ch > "9" )){
	                    alert("아이디는 영문 소문자로만 입력 가능 합니다!");
	                    modal.style.display = "none";
	                    form.userId.select();
	                    return false;
                   }
                   
                   return ;
            }
		return true;
	}
    // When the user clicks the button, open the modal 
    btn.onclick = function() {
    	let result = checkForm();
    	console.log(result)
    	if(result != false){
	        modal.style.display = "block";        
    		
    	}
    }
        
    // When the user clicks anywhere outside of the modal, close it
    window.onclick = function(event) {
      if (event.target == modal) {
        
        modal.style.display = "none";
      }
    }

    $(document).ready(function(){
		
		$('#userIdCheckBtn').click(function(){
			
			if($("#userId").val()==""){
			alert("중복체크할 아이디를 입력해 주세요");
			return ;
			}
		
		$.ajax({
			type : "POST",
			url : "/user/userIdCheck",
			data : $("#userId").val(),		
			contentType : "application/json; charset=UTF-8",
			dataType: "json",
			success : function(data){
				
				const SUCCESS = "SUCCESS";
				const DUPLICATION = "DUPLICATION";
				
				if(data.result == SUCCESS){
					alert("사용할 수 있는 아이디 입니다.")
					$("#userIdCheckBtn").attr("disabled", "disabled");
					let userId = $("#userId").val()
					$("#idcheck").val(userId);
				}else if(data.result == DUPLICATION){
					alert("이미 존재하는 아이디 입니다.")	
				}else{
					alert("데이터 입력 중 오류가 발생하였습니다.\n입력한 정보를 다시 확인해 주세요.");
				}			
			}
		});
	});
	
	$('#userNickCheckBtn').click(function(){
		
		if($("#nick").val()==""){
			alert("중복체크할 닉네임를 입력해 주세요");
			return ;
		}
		console.log("중복확인버튼클릭");

		$.ajax({
			type : "POST",
			url : "/user/userNickCheck",
			data : $("#nick").val(),		
			contentType : "application/json; charset=UTF-8",
			dataType: "json",
			success : function(data){
				
				const SUCCESS = "SUCCESS";
				const DUPLICATION = "DUPLICATION";
				if(data.data == SUCCESS){
					alert("사용할 수 있는 닉네임 입니다.");
					$("#userNickCheckBtn").attr("disabled", "disabled");
					let nick = $("#nick").val()
					$("#nickcheck").val(nick);
				}else if(data.data == DUPLICATION){
					alert("이미 존재하는 닉네임 입니다.")	
				}else{
					alert("데이터 입력 중 오류가 발생하였습니다.입력한 정보를 다시 확인해 주세요.");
				}			
			}
		});			
	});
	
	
});
</script>

</body>
</html>
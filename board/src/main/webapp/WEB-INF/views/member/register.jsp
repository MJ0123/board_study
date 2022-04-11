<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
	<title>MJ 게시판</title>

	<script src='https://code.jquery.com/jquery-3.3.1.min.js'></script>
</head>
<body>

<form role="form" method="post" autocomplete="off">
	<p>
		<label for="userId">아이디</label>
		<input type="text" id="userId" name="userId" />
		
		<button type="button" class="idCheck">아이디 확인</button>
	</p>
	
	<p class="result">
		<span class="msg">아이디를 확인해주십시오.</span>
	</p>
	
	<p>
		<label for="userPw">패스워드</label>
		<input type="password" id="userPw" name="userPw" />
	</p>
	<p>
		<label for="userName">닉네임</label>
		<input type="text" id="userName" name="userName" />
	</p>
	<p>
		<button type="submit" id="submit" disabled="disabled" >가입</button>
	</p>
	<p>
		<a href="/">처음으로</a>
	</p>
	
</form>

<script>
$(".idCheck").click(function(){
	
	// 일반적인 변수가 아닌 JSON형식의 변수
	// JSON 형식의 변수는 {key:value, key:value}의 형태를 가진 변수
	var query = {userId : $("#userId").val()};
	
	$.ajax({
		// url은 전송되는 주소, 컨트롤러에 생성한 메서드의 매핑 주소를 입력하면 되고 data는 전송할 값을 넣어줌
		// url로 정상적인 통신이 이루어졌다면 success 부분이 실행됨
		url : "/member/idCheck",
		type : "post",
		data : query,
		success : function(data) {
			
			if(data == 1) {
				$(".result .msg").text("사용 불가");
				$(".result .msg").attr("style", "color:#f00")
				
				// 아이디가 중복될 경우 id="submit" 속성을 가진 요소는 비활성화
				$("#submit").attr("disabled", "disabled");
			} else {
				$(".result .msg").text("사용 가능");
				$(".result .msg").attr("style", "color:#00f")
				
				// 아이디가 중복되지 않을 경우 id="submit" 속성을 가진 요소의 비활성화 속성을 활성화 시켜줌
				$("#submit").removeAttr("disabled");
			}
		}
	});		// ajax 끝
});

$("#userId").keyup(function() {
	$(".result .msg").text("아이디를 확인해주십시오.");
	$(".result .msg").attr("style", "color:#000");
	
	$("#submit").attr("disabled", "disabled");
});
</script>
</body>
</html>
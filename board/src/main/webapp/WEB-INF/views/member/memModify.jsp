<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MJ 게시판</title>
</head>
<body>

<form role="form" method="post" autocomplete="off">
	<p>
		<label for="userName">닉네임</label>
		<input type="text" id="userName" name="userName" value="${member.userName}" readonly="readonly"/>
	</p>
	<p>
		<label for="userPw">새로운 패스워드</label>
		<input type="password" id="userPw" name="userPw" />
	</p>
	<p>
		<button type="submit">회원정보 수정</button>
	</p>
	<p>
		<a href="/">처음으로</a>
	</p>
	
</form>
</body>
</html>
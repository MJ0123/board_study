<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MJ 게시판</title>
</head>
<body>

	<form role="form" method="post" autocomplete="off">
		<p>
			<label for="userId">아이디</label> 
			<input type="text" id="userId" name="userId" value="${member.userId}" />
		</p>
		<p>
			<label for="userPw">패스워드</label> 
			<input type="password" id="userPw" name="userPw" />
		</p>
		<p>
			<button type="submit">회원탈퇴</button>
		</p>
		<p>
			<a href="/">처음으로</a>
		</p>
	</form>

	<c:if test="${msg == false }">
		<p>입력한 비밀번호가 잘 못 되었습니다.</p>
	</c:if>
</body>
</html>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html>
<head>
<title>MJ 게시판</title>
</head>
<body>
	<!-- 제목 -->
	<h1>MJ 게시판</h1>

	<P>The time on the server is ${serverTime}.</P>

	<p>
		<a href="/board/list">게시물 목록</a>
	</p>
	<p>
		<a href="/board/write">게시물 작성</a>
	</p>

	<!-- 내용 추가 -->
	
	<c:if test="${member == null}">
	<form role="form" method="post" autocomplete="off" action="/member/login">
		<p>
			<label for="userId">아이디</label>
			<input type="text" id="userId" name="userId" />
		</p>
		<p>
			<label for="userPw">비밀번호</label>
			<input type="password" id="userPw" name="userPw" />
		</p>
		<p>
			<button type="submit">로그인</button>
		</p>
		<p>
			<a href="/member/register">회원가입</a>
		</p>
	</form>
	</c:if>
	
	<c:if test="${msg == false}">
		<p style="color:#f00;">로그인에 실패했습니다. 아이디 또는 패스워드를 다시 입력해주십시오.</p>
	</c:if>
	
	<c:if test="${member != null}">
		<p>${member.userName}님 환영합니다.</p>
		<a href="member/memModify">회원정보 수정</a> <a href="member/memDelete">회원탈퇴</a><br />
		<a href="member/logout">로그아웃</a>
	</c:if>
</body>
</html>

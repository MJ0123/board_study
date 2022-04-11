<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시물 조회</title>

	<!-- 합쳐지고 최소화된 최신 css -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">

	<!-- 부가적인 테마 -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">

	<!-- 합쳐지고 최소화된 최신 자바스크립 -->
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
	
</head>
<body>

<div class="container">

	<!-- 헤더 -->
	<div id="header">
	  <%@ include file="../include/header.jsp" %>
	 </div>
	 
	<!-- 메뉴 -->
	<div id="nav">
		<%@ include file="../include/nav.jsp"%>
	</div>

	<!-- <label>제목</label>
${view.title}<br/>

<label>작성자</label>
${view.writer}<br/>

<label>내용</label></br>
${view.content}<br/>
-->

	<h2>${view.title}</h2>

	<hr/>
	<div class="form-group">
		<label for="writer" class="col-sm-2control-label">작성자 : </label>${view.writer}
	</div>

	<hr/>

	<div class="content">${view.content}</div>

	<hr/>

	<div>
		<a href="/board/modify?bno=${view.bno}">게시물 수정</a>
		<a href="/board/delete?bno=${view.bno}">게시물 삭제</a>
	</div>

	<!--  댓글 시작 -->

	<hr/>

	<ul>

		<c:forEach items="${reply}" var="reply">
			<li>
				<div>
					<p>${reply.writer} / <fmt:formatDate value="${reply.regDate}" pattern="yyyy-MM-dd" /></p>
					<p>${reply.content}</p>
				</div>
			</li>
		</c:forEach>
	</ul>
	<hr/>
	
	<div>

		<!-- * form 내부의 데이터를 post형식으로 보내되, /reply/write의 경로로 보냄
			 * action을 지정하지 않을 경우, 현재의 url로 데이터를 보냄
			 * 댓글이 작성되는 현재 페이지는 게시물 조회중이기 때문에 루트/view?bno=? 방식의 url을 가지고 있음
			 * 여기에서 action 지정없이 전송하게 되면, 현재 주소로 데이터를 날리기 때문에 에러가 발생함 -->
		<form method="post" action="/reply/write" class="form-horizontal">

			<div class="form-group">
				<label for="writer" class="col-sm-1 control-label">작성자</label>
				<div class="col-sm-2">
					<input type="text" name="writer" class="form-control">
				</div>
			</div>
			<div class="col-sm-10">
				<textarea rows="5" name="content" class="form-control" style="resize: none;"></textarea>
			</div>
			<div class="form-group">
				<div class="col-sm-offset-2 col-sm-1" >
					<input type="hidden" name="bno" value="${view.bno}">
					<button type="submit" class="repSubmit btn btn-success">댓글 작성</button>
				</div>
			</div>
		</form>
	</div>

	<!-- 댓글 끝 -->
	</div>
</body>
</html>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>insert title here</title>
</head>
<body>

<!-- 메뉴 -->
<div id="nav">
	<%@ include file="../include/nav.jsp" %>
</div>

	<table>
		<thead>
			<tr>
				<th>번호</th>
				<th>제목</th>
				<th>작성일</th>
				<th>작성자</th>
				<th>조회수</th>
			</tr>
		</thead>

		<tbody>

			<!-- 컨트롤러(Controller)에서 받아온 데이터를 출력하기 위해 jstl의 반복문을 이용하여 출력 -->
			<c:forEach items="${list}" var="list">
				<tr>
					<td>${list.bno}</td>
					<td>
						<!-- 링크 태그의 주소는 /board/view?bno=[고유번호]가 되기 때문에 주소의 파라미터값 컨트롤러에 전달할 수 있 -->
						<a href="/board/view?bno=${list.bno}">${list.title}</a>
					</td>
					<!-- 날짜 포멧 -->
					<td>
						<fmt:formatDate value="${list.regDate}" pattern="yyyy-MM-dd" />
					</td>
					<td>${list.writer}</td>
					<td>${list.viewCnt}</td>
				</tr>
			</c:forEach>
			
		</tbody>

	</table>

</body>
</html>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MJ 게시판</title>

<!-- 합쳐지고 최소화된 최신 css -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">

<!-- 부가적인 테마 -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">

<!-- 합쳐지고 최소화된 최신 자바스크립 -->
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>

</head>
<body>

	<div class="container">
		<!-- 제목 -->
		<div id="header">
			<%@ include file="../include/header.jsp" %>
		</div>
		
		<!-- 메뉴 -->
		<div id="nav">
			<%@ include file="../include/nav.jsp"%>
		</div>

		<section>
			<h2>글 목록</h2>

			<table class="table table-hover">
				<thead>
					<tr>
						<th>번호</th>
						<th>제목</th>
						<th>작성일</th>
						<th>작성자</th>
						<th>조회수</th>
					</tr>
				</thead>
				<!-- 컨트롤러(Controller)에서 받아온 데이터를 출력하기 위해 jstl의 반복문을 이용하여 출력 -->
				<c:forEach items="${list}" var="list">
					<tr>
						<td>${list.bno}</td>
						<td>
							<!-- 링크 태그의 주소는 /board/view?bno=[고유번호]가 되기 때문에 주소의 파라미터값 컨트롤러에 전달할 수 있 -->
							<a href="/board/view?bno=${list.bno}">${list.title}</a>
						</td>
						<!-- 날짜 포멧 -->
						<td><fmt:formatDate value="${list.regDate}"
								pattern="yyyy-MM-dd" /></td>
						<td>${list.writer}</td>
						<td>${list.viewCnt}</td>
					</tr>
				</c:forEach>
			</table>
		</section>




		<%-- <c:forEach begin="1" end="${pageNum}" var="num">
		<span>
			<a href="/board/listPage?num=${num}">${num}</a>
		</span>
	</c:forEach> --%>

		<!-- 검색 배너 -->
		<div class="search row">
			<div class="col-xs-2 col-sm-2">
				<select name="searchType" class="form-control">
					<!-- test 내부에는 조건이 들어가고, 이 조건이 참인 경우 사이에 있는 문자인 selected를 출력, 거짓인 경우 아무것도 출력하지 않음
				page.searchType과 문자열 title이 같은지 확인하는 것. jstl에서는 .equals(); 대신 eq로 짧게 사용 -->
					<option value="title"
						<c:if test="${page.searchType eq 'title'}">selected</c:if>>제목</option>
					<option value="content"
						<c:if test="${page.searchType eq 'content'}">selected</c:if>>내용</option>
					<option value="title_content"
						<c:if test="${page.searchType eq 'title_content'}">selected</c:if>>제목+내용</option>
					<option value="writer"
						<c:if test="${page.searchType eq 'writer'}">selected</c:if>>작성자</option>
				</select>
				<%-- <input type="text" name="keyword" value="${page.keyword}" /> --%>
			</div>

			<div class="col-xs-10 col-sm-10">
				<div class="input-group">
					<input type="text" name="keyword" id="keywordInput" value="${page.keyword}" class="form-control" /> 
					<span class="input-group-btn">
						<button id="searchBtn" class="btn btn-default">검색</button>
					</span>
				</div>
			</div>

			<script>
				// id가 searchBtn인 html 엘리먼트에 클릭 이벤트가 발생하면, function 내부의 코드가 실행
				document.getElementById("searchBtn").onclick = function() {

					// name이 searchType인 html 엘리먼트중 첫번째의 값을 변수(let) searchType에 저장
					// name이 keyword인 html 엘리먼트중 첫번째 값을 변수(let) keyword에 저장
					// document.getElementsByName()로 데이터를 가져오려고 하면 배열로 가져오기 때문에 첫번째인 0번째 데이터를 가져옴
					let searchType = document.getElementsByName("searchType")[0].value;
					let keyword = document.getElementsByName("keyword")[0].value;

					location.href = "/board/listPageSearch?num=1"
							+ "&searchType=" + searchType + "&keyword="
							+ keyword;
				};
			</script>

			<div class="col-md-offset-3">
				<ul class="pagination">

					<c:if test="${page.prev}">
						<li><a href="/board/listPageSearch?num=${page.startPageNum - 1}${page.searchTypeKeyword}">이전</a></li>
					</c:if>

					<c:forEach begin="${page.startPageNum}" end="${page.endPageNum}" var="num">
						 <!-- 반복문 중간에 조건 --> <!-- select의 값이 num과 다를 경우 링크를 출력 -->
							<c:if test="${select != num}">
								<li><a href="/board/listPageSearch?num=${num}${page.searchTypeKeyword}">${num}</a></li>
							</c:if> <!-- select의 값이 num과 같을 경우 굵은 글자로 출력 --> 
							<c:if test="${select == num}">
								<li <c:out value="${select == num ? 'class=active' : ''}"/>>
								<a href="/board/listPageSearch?num=${num}${page.searchTypeKeyword}">${num}</a></li>
							</c:if>
						
					</c:forEach>

					<c:if test="${page.next}">
						
							<li><a href="/board/listPageSearch?num=${page.endPageNum + 1}${page.searchTypeKeyword}">다음</a></li>
						
					</c:if>
				</ul>
			</div>
		</div>
	</div>
</body>
</html>
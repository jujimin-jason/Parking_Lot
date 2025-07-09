<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

	<jsp:include page="../../include/header.jsp" />

	<div align="center">
		<h2>차량 번호 검색 view 페이지</h2>

		<c:set var="pkList" value="${SearchList }" />
		<c:set var="paging" value="${Paging }" />
		<c:set var="Date" value="${Date }" />

		<table border="1" width="500">

			<tr>
				<td colspan="5" align="right">전체 입차 기록 수 : ${paging.totalRecord }
					개</td>
			</tr>

			<tr>
				<th>ID</th>
				<th>차량 번호</th>
				<th>입차 시간</th>
				<th>출차 시간</th>
				<th>현재 상태</th>
			</tr>

			<c:if test="${empty pkList }">
				<tr>
					<td colspan="5">입차목록이 없습니다.</td>
				</tr>
			</c:if>

			<c:if test="${!empty pkList }">
				<c:forEach items="${pkList }" var="dto">
					<tr>
						<td>${dto.pid }</td>
						<td>${dto.car_num }</td>
						<td>${dto.in_time }</td>
						<td>${dto.out_time }</td>
						<td><c:if test="${dto.state == 'Y' }">입차상태</c:if> <c:if
								test="${dto.state == 'N' }">출차상태</c:if></td>

					</tr>
				</c:forEach>
			</c:if>
		</table>
		<br> <br>

		<!-- 페이징 처리 영역 -->
		<c:if test="${paging.page > paging.block }">
			<a
				href="<%=request.getContextPath() %>/pk_search_detail.go?page=1&car_num=${paging.car_num }&date=${Date }">맨
				처음</a>
			<a
				href="<%=request.getContextPath() %>/pk_search_detail.go?page=${paging.startBlock - 1 }&car_num=${paging.car_num }&date=${Date }">◀</a>
		</c:if>

		<c:forEach begin="${paging.startBlock }" end="${paging.endBlock }"
			var="i">
			<c:if test="${i == paging.page }">
				<b><a
					href="<%=request.getContextPath() %>/pk_search_detail.go?page=${i }&car_num=${paging.car_num }&date=${Date }">${i }</a></b>
			</c:if>

			<c:if test="${i != paging.page }">
				<a
					href="<%=request.getContextPath() %>/pk_search_detail.go?page=${i }&car_num=${paging.car_num }&date=${Date }">${i }</a>
			</c:if>
		</c:forEach>

		<c:if test="${paging.endBlock < paging.allPage }">
			<a
				href="<%=request.getContextPath() %>/pk_search_detail.go?page=${paging.endBlock + 1}&car_num=${paging.car_num }&date=${Date }">▶</a>
			<a
				href="<%=request.getContextPath() %>/pk_search_detail.go?page=${paging.allPage }&car_num=${paging.car_num }&date=${Date }">맨
				마지막</a>
		</c:if>

		<br> <br>


		<!-- 검색 폼 영역 -->
		<form method="post"
			action="<%=request.getContextPath()%>/pk_search_detail.go">
			
			<b>상세 정보로 검색</b>
			<br>
			<input type="text" name="car_num" placeholder="차량 뒤 네자리 입력"> 
			<br>
			<input type="date" name="date">
			<input type="submit" value="검색">
		</form>

	</div>
</body>
</html>
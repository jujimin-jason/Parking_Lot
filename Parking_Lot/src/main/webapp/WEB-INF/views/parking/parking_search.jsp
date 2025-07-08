<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
<style type="text/css">
body {
	margin: 0;
	padding: 0;
	height: 100vh;
	display: flex;
	justify-content: center; /* 수평 중앙 */
	align-items: center; /* 수직 중앙 */
	font-family: sans-serif;
	background-color: #f9f9f9;
}

.container {
	text-align: center;
}

table {
	margin: 0 auto;
	border-collapse: collapse;
	width: 500px;
}

table, th, td {
	border: 1px solid #333;
}

th, td {
	padding: 10px;
}

th {
	background-color: #f0f0f0;
}

h1 {
	margin-bottom: 20px;
}
</style>
</head>
<body>

	<jsp:include page="../../include/header.jsp" />

	<div class="container">
		<h1>현재 주차 차량 리스트</h1>

		<form method="post"
			action="<%=request.getContextPath()%>/parking_search.go">
			<input name="keyword"> <input type="submit" value="검색">
		</form>
		<br> <br>

		<table>
			<tr>
				<th>차량 번호</th>
				<th>입차 시간</th>
				<th>출차</th>
			</tr>


			<c:if test="${!empty list }">
				<c:forEach items="${list}" var="dto">
					<tr>
						<td>${dto.car_num}</td>
						<td>${dto.in_time.substring(0, 19)}</td>
						<td><a
							href="<%= request.getContextPath()%>/parking_amount.go?num=${dto.car_num}">출차</a>
						</td>
					</tr>
				</c:forEach>
			</c:if>
			<c:if test="${empty list }">
				<tr>
					<td colspan="3" align="center">입력하신 번호 차량이 없습니다</td>
				</tr>
			</c:if>
		</table>
	</div>



</body>
</html>
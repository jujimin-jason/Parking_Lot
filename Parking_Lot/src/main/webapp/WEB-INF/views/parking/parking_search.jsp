<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
<style type="text/css">


#main-holder {
	max-width: 700px;
	width: 100%;
	background: #fff;
	border-radius: 15px;
	box-shadow: 0 8px 24px rgba(0, 0, 0, 0.1);
	padding: 40px 30px;
	text-align: center;
	margin: 0px auto;
}

#main-holder h3 {
	font-size: 2.2rem;
	font-weight: 800;
	margin-bottom: 30px;
	color: #0d6efd;
}

input[type="submit"] {
border-radius: 50px;
background-color: #0d6efd;
color:#fff;
flex: 1 1 45%;
padding: 5px 10px;
border: none;
}

table {
	margin: 0 auto;
	border-collapse: collapse;
	width: 600px;
}

input {
border-radius: 50px;
padding: 5px 10px;
}
input[type="submit"] {

background-color: #0d6efd;
color:#fff;
flex: 1 1 45%;
border: none;
}

input[type="submit"]:hover, [type="button"]:hover {
	background-color: #0a58ca;
}

input[type="button"] {
background-color: gray;
color:#fff;
flex: 1 1 45%;
border: none;
}



table, th, td {
	border: 1px solid #333;
}

th, td {
	padding: 10px;
}

th {
	background-color: #0d6efd;
	color:#fff;
}


</style>
</head>
<body>

	<jsp:include page="../../include/header.jsp" />

	<div id="main-holder">
		<h3>차량 검색</h1>

		<form method="post"
			action="<%=request.getContextPath()%>/parking_search.go">
			<input name="keyword"> <input type="submit" value="검색"> <input type="button" onclick="location.href='parking_out.go'" value="다시검색">
		</form>
		<br> <br>

		<table>
			<tr>
				<th>차량 번호</th>
				<th>입차 시간</th>
			</tr>


			<c:if test="${!empty list }">
				<c:forEach items="${list}" var="dto">
					<tr onclick="location.href='<%= request.getContextPath()%>/parking_amount.go?num=${dto.car_num}'" style="cursor: pointer;">
						<td>${dto.car_num}</td>
						<td>${dto.in_time.substring(0, 19)}</td>
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
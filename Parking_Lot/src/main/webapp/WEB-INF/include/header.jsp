<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<!-- <link type="text/css" rel="stylesheet" href="../css/header.css" /> -->

<style type="text/css">
body {
	margin: 0 auto;
	padding: 0;
	height: 100vh;
	width: 100vw;
	max-width: 1080px;
	background-color: #f5f5f5;
	justify-content: center;
	justify-content: center;
	text-align: center;
}

.body_div {
	display: flex;
	justify-content: space-between;
	padding: 20px;
}

a {
	text-decoration: none;
	cursor: pointer;
	color: black;
}

a:hover {
	font-weight: bold;
}
</style>

</head>

<body>

	<div class="body_div">
		<a href="<%=request.getContextPath()%>/">header</a>
		<div>
			<c:choose>
				<c:when test="${empty sessionScope.loginMember}">
					<a href="<%=request.getContextPath()%>/admin_login.go">로그인</a>
				</c:when>
				<c:otherwise>
					<a href="<%=request.getContextPath()%>/admin_logout.go">로그아웃</a>
				</c:otherwise>
			</c:choose>
		</div>
	</div>
	<hr style="width:">

</body>
</html>
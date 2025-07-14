<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<!-- <link type="text/css" rel="stylesheet" href="../css/header.css" /> -->

<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.6/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-4Q6Gf2aSP4eDXB8Miphtr37CMZZQ5oXLH2yaXMJ2w8e2ZtHTl7GptT4jmndRuHDT"
	crossorigin="anonymous">

<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.6/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-j1CDi7MgGQ12Z7Qab0qlWQ/Qqz24Gc6BM0thvEMVjHnfYGF0rmFCozFSxQBxwHKO"
	crossorigin="anonymous"></script>

<style type="text/css">
body {
	margin: 0 auto;
	padding: 0;
	height: 100vh;
	width: 100vw;
	max-width: 1080px;
	justify-content: center;
	justify-content: center;
	text-align: center;
}

.body_div {
	display: flex;
	justify-content: space-between;
	align-items: center;
	padding: 20px 20px 0px 20px;
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
		<c:choose>
			<c:when test="${sessionScope.loginMember.store_code == 0}">
				<a href="<%=request.getContextPath()%>/admin_main.go">header</a>
			</c:when>
			<c:when test="${sessionScope.loginMember.store_code > 0}">
				<a href="<%=request.getContextPath()%>/store_page.go">header</a>
			</c:when>
			<c:otherwise>
				<a href="<%=request.getContextPath()%>/">header</a>
			</c:otherwise>
		</c:choose>

		<div>
			<button class="btn btn-secondary"
				onclick="location.href='<%=request.getContextPath()%>/parking_in.go?floor=1'">입차</button>
				
			<button class="btn btn-secondary"
				onclick="location.href='<%=request.getContextPath()%>/parking_out.go'">출차</button>
		</div>

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
	<hr>

</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>출차 리스트</title>

<style>
.container {
	text-align: center;
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
			<input name="keyword" placeholder="차량 뒤 4자리 입력"> <input
				type="submit" value="검색">
		</form>
		<br> <br>

	</div>

</body>
</html>

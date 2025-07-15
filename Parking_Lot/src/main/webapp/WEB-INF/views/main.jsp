<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>메인 페이지</title>

<style>
.container {
	text-align: center;
	height: full;
}

h1 {
	margin-bottom: 20px;
}
</style>

</head>
<body>


	<jsp:include page="../include/header.jsp" />

	<!-- parking_out.jsp 레퍼런스 -->
	
	<div class="container">
		<h1>차량 검색</h1>

		<form method="post"
			action="<%=request.getContextPath()%>/parking_search.go">
			<input name="keyword" placeholder="차량 뒤 4자리 입력"> <input
				type="submit" value="검색">
		</form>

	</div>
	
</body>
</html>
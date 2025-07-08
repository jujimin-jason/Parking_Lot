<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>메인 페이지</title>

<style>
.button-container {
	display: flex;
	gap: 40px; /* 버튼 사이 간격 */		
}

button {
	font-size: 24px;
	padding: 20px 40px;
	cursor: pointer;
	border: none;
	border-radius: 10px;
	background-color: #4CAF50;
	color: white;
	transition: background-color 0.3s ease;
}

button:hover {
	background-color: #45a049;
}
</style>

</head>
<body>

	<jsp:include page="../include/header.jsp" />

asdf
	<div class="button-container">
		<button
			onclick="location.href='<%=request.getContextPath()%>/parking_in.go'">입차</button>
		<button
			onclick="location.href='<%=request.getContextPath()%>/parking_out.go'">출차</button>
		<button
			onclick="location.href='<%=request.getContextPath()%>/pk_list.go'">주차기록</button>
	</div>
</body>
</html>
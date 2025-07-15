<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
<style type="text/css">
.container {
	max-width: 700px;
	width: 100%;
	background: #fff;
	border-radius: 15px;
	box-shadow: 0 8px 24px rgba(0, 0, 0, 0.1);
	padding: 40px 30px;
	text-align: center;
	margin: 0px auto;
}

#title {
	font-size: 30px;
	font-weight: 800	;
}

#button-goback {
	float: right;
	margin-right: 50px;
}
</style>
</head>
<body>
	<jsp:include page="../../include/header.jsp" />	
	
	<c:set var="psd" value="${Psdetail }" />
	
	<c:if test="${empty psd }">
		<h1>해당 차량의 정보를 불러오지 못했습니다.</h1>
	</c:if>
	
	<div class="container">
		
		<span id="title">상세 정보</span>
		
		<table class="table table-hover">
			<tbody>
				<tr>	
					<th>주차위치</th>
					<td>${psd.floor }층 ${psd.sno }</td>
				</tr>
				
				<tr>	
					<th>차량 번호판</th>
					<td>${psd.car_num }</td>
				</tr>
				
				<tr>	
					<th>입차 시간</th>
					<td>${psd.in_time }</td>
				</tr>
			</tbody>
		</table>
		
		<button class="btn btn-outline-secondary" id="button-goback"
			onclick="history.back()">뒤로가기</button>
		
	</div>

</body>
</html>
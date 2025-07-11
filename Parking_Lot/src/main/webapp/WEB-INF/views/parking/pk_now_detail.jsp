<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
	<jsp:include page="../../include/header.jsp" />	
	
	<c:set var="psd" value="${Psdetail }" />
	
	<c:if test="${empty psd }">
		<h1>psd 없음</h1>
	</c:if>
	
	<div class="container">
		<table class="table table-hover">
			<thead>	
				<tr>
					<th colspan="2">
						상세 정보
					</th>
				</tr>
			</thead>
			
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
	</div>

</body>
</html>
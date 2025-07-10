<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<jsp:include page="../../include/header.jsp" />
	<div align="center">
		<h2>매장 메인 페이지</h2>
	   
	   	<p>로그인 ID : ${loginMember.mem_id }</p>
	   	<p>매장 Code : ${loginMember.store_code }</p>
	   
		<div style="display: flex; justify-content: center; gap: 20px;">
		    <!-- 주차 정산 페이지 이동 버튼 -->
		    <a href="store_parking.go">
		        <button>주차 정산 이동</button>
		    </a>
		
		    <!-- 할인권 구매 페이지 이동 버튼 -->
		    <a href="store_coupon.go">
		        <button>할인권 구매 이동</button>
		    </a>	
	   	</div>
	</div>
</body>
</html>
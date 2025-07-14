<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 메인</title>
</head>
<body>
	<jsp:include page="../../include/header.jsp" />
	<div align="center">
		<h2>관리자 메인 페이지</h2>
	
		<p>로그인 ID : ${loginMember.mem_id}</p>
		<p>로그인 PWD : ${loginMember.mem_pwd}</p>
	
		<div style="display: flex; justify-content: center; gap: 20px;">
			<!-- 주차 정산 페이지 이동 버튼 -->
		    <a href="<%=request.getContextPath()%>/parking_out.go">
		        <button>주차 정산 이동</button>
		    </a>
	
			<form action="<%=request.getContextPath()%>/pk_list.go" method="post">
				<input type="submit" value="주차장 사용 내역" />
			</form>
		</div>
	</div>

		
</body>
</html>
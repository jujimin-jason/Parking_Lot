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

	<div align="center">
	   <h2>매장 메인 페이지</h2>
	   
	   <p>로그인 ID : ${loginMember.mem_id }</p>
	   <p>매장 Code : ${loginMember.store_code }</p>
	   
	   <div style="display: flex; justify-content: center; gap: 20px;">
	      <form method="post" action="<%=request.getContextPath()%>/store_payment.go">
	         <input type="submit" value="주차 정산" />
	      </form>
	      
	      <form method="post" action="<%=request.getContextPath()%>/store_discount_ticket.go">
	         <input type="submit" value="할인권 구매" />
	      </form>
	   
	   </div>
	</div>
</body>
</html>
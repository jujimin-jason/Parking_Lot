<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>주차장 현황 view page</title>
</head>
<body>

	<jsp:include page="../../include/header.jsp" />	
	
	<div class="container">
		<c:set var="pspace" value="${Pspace }" />
		
		<div>
			<c:if test="${empty pspace }">
				<span>주차장 정보를 불러오지 못했습니다..</span>
			</c:if>
		</div>
		
		<div>
		  <c:if test="${!empty pspace}">
		    <c:forEach items="${pspace}" var="space" varStatus="status">
		    	<c:if test="${space.state == 'N'}">
		      		<button class="btn btn-info">${space.sno}</button>
		      	</c:if>
		      	
		      	<c:if test="${space.state == 'Y'}">
		      		<button class="btn btn-danger">${space.sno}</button>
		      	</c:if>
		      <c:if test="${status.count % 10 == 0}">
		        <br/>
		      </c:if>
		    </c:forEach>
		  </c:if>
		</div>

		
	</div>
</body>
</html>
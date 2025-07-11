<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>주차장 현황 view page</title>
<style type="text/css">
	#full {
		width: 5%;
		height: 75px;
		margin: 5px;
	}
	
	#empty {
		width: 5%;
		height: 75px;
		margin: 5px;
	}
</style>
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
		
		<!-- 주차장 현황 출력 -->
		<div>
		  <c:if test="${!empty pspace}">
		    <c:forEach items="${pspace}" var="space" varStatus="status">
		    	<c:if test="${space.state == 'N'}">
		      		<button class="btn btn-info" id="full" 
		      		onclick="loaction.href='<%=request.getContextPath() %>/pk_now_detail.go?sid=${space.sid }'">
		      			${space.sno}
		      		</button>
		      	</c:if>
		      	
		      	<c:if test="${space.state == 'Y'}">
		      		<button class="btn btn-danger" id="empty" 
		      		onclick="loaction.href='<%=request.getContextPath() %>/pk_now_detail.go?sid=${space.sid }'">
		      			${space.sno}
		      		</button>
		      	</c:if>
		      <c:if test="${status.count % 10 == 0}">
		        <br/>
		      </c:if>
		    </c:forEach>
		  </c:if>
		</div>
		<br>
		
		<div class="d-grid gap-2 col-3 mx-auto">
		    <c:forEach var="i" begin="1" end="3">
		        <c:choose>
		            <c:when test="${param.floor == i}">
		                <button class="btn btn-primary" onclick="location.href='<%=request.getContextPath() %>/pk_now.go?floor=${i}'">
		                    ${i}층
		                </button>
		            </c:when>
		            <c:otherwise>
		                <button class="btn btn-secondary" onclick="location.href='<%=request.getContextPath() %>/pk_now.go?floor=${i}'">
		                    ${i}층
		                </button>
		            </c:otherwise>
		        </c:choose>
		    </c:forEach>
		</div>
		

		
	</div>
</body>
</html>
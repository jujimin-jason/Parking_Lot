<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>주차장 현황</title>
<style type="text/css">
#main-holder {
	max-width: 1000px;
	width: 100%;
	background: #fff;
	border-radius: 15px;
	box-shadow: 0 8px 24px rgba(0, 0, 0, 0.1);
	padding: 40px 30px;
	text-align: center;
	margin: 0px auto;
}

.container {
	display: flex;
	flex-direction: rows;
	flex-wrap: nowrap;
	justify-content: center;
	gap: 10px;
	margin-top: 20px;
}

.container-pspace {
	flex: none;	
	order: 0;
	padding-left: 250px;
}

.container-floor {
	display: flex;
	flex-direction: column;
	order: 1;
	justify-content: center;
	flex: 1;	
}

.container-pspace > button {
	width: 7.5%;
	max-width: 53px;
	min-width: 25px;
	height: 75px;
	margin: 5px;
}

.container-floor > button {
	margin: 10px;
	height: 50px;
	width: 100px;
}

.description {
	margin-top: 50px;
}
</style>
</head>
<body>

	<jsp:include page="../../include/header.jsp" />	
	
	<div id="main-holder">
		<div class="container">
			<c:set var="pspace" value="${Pspace }" />
			
			<div>
				<c:if test="${empty pspace }">
					<span>주차장 정보를 불러오지 못했습니다..</span>
				</c:if>
			</div>
			
			<!-- 주차장 현황 출력 -->
			<div class="container-pspace">
			  <c:if test="${!empty pspace}">
			    <c:forEach items="${pspace}" var="space" varStatus="status">
			    	<c:if test="${space.state == 'N'}">
			      		<button class="btn btn-info"
			      		onclick="alert('해당 자리는 비어있습니다.')">
			      			${space.sno}
			      		</button>
			      	</c:if>
			      	
			      	<c:if test="${space.state == 'Y'}">
			      		<button class="btn btn-danger" 
			      		onclick="location.href='pk_now_detail.go?sid=${space.sid}'">
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
				<div class="container-floor">
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
		</div>
		
		<div class="description">
			<span>※ 특정 주차공간을 선택하시면 해당 공간의 정보가 화면에 출력됩니다. </span>
		</div>
	</div>
</body>
</html>
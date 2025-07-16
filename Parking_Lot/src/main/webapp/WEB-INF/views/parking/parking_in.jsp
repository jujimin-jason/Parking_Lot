<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>입차</title>
<style type="text/css">
#main-holder {
	max-width: 900px;
	background: #fff;
	border-radius: 15px;
	box-shadow: 0 8px 24px rgba(0, 0, 0, 0.1);
	padding: 40px 30px;
	text-align: center;
	margin: 0px auto;
}


.cont {
	display: flex;
	justify-content: center;
	align-items: flex-start;
	padding: 45px 20px;
	gap: 40px;
}

.container-pspace {
	display: flex;
	flex-direction: column;
	align-items: center;
}

.line-row {
	display: flex;
	justify-content: center;
	margin-bottom: 10px;
}

.line-row button {
	width: 50px;
	height: 70px;
	margin: 3px;
	border: none;
	border-radius: 8px;
	font-weight: bold;
	transition: all 0.3s ease;
}

.line-row button.btn-info {
	background-color: #0dcaf0;
	color: black;
}

.line-row button.btn-info:hover {
	background-color: #0aa5cc;
	transform: translateY(-3px);
	box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2);
}

.line-row button.btn-danger {
	background-color: #ff6b6b;
	color: white;
}

.line-row button.btn-danger:hover {
	background-color: #e55050;
	transform: translateY(-3px);
	box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2);
}

.container-floor {
	display: flex;
	flex-direction: column;
	align-items: center;
	gap: 10px;
}

.container-floor button {
	width: 80px;
	height: 50px;
	font-weight: bold;
	border: none;
	border-radius: 8px;
	transition: all 0.3s ease;
}

.container-floor button.btn-primary {
	background-color: #0d6efd;
	color: white;
}

.container-floor button.btn-primary:hover {
	background-color: #0a58ca;
	transform: translateY(-2px);
	box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2);
}

.container-floor button.btn-secondary {
	background-color: #6c757d;
	color: white;
}

.container-floor button.btn-secondary:hover {
	background-color: #565e64;
	transform: translateY(-2px);
	box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2);
}

.description {
	text-align: center;
	margin-top: 30px;
	font-size: 1.1rem;
	color: #333;
	font-weight: bold;
}

@media ( max-width : 728px) {
	.line-row button { /* 칸 */
		width: 35px;
		height: 55px;
		font-size: 0.8rem;
		display: flex;
		justify-content: center;
		align-items: center;
	}
	.container-floor button { /* 층 */
		width: 60px;
		height: 40px;
		font-size: 0.7rem;
		display: flex;
		justify-content: center;
		align-items: center;
	}
	.cont {
		display: flex;
		flex-direction: column;
		justify-content: center;
		align-items: center;
		padding: 45px 20px;
		gap: 20px;
	}
	.container-floor {
		display: flex;
		flex-direction: row;
		justify-content: center;
		align-items: center;
		gap: 10px;
	}
}
</style>

</head>
<body>
	<jsp:include page="../../include/header.jsp" />
	<div class="cont">
		<c:set var="pspace" value="${Pspace }" />
		
		<c:if test="${empty pspace}">
			<div>
				<span>주차장 정보를 불러오지 못했습니다..</span>
			</div>
		</c:if>
		
		<!-- 주차장 현황 출력 -->
		<div class="container-pspace">
			<c:if test="${!empty pspace}">
				<c:forEach items="${pspace}" var="space" varStatus="status">
					<c:if test="${status.first or status.index % 10 == 0}">
						<div class="line-row">
					</c:if>

					<c:if test="${space.state == 'N'}">
						<button class="btn btn-info"
							onclick="if(confirm('${space.floor }층 ${space.sno } 에 입차하시겠습니까?')) {
		      					location.href='parking_in_ok.go?sid=${space.sid }'
		      					}else { return; }">
							${space.sno}</button>
					</c:if>

					<c:if test="${space.state == 'Y'}">
						<button class="btn btn-danger"
							onclick="alert('해당 자리에는 차량이 있습니다. 빈 자리를 찾아주세요.')">
							${space.sno}</button>
					</c:if>

					<c:if test="${(status.index + 1) % 10 == 0 or status.last}">
		</div>
		</c:if>
		</c:forEach>
		</c:if>
	</div>

	<div class="container-floor">
		<c:forEach var="i" begin="1" end="3">
			<c:choose>
				<c:when test="${param.floor == i}">
					<button class="btn btn-primary"
						onclick="location.href='<%=request.getContextPath() %>/parking_in.go?floor=${i}'">
						${i}층</button>
				</c:when>
				<c:otherwise>
					<button class="btn btn-secondary"
						onclick="location.href='<%=request.getContextPath() %>/parking_in.go?floor=${i}'">
						${i}층</button>
				</c:otherwise>
			</c:choose>
		</c:forEach>
	</div>
	</div>

	<div class="description">
		<p>※ 빈 자리를 선택해주시면 해당 자리에 랜덤한 차량이 입차합니다.</p>
	</div>
</body>
</html>

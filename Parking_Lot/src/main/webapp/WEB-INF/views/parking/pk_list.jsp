<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주차 기록 view 페이지</title>
<style type="text/css">
.listpage {
	
}
</style>
</head>
<body>

	<jsp:include page="../../include/header.jsp" />

	<div id="listpage" class="container">
		<c:set var="pkList" value="${pkList }" />
		<c:set var="paging" value="${Paging }" />

		<div class="d-flex justify-content-center">
			<table class="table">

				<thead>
					<tr class="table-dark">
						<td colspan="5" align="right">전체 입차 기록 수 :
							${paging.totalRecord }</td>
					</tr>

					<tr class="table-secondary">
						<th>ID</th>
						<th>차량 번호</th>
						<th>입차 시간</th>
						<th>출차 시간</th>
						<th>정산 요금</th>
					</tr>
				</thead>

				<tbody>
					<c:if test="${empty pkList }">
						<tr>
							<td colspan="5">입차목록이 없습니다.</td>
						</tr>
					</c:if>

					<c:if test="${!empty pkList }">
						<c:forEach items="${pkList }" var="dto">
							<tr>
								<td>${dto.pid }</td>
								<td>${dto.car_num }</td>
								<td>${dto.in_time }</td>
								<td>${dto.out_time }</td>
								<td>${dto.amount }원</td>
							</tr>
						</c:forEach>
					</c:if>
				</tbody>

			</table>

		</div>
		

		<!-- 페이징 처리 영역 -->
		<c:if test="${paging.page > paging.block }">
			<a href="<%=request.getContextPath()%>/pk_list.go?page=1">맨 처음</a>
			<a
				href="<%=request.getContextPath() %>/pk_list.go?page=${paging.startBlock - 1 }">◀</a>
		</c:if>

		<c:forEach begin="${paging.startBlock }" end="${paging.endBlock }"
			var="i">
			<c:if test="${i == paging.page }">
				<b><a
					href="<%=request.getContextPath() %>/pk_list.go?page=${i }">${i }</a></b>
			</c:if>

			<c:if test="${i != paging.page }">
				<a href="<%=request.getContextPath() %>/pk_list.go?page=${i }">${i }</a>
			</c:if>
		</c:forEach>

		<c:if test="${paging.endBlock < paging.allPage }">
			<a
				href="<%=request.getContextPath() %>/pk_list.go?page=${paging.endBlock + 1}">▶</a>
			<a
				href="<%=request.getContextPath() %>/pk_list.go?page=${paging.allPage }">맨
				마지막</a>
		</c:if>
		
		<br><br>
		
		<button
			onclick="location.href='<%=request.getContextPath()%>/pk_list.go'"
			class="btn btn-secondary">전체 목록</button>

		<br><br>

		<!-- 검색 폼 영역 -->
		<form method="post"
			action="<%=request.getContextPath()%>/pk_search_detail.go">	
			<b>상세 정보로 검색</b>
			<br>
			<input name="car_num" placeholder="차량 뒤 네자리 입력"> 
			<br>
			<input type="date" name="date">
			<input type="submit" value="검색">
		</form>

	</div>


</body>
</html>
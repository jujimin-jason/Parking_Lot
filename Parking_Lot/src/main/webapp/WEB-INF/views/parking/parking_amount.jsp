<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>출차 정산 확인</title>
<style>
body {
	font-family: sans-serif;
	background-color: #f4f4f4;
	padding: 30px;
	text-align: center;
}

table {
	margin: 0 auto;
	border-collapse: collapse;
	width: 600px;
	background: #fff;
}

th, td {
	border: 1px solid #444;
	padding: 12px;
}

th {
	background-color: #e0e0e0;
}

h1 {
	margin-bottom: 30px;
}

.btn-area {
	margin-top: 20px;
}

.btn {
	padding: 10px 20px;
	margin: 0 10px;
	font-size: 16px;
	cursor: pointer;
}
</style>
</head>
<body>

	<jsp:include page="../../include/header.jsp" />

	<h1>출차 정보 정산</h1>

	<table>
		<tr>
			<th>차량 번호</th>
			<th>입차 시간</th>
			<th>출차 시간</th>
			<th>총 요금</th>
		</tr>
		<tr>
			<td>${pking.car_num}</td>
			<td>${pking.in_time}</td>
			<td>${amount.pay_time}</td>
			<td>${amount.amount}원</td>
		</tr>
	</table>

	<div class="btn-area">
		<form method="post"
			action="<%=request.getContextPath()%>/parking_out_ok.go"
			style="display: inline;">
			<input type="hidden" name="car_num" value="${pking.car_num}" /> <input
				type="hidden" name="pay_time" value="${amount.pay_time}" /> <input
				type="hidden" name="amount" value="${amount.amount}" /> <input
				type="hidden" name="aid" value="${pking.pid}" />
			<button type="submit" class="btn">확인</button>
		</form>

		<button type="button" class="btn" onclick="history.back();">취소</button>
	</div>

</body>
</html>

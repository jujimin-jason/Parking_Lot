<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 메인</title>

<!-- Bootstrap 5 -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
	rel="stylesheet" />
<!-- Font Awesome -->
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css"
	rel="stylesheet" />

<style>
#main-holder {
	background: #fff;
	padding: 40px 30px;
	border-radius: 15px;
	box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
	width: 100%;
	max-width: 700px;
	min-height: 300px;

	display: flex;
	flex-direction: column;
	justify-content: center;
	align-items: center;

	text-align: center;
	margin: 100px auto;
}

h2 {
	font-size: 2.2rem;
	font-weight: 800;
	color: #0d6efd;
	margin-bottom: 20px;
}

.custom-divider {
	border-top: 2px solid #dee2e6;
	width: 100%;
	margin-bottom: 30px;
}

.btn-group-custom {
	display: flex;
	gap: 20px; /* 버튼 사이 간격 */
	justify-content: center;
}
</style>
</head>
<body>
 

 
		<div id="main-holder">
			<h2>관리자 메인 페이지</h2>
			<hr class="custom-divider" />
		
			<div class="btn-group-custom">
				<button class="btn btn-primary" onclick="location.href='/parking_out.go'">
					🔧 주차 사전 정산 페이지
				</button>
				<button class="btn btn-primary" onclick="location.href='/pk_list.go'">
					🚗 주차장 사용 내역
				</button>
			</div>
		</div>
 
	<!-- Bootstrap JS -->
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
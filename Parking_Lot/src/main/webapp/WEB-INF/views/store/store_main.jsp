<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>매장 메인 페이지</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet" />
<style>
 
    .card {
        max-width: 600px;
        width: 100%;
        border-radius: 15px;
        box-shadow: 0 8px 24px rgba(0,0,0,0.1);
        padding: 40px 35px;
        margin: 50px auto;
    }
    h2 {
        font-size: 2.75rem;
        font-weight: 900;
    }
    .info-text {
        font-size: 1.4rem;
        margin-bottom: 10px;
    }
    .btn-custom {
        width: 100%;
        font-weight: 700;
        font-size: 1.3rem;
        border-radius: 50px;
        padding: 16px 0;
        transition: background-color 0.3s ease;
    }
    .btn-custom:hover {
        filter: brightness(90%);
    }
</style>
</head>
<body>

	<jsp:include page="../../include/header.jsp" />
	
	<div class="card bg-white text-center">
		<h2 class="mb-4 fw-bold text-primary">매장 메인 페이지</h2>
		
		<div class="mb-4">
			<p class="info-text"><strong>로그인 ID :</strong> ${loginMember.mem_id}</p>
			<p class="info-text"><strong>매장 Code :</strong> ${loginMember.store_code}</p>
		</div>
		
		<div class="d-grid gap-3">
			<a href="store_parking_list.go" class="btn btn-primary btn-custom">
				<i class="bi bi-car-front me-2"></i> 주차 차량선택 이동
			</a>
			<a href="store_coupon.go" class="btn btn-success btn-custom">
				<i class="bi bi-ticket-perforated me-2"></i> 할인권 구매 이동
			</a>
		</div>
	</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
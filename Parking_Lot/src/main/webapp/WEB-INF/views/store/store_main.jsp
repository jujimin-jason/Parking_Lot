<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>매장 메인 페이지</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0"> <!-- ✅ 모바일 대응용 뷰포트 설정 -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet" />
<style>
/* 카드 스타일 */
.card {
    max-width: 600px;
    width: 100%;
    border-radius: 15px;
    box-shadow: 0 8px 24px rgba(0,0,0,0.1);
    padding: 40px 35px;
    margin: 50px auto;
}

/* 버튼 커스텀 스타일 */
.btn-custom {
    padding: 12px 20px;
    font-size: 1.1rem;
    border-radius: 10px;
    transition: all 0.3s ease;
}

.btn-custom:hover {
    transform: translateY(-2px);
    box-shadow: 0 6px 14px rgba(0, 0, 0, 0.15);
}

.info-text {
    font-size: 1rem;
    color: #333;
}

/* 모바일/작은 화면 */
@media (max-width: 700px) {
    .card {
    	max-width: 95%;
        padding: 30px 20px;
        margin: 30px auto;
    }

    .btn-custom {
        font-size: 1rem;
        padding: 10px 16px;
    }

    .info-text {
        font-size: 0.95rem;
    }
}
</style>
</head>
<body>

    <jsp:include page="../../include/header.jsp" /> <!-- ✅ 공통 헤더 포함 -->

    <div class="card bg-white text-center">
        <h2 class="mb-4 fw-bold text-primary">매장 메인 페이지</h2>
        
        <!-- 로그인 정보 출력 -->
        <div class="mb-4">
            <p class="info-text"><strong>로그인 ID :</strong> ${loginMember.mem_id}</p>
            <p class="info-text"><strong>매장 Code :</strong> ${loginMember.store_code}</p>
        </div>
        
        <!-- 버튼 영역 -->
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

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>매장 주차 정산 페이지</title>
<style>
/* 전체 배경 스타일 */
body {
    background: linear-gradient(135deg, #74ebd5, #acb6e5);
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    margin: 0;
    padding: 0;
}

/* 메인 카드 스타일 */
.card {
    max-width: 500px;
    margin: 60px auto;
    background: #fff;
    border-radius: 20px;
    box-shadow: 0 12px 40px rgba(0, 0, 0, 0.2);
    overflow: hidden;
    text-align: center;
    padding: 40px 30px;
}

.card h1 {
    margin: 0;
    color: #0d6efd;
    font-size: 1.8rem;
}

.card p {
    margin: 10px 0;
    font-size: 1rem;
    color: #555;
}

.info-section {
    background: #f0f4ff;
    border-radius: 12px;
    padding: 20px;
    margin: 20px 0;
    text-align: left;
}

.info-section p {
    margin: 8px 0;
}

button {
    padding: 5px 17px;
    margin: 8px 5px;
    font-size: 1rem;
    border: none;
    border-radius: 8px;
    background: #0d6efd;
    color: white;
    cursor: pointer;
    transition: all 0.3s ease;
}

button:hover {
    background: #0b5ed7;
    transform: translateY(-2px);
    box-shadow: 0 6px 12px rgba(0,0,0,0.15);
}

.no-car-text {
    color: #ff4d4f;
    margin-top: 20px;
}
</style>
</head>
<body>
	<jsp:include page="../../include/header.jsp" />
    <div class="card">
        <h1>매장 주차 정산</h1>
        <p>할인권을 적용할 차량 정보를 확인하세요.</p>

        <c:if test="${not empty car}">
            <div class="info-section">
                <p><strong>차량번호:</strong> ${car.car_num}</p>
                <p><strong>입차 시간:</strong> ${car.in_time}</p>
                <p><strong>주차 시간:</strong> ${parkingTimeStr}</p>
                <p><strong>할인 시간:</strong> ${discountTime}분</p>
                <p><strong>할인 후 주차 시간:</strong> ${discountedTimeStr}</p>

                <c:if test="${not empty adminCoupons}">
                    <p><strong>남은 30분 쿠폰:</strong> ${adminCoupons.dc_coupon_30m}장</p>
                    <p><strong>남은 1시간 쿠폰:</strong> ${adminCoupons.dc_coupon_1h}장</p>
                </c:if>
            </div>

            <!-- 할인 쿠폰 적용 폼 -->
            <form action="apply_coupon.go" method="post" style="display:inline;">
                <input type="hidden" name="car_num" value="${car.car_num}">
                <button type="submit" name="discount" value="30">30분 할인</button>
                <button type="submit" name="discount" value="60">1시간 할인</button>
            </form>
        </c:if>

        <c:if test="${empty car}">
            <p class="no-car-text">🚫 차량 정보가 없습니다. 다시 선택해주세요.</p>
        </c:if>

        <a href="store_page.go">
            <button style="margin-top: 15px;">← 매장 페이지로 돌아가기</button>
        </a>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>매장주차 정산 페이지</title>
</head>
<body>
	<!-- 공통 헤더 포함 -->
	<jsp:include page="../../include/header.jsp" />

    <!-- 페이지 제목 -->
    <h1>매장주차 정산 페이지</h1>

    <!-- 차량번호 뒷자리 검색 폼 -->
    <form action="store_parking_ok.go" method="get">
        <label>차량번호 뒷자리 4자리:</label>
        <input type="text" name="car_back" maxlength="4" required>
        <button type="submit">검색</button>
    </form>
    <br>

    <!-- 차량 검색 결과가 있을 때 표시 -->
    <c:if test="${not empty car}">
	    <!-- 차량 정보 출력 -->
	    <p>전체 차량번호: ${car.car_num}</p>
	    <p>입차 시간: ${car.in_time}</p>
	    <p>주차 시간: ${parkingTimeStr}</p>
	    <p>할인 시간: ${discountTime}분</p>
	    <p>할인 적용 후 주차 시간: ${discountedTimeStr}</p>

        <!-- 관리자 쿠폰 개수 표시 -->
        <c:if test="${not empty adminCoupons}">
            <p>남은 30분 쿠폰: ${adminCoupons.dc_coupon_30m}장</p>
            <p>남은 1시간 쿠폰: ${adminCoupons.dc_coupon_1h}장</p>
        </c:if>
	
	    <!-- 할인 쿠폰 적용 폼 -->
	    <form action="apply_coupon.go" method="post">
	        <input type="hidden" name="car_num" value="${car.car_num}">
	        <button type="submit" name="discount" value="30">30분 할인</button>
	        <button type="submit" name="discount" value="60">1시간 할인</button>
	    </form>
	    <br>
	    
	    <!-- 최종 할인 적용 버튼 폼 (예비용 버튼, 실제 동작에 맞게 사용 여부 결정) -->
	    <form action="apply_coupon_ok.go" method="post">
		    <input type="hidden" name="car_num" value="${car.car_num}">
		    <button type="submit">할인 적용</button>
		</form>
	</c:if>
	<br>

    <!-- 매장 페이지로 돌아가기 버튼 -->
    <a href="store_page.go">
        <button>← 매장 페이지로 돌아가기</button>
    </a>
</body>
</html>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주차 정산 페이지</title>
</head>
<body>
    <h1>주차 정산 페이지</h1>

    <!-- 차량번호 뒷자리 검색 폼 -->
    <form action="store_parking_ok.go" method="get">
        <label>차량번호 뒷자리 4자리:</label>
        <input type="text" name="car_back" maxlength="4" required>
        <button type="submit">검색</button>
    </form>
    <br>

    <!-- 검색 결과 표시 -->
    <c:if test="${not empty car}">
	    <p>전체 차량번호: ${car.car_num}</p>
	    <p>입차 시간: ${car.in_time}</p>
	    <p>주차 시간: ${parkingTime}분</p>
	    <p>할인 적용 후 주차 시간: ${discountedTime}분</p>
	
	    <form action="apply_coupon.go" method="post">
	        <input type="hidden" name="car_num" value="${car.car_num}">
	        <button type="submit" name="discount" value="30">30분 할인 적용</button>
	        <button type="submit" name="discount" value="60">1시간 할인 적용</button>
	    </form>
	</c:if>
	<br>

    <!-- 메인으로 돌아가기 버튼 -->
    <a href="store_page.go">
        <button>← 매장 페이지로 돌아가기</button>
    </a>
</body>
</html>

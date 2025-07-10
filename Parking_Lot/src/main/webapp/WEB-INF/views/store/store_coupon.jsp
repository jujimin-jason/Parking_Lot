<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>할인권 구매 페이지</title>
</head>
<body>
	<!-- 공통 헤더 포함 -->
	<jsp:include page="../../include/header.jsp" />
	
    <!-- 페이지 제목 -->
    <h1>할인권 구매 페이지</h1>
    
    <!-- 할인권 구매 폼 -->
    <form action="coupon_buy.go" method="post">
        <!-- 할인권 종류 선택 -->
        <label>할인권 종류:</label>
        <select name="coupon_type" required>
            <option value="">--- 선택하세요 ---</option>
            <option value="30분">30분 할인권</option>
            <option value="1시간">1시간 할인권</option>
        </select>
        <br><br>
        
        <!-- 수량 입력 -->
        <label>수량:</label>
        <input type="number" name="quantity" min="1" value="1" required>
        <br><br>
        
        <!-- 구매하기 버튼 -->
        <button type="submit">구매하기</button>
    </form>
	<br>
	
    <!-- 매장 페이지로 돌아가기 버튼 -->
    <a href="store_page.go">
        <button>← 매장 페이지로 돌아가기</button>
    </a>
</body>
</html>

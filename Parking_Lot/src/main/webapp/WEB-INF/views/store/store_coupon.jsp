<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>할인권 구매 페이지</title>
<style>
/* 전체 배경 스타일 */
body {
    background: linear-gradient(135deg, #bef7ed, #d0d7f7);
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    margin: 0;
    padding: 0;
}

/* 카드 스타일 */
.card {
    max-width: 500px;
    width: 90%;
    background: #fff;
    border-radius: 18px;
    box-shadow: 0 12px 30px rgba(0, 0, 0, 0.1);
    padding: 40px 30px;
    text-align: center;
    margin: 60px auto;
}

.card h1 {
    margin-top: 0;
    color: #0d6efd;
    font-size: 1.8rem;
}

label {
    font-weight: bold;
    display: block;
    margin-top: 15px;
    margin-bottom: 5px;
    text-align: left;
}

select, input[type="number"] {
    padding: 10px;
    font-size: 1rem;
    width: 100%;
    border-radius: 8px;
    border: 1px solid #ced4da;
    margin-bottom: 15px;
}

button {
    padding: 10px 25px;
    font-size: 1rem;
    border-radius: 8px;
    border: none;
    background-color: #0d6efd;
    color: #fff;
    cursor: pointer;
    transition: all 0.3s ease;
    margin: 10px 5px;
}

button:hover {
    background-color: #45a049;
    
}
</style>
</head>
<body>
    <!-- 공통 헤더 포함 -->
    <jsp:include page="../../include/header.jsp" />

    <div class="card">
        <h1>할인권 구매 페이지</h1>

        <!-- 할인권 구매 폼 -->
        <form action="coupon_buy.go" method="post">
            <label>할인권 종류:</label>
            <select name="coupon_type" required>
                <option value="">--- 선택하세요 ---</option>
                <option value="30분">30분 할인권</option>
                <option value="1시간">1시간 할인권</option>
            </select>

            <label>수량:</label>
            <input type="number" name="quantity" min="1" value="1" required>

            <button type="submit">구매하기</button>
        </form>

        <a href="store_page.go">
            <button style="margin-top: 10px;">← 매장 페이지로 돌아가기</button>
        </a>
    </div>
</body>
</html>

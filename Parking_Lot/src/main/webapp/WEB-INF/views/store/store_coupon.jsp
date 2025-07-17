<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>할인권 구매 페이지</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0"> <!-- ✅ 모바일 대응 뷰포트 -->
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

/* 라벨 스타일 */
label {
    font-weight: bold;
    display: block;
    margin-top: 15px;
    margin-bottom: 5px;
    text-align: left;
}

/* select와 숫자 입력창 스타일 */
select, input[type="number"] {
    padding: 10px;
    font-size: 1rem;
    width: 100%;
    border-radius: 8px;
    border: 1px solid #ced4da;
    margin-bottom: 15px;
}

/* 버튼 스타일 */
.pp {
    padding: 10px 25px;
    font-size: 1rem;
    border-radius: 8px;
    border: none;
    background-color: #0dcaf0;
    color: #fff;
    cursor: pointer;
    transition: all 0.3s ease;
    margin: 10px 5px;
}

/* 버튼 hover 효과 */
button:hover {
    background-color: #45a049;
    transform: translateY(-2px);
    box-shadow: 0 6px 14px rgba(0, 0, 0, 0.15);
}

/* 모바일/작은 화면 */
@media (max-width: 600px) {
    .card {
    	max-width: 95%;
        padding: 30px 20px;
    }

    .card h1 {
        font-size: 1.5rem;
    }

    button {
        font-size: 0.95rem;
        padding: 8px 20px;
    }

    select, input[type="number"] {
        font-size: 0.95rem;
    }
}
</style>
</head>
<body>
    <!-- ✅ 공통 헤더 포함 -->
    <jsp:include page="../../include/header.jsp" />

    <div class="card">
        <h1>할인권 구매 페이지</h1>

        <!-- ✅ 할인권 구매 폼 -->
        <form action="coupon_buy.go" method="post">
            <label>할인권 종류:</label>
            <select name="coupon_type" required>
                <option value="">--- 선택하세요 ---</option>
                <option value="30분">30분 할인권</option>
                <option value="1시간">1시간 할인권</option>
            </select>

            <label>수량:</label>
            <input type="number" name="quantity" min="1" value="1" required>

            <button class="pp" type="submit">구매하기</button>
        </form>

        <!-- ✅ 돌아가기 버튼 -->
        <a href="store_page.go">
            <button class="pp" style="margin-top: 10px;">← 매장 페이지로 돌아가기</button>
        </a>
    </div>
</body>
</html>

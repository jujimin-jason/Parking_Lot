<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>차량 선택 페이지</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0"> <!-- ✅ 모바일 대응 뷰포트 -->

<style>
/* 전체 배경 스타일 */
body {
    background: linear-gradient(135deg, #bef7ed, #d0d7f7);
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    margin: 0;
    padding: 0;
}

/* 메인 컨테이너 */
#main-holder {
    max-width: 700px;
    width: 100%;
    background: #fff;
    border-radius: 15px;
    box-shadow: 0 8px 24px rgba(0, 0, 0, 0.1);
    padding: 40px 30px;
    text-align: center;
    margin: 60px auto;
}

/* 제목 스타일 */
#main-holder h3 {
    font-size: 2rem;
    font-weight: 800;
    margin-bottom: 10px;
    color: #0d6efd;
}

/* 부제목 스타일 */
#main-holder p.sub-text {
    margin-top: 0;
    font-size: 1rem;
    color: #6c757d;
}

/* 구분선 스타일 */
.custom-divider {
    border-top: 2px solid #5c5c5c;
    margin: 20px 0;
}

/* 테이블 스타일 */
table {
    margin: 20px auto;
    border-collapse: collapse;
    width: 100%;
}

thead {
    background-color: #0d6efd;
    color: #fff;
}

table, th, td {
    border: 1px solid #dee2e6;
}

th, td {
    padding: 12px;
    text-align: center;
}

/* 버튼 스타일 */
.pp {
    padding: 8px 18px;
    font-size: 0.95rem;
    border-radius: 8px;
    border: none;
    background-color: #0dcaf0;
    color: #fff;
    cursor: pointer;
    transition: 0.3s;
}

button:hover {
    background-color: #45a049;
    transform: translateY(-2px);
    box-shadow: 0 6px 14px rgba(0, 0, 0, 0.15);
}

/* 검색 입력창 스타일 */
input[type="text"] {
    padding: 10px;
    font-size: 1rem;
    width: 180px;
    border-radius: 8px;
    border: 1px solid #ced4da;
    margin-right: 10px;
}

/* 모바일/작은 화면 대응 */
@media (max-width: 600px) {
    #main-holder {
    	max-width: 95%;
        padding: 30px 20px;
    }

    #main-holder h3 {
        font-size: 1.6rem;
    }

    button {
        font-size: 0.85rem;
        padding: 7px 15px;
    }

    input[type="text"] {
        width: 140px;
        font-size: 0.9rem;
    }

    th, td {
        padding: 10px;
        font-size: 0.9rem;
    }
}
</style>
</head>
<body>

<jsp:include page="../../include/header.jsp" /> <!-- ✅ 공통 헤더 포함 -->

<div id="main-holder">
    <h3>차량 선택 페이지 🚗</h3>
    <p class="sub-text">검색 후 차량을 선택해 주세요.</p>
    <hr class="custom-divider" />

    <!-- ✅ 차량번호 뒷자리 검색 폼 -->
    <form action="store_parking_list_ok.go" method="get">
        <input type="text" name="car_back" maxlength="4" placeholder="뒷자리 4자리 입력" required>
        <button class="pp" type="submit">검색</button>
    </form>

    <!-- ✅ 검색 결과 있을 때 -->
    <c:if test="${not empty carList}">
        <table>
            <thead>
                <tr>
                    <th>차량번호</th>
                    <th>입차 시간</th>
                    <th>선택</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="car" items="${carList}">
                    <tr>
                        <td>🚗 ${car.car_num}</td>
                        <td>${car.in_time}</td>
                        <td>
                            <form action="store_parking.go" method="get">
                                <input type="hidden" name="car_num" value="${car.car_num}">
                                <button class="pp" type="submit">선택</button>
                            </form>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </c:if>

    <!-- ✅ 검색 결과 없을 때 -->
    <c:if test="${searched and empty carList}">
        <p style="margin-top: 20px; color: #dc3545;">검색된 차량이 없습니다. 다시 입력해 주세요.</p>
    </c:if>
    <hr class="custom-divider" />

    <!-- ✅ 매장 페이지로 돌아가기 버튼 -->
    <a href="store_page.go">
        <button class="pp" style="margin-top: 20px;">← 매장 페이지로 돌아가기</button>
    </a>
</div>

</body>
</html>

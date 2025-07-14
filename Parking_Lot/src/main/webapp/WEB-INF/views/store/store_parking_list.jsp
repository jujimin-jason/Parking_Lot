<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>차량 선택 페이지</title>
<style>
    /* 컨테이너를 중앙 정렬 */
    .container {
        width: 80%;
        margin: 0 auto;
        text-align: center;
    }

    /* 테이블 중앙 정렬 및 스타일 */
    table {
        margin: 20px auto;
        border-collapse: collapse;
        width: 600;
    }

    /* 테이블 테두리 스타일 */
    table, th, td {
        border: 1px solid #333;
    }

    /* 테이블 셀 패딩 */
    th, td {
        padding: 10px;
    }

    /* 버튼 스타일 */
    button {
        padding: 5px 15px;
    }
</style>
</head>
<body>
    <!-- 공통 헤더 JSP 포함 (header.jsp를 불러옴) -->
    <jsp:include page="../../include/header.jsp" />

    <div class="container">
        <h1>차량 선택 페이지</h1>

        <!-- 차량번호 뒷자리 검색 폼 -->
        <form action="store_parking_list_ok.go" method="get">
            <label>차량번호 뒷자리 4자리:</label>
            <input type="text" name="car_back" maxlength="4" required>
            <button type="submit">검색</button>
        </form>

        <!-- 검색 결과가 있을 경우에만 표시 -->
        <c:if test="${not empty carList}">
            <h3>검색 결과</h3>

            <!-- 검색된 차량 목록 출력 테이블 -->
            <table>
                <tr>
                    <th>차량번호</th>
                    <th>입차 시간</th>
                    <th>선택</th>
                </tr>

                <!-- 검색된 차량 리스트 반복 출력 -->
                <c:forEach var="car" items="${carList}">
                    <tr>
                        <!-- 차량번호 -->
                        <td>${car.car_num}</td>
                        <!-- 입차 시간 -->
                        <td>${car.in_time}</td>
                        <!-- 선택 버튼: 선택 시 해당 차량번호를 store_parking.go로 전달 -->
                        <td>
                            <form action="store_parking.go" method="get">
                                <input type="hidden" name="car_num" value="${car.car_num}">
                                <button type="submit">선택</button>
                            </form>
                        </td>
                    </tr>
                </c:forEach>
            </table>
        </c:if>
        <!-- 매장 페이지로 돌아가기 버튼 -->
	    <a href="store_page.go">
	        <button>← 매장 페이지로 돌아가기</button>
	    </a>
    </div>
</body>
</html>


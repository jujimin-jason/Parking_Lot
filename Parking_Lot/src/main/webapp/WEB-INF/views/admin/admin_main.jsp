<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>관리자 메인</title>

  <!-- Bootstrap 5 -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
  <!-- Font Awesome -->
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet" />

  <style>
 

    #main-holder {
      background: #f5f5f5;
      padding: 40px 30px;
      border-radius: 15px;
      box-shadow: 0 10px 30px rgba(0,0,0,0.1);
      width: 100%;
      max-width: 700px;
      text-align: center;
      margin: 0px auto;
    }

    h2 {
      font-size: 2.2rem;
      font-weight: 800;
      color: #0d6efd;
      margin-bottom: 30px;
    }

    .custom-divider {
      border-top: 2px solid #dee2e6;
      margin: 25px 0;
    }

    .btn-wrapper {
      display: flex;
      flex-direction: column;
      gap: 20px;
    }

    .btn-wrapper form input[type="submit"] {
      width: 100%;
      padding: 14px;
      font-size: 1.1rem;
      font-weight: 600;
      border-radius: 10px;
      border: none;
      color: #fff;
      background-color: #0d6efd;
      transition: background-color 0.3s ease;
    }

    .btn-wrapper form input[type="submit"]:hover {
      background-color: #0a58ca;
    }

    .btn-wrapper form i {
      margin-right: 10px;
    }
  </style>
</head>
<body>
	<jsp:include page="../../include/header.jsp" />

<<<<<<< HEAD
  <jsp:include page="../../include/header.jsp" />
=======
	<div align="center">
		<h2>관리자 메인 페이지</h2>

		<p>로그인 ID : ${loginMember.mem_id}</p>
		<p>로그인 PWD : ${loginMember.mem_pwd}</p>

		<div style="display: flex; justify-content: center; gap: 20px;">
			<!-- 주차 정산 페이지 이동 버튼 -->
			<button class="btn btn-secondary"
				onclick="location.href='<%=request.getContextPath()%>/parking_out.go'">주차
				정산 이동</button>

			<button class="btn btn-secondary"
				onclick="location.href='<%=request.getContextPath()%>/pk_list.go'">주차장
				사용 내역</button>

			<button class="btn btn-secondary"
				onclick="location.href='<%=request.getContextPath()%>/pk_now.go?floor=1'">주차장
				현황</button>
		</div>
	</div>
>>>>>>> branch 'main' of https://github.com/suhyun-dev/Parking_Lot.git

<<<<<<< HEAD
  <div id="main-holder">
    <h2>관리자 메인 페이지</h2>
    <hr class="custom-divider" />

    <div class="btn-wrapper">
      <form action="${pageContext.request.contextPath}/parepay_list.go" method="post">
        <input type="submit" value="🔧 주차 사전 정산 페이지" />
      </form>

      <form action="${pageContext.request.contextPath}/parking_hitsory.go" method="post">
        <input type="submit" value="📋 주차장 사용 내역" />
      </form>
    </div>
  </div>

  <!-- Bootstrap JS -->
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
=======

>>>>>>> branch 'main' of https://github.com/suhyun-dev/Parking_Lot.git
</body>
</html>
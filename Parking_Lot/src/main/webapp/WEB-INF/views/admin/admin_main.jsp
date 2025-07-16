<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 메인</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0"> <!-- ✅ 모바일 대응 뷰포트 -->

<!-- Bootstrap 5 -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
<!-- Font Awesome -->
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet" />

<style>
/* 메인 컨테이너 */
#main-holder {
	background: #fff;
	padding: 40px 30px;
	border-radius: 15px;
	box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
	width: 100%;
	max-width: 700px;
	min-height: 300px;

	display: flex;
	flex-direction: column;
	justify-content: center;
	align-items: center;

	text-align: center;
	margin: 100px auto;
}

/* 제목 스타일 */
h2 {
	font-size: 2.2rem;
	font-weight: 800;
	color: #0d6efd;
	margin-bottom: 20px;
}

/* 구분선 */
.custom-divider {
	border-top: 2px solid #dee2e6;
	width: 100%;
	margin-bottom: 30px;
}

/* 버튼 그룹 컨테이너 */
.btn-group-custom {
	display: flex;
	gap: 20px;
	justify-content: center;
}

/* 모바일/작은 화면 */
@media (max-width: 600px) {
    #main-holder {
    	max-width: 95%;
        padding: 30px 20px;
        margin: 60px auto;
    }

    h2 {
        font-size: 1.8rem;
    }

    .btn-group-custom {
        flex-direction: column;
        gap: 15px;
    }

    .btn {
        font-size: 0.95rem;
        padding: 10px 15px;
    }
}
</style>
</head>
<body>

<jsp:include page="../../include/header.jsp" /> <!-- ✅ 공통 헤더 포함 -->

	<div id="main-holder">
		<h2>관리자 메인 페이지</h2>
		<hr class="custom-divider" />

		<!-- ✅ 버튼 그룹 -->
		<div class="btn-group-custom">
			<button class="btn btn-primary" onclick="location.href='/pk_now.go?floor=1'">
				🔧 주차장 현황 페이지
			</button>
			<button class="btn btn-primary" onclick="location.href='/pk_list.go'">
				🚗 주차장 사용 내역
			</button>
		</div>
	</div>

</body>
</html>

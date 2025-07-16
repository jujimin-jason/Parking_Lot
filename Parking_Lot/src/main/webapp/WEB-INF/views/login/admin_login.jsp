<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주차관제시스템 관리자 로그인</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0"> <!-- ✅ 모바일 대응 뷰포트 추가 -->
<style>
/* 메인 컨테이너 */
#main-holder {
	max-width: 700px;
	width: 100%;
	background: #fff;
	border-radius: 15px;
	box-shadow: 0 8px 24px rgba(0, 0, 0, 0.1);
	padding: 40px 30px;
	text-align: center;
	margin: 0 auto;
}

/* 제목 스타일 */
#main-holder h3 {
	font-size: 2.2rem;
	font-weight: 800;
	margin-bottom: 30px;
	color: #0d6efd;
}

/* 구분선 */
.custom-divider {
	border-top: 2px solid #dee2e6;
	margin: 25px 0;
}

/* 입력 박스 컨테이너 */
.info-box {
	margin-bottom: 20px;
	text-align: left;
	position: relative;
}

/* 라벨 스타일 */
.info-box label {
	display: block;
	font-weight: 600;
	margin-bottom: 8px;
	font-size: 1.1rem;
}

/* 아이콘 위치 */
.info-box i {
	position: absolute;
	left: 12px;
	top: 42px;
	color: #6c757d;
	font-size: 1rem;
}

/* 입력창 스타일 */
.info-box input {
	width: 100%;
	padding: 12px 12px 12px 38px;
	font-size: 1.1rem;
	border: 1px solid #ced4da;
	border-radius: 10px;
	box-shadow: inset 0 1px 2px rgba(0, 0, 0, 0.05);
}

/* 버튼 컨테이너 */
.btn-wrapper {
	display: flex;
	gap: 15px;
	justify-content: center;
	margin-top: 20px;
	flex-wrap: wrap;
}

/* 공통 버튼 스타일 */
.btn-wrapper input[type="submit"], .btn-wrapper input[type="reset"] {
	flex: 1 1 45%;
	padding: 12px 0;
	font-size: 1.1rem;
	font-weight: 700;
	border-radius: 50px;
	border: none;
	cursor: pointer;
	transition: 0.3s ease;
	color: #fff;
}

/* 로그인 버튼 색상 */
.btn-wrapper input[type="submit"] {
	background-color: #0d6efd;
}

.btn-wrapper input[type="submit"]:hover {
	background-color: #0b5ed7;
	transform: translateY(-2px);
	box-shadow: 0 6px 12px rgba(0,0,0,0.15);
}

/* 다시작성 버튼 색상 */
.btn-wrapper input[type="reset"] {
	background-color: #6c757d;
}

.btn-wrapper input[type="reset"]:hover {
	background-color: #5c636a;
	transform: translateY(-2px);
	box-shadow: 0 6px 12px rgba(0,0,0,0.15);
}

/* 모바일/작은 화면  */
@media (max-width: 728px) {
	#main-holder {
		max-width: 95%;
		padding: 30px 20px; /* 패딩 축소 */
	}

	#main-holder h3 {
		font-size: 1.8rem; /* 제목 크기 축소 */
	}

	.info-box input {
		font-size: 1rem; /* 입력창 글자 크기 축소 */
		padding: 10px 10px 10px 35px;
	}

	.btn-wrapper input[type="submit"], .btn-wrapper input[type="reset"] {
		font-size: 1rem; /* 버튼 글자 크기 축소 */
		padding: 10px 0;
	}
}
</style>
</head>
<body>

	<jsp:include page="../../include/header.jsp" /> <!-- ✅ 공통 헤더 포함 -->

	<div id="main-holder">
		<h3>주차관제시스템 로그인 페이지</h3>
		<hr class="custom-divider" />

		<form method="post" action="${pageContext.request.contextPath}/admin_login_ok.go">
			<div class="info-box">
				<label for="mem_id">아이디</label>
				<i class="fas fa-user"></i>
				<input type="text" id="mem_id" name="mem_id" required />
			</div>

			<div class="info-box">
				<label for="mem_pwd">비밀번호</label>
				<i class="fas fa-lock"></i>
				<input type="password" id="mem_pwd" name="mem_pwd" required />
			</div>

			<div class="btn-wrapper">
				<input type="submit" value="🔐 로그인" />
				<input type="reset" value="🧹 다시작성" />
			</div>
		</form>
	</div>

	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

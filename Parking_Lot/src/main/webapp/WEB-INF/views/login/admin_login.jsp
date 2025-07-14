<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주차관제시스템 관리자 로그인</title>

<!-- Bootstrap CDN -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
<!-- Font Awesome CDN -->
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet" />

<style>

  #main-holder {
    max-width: 700px;
    width: 100%;
    background: #fff;
    border-radius: 15px;
    box-shadow: 0 8px 24px rgba(0, 0, 0, 0.1);
    padding: 40px 30px;
    text-align: center;
    margin: 0px auto;
  }

  #main-holder h3 {
    font-size: 2.2rem;
    font-weight: 800;
    margin-bottom: 30px;
    color: #0d6efd;
  }

  .custom-divider {
    border-top: 2px solid #dee2e6;
    margin: 25px 0;
  }

  .info-box {
    margin-bottom: 20px;
    text-align: left;
    position: relative;
  }

  .info-box label {
    display: block;
    font-weight: 600;
    margin-bottom: 8px;
    font-size: 1.1rem;
  }

  .info-box i {
    position: absolute;
    left: 12px;
    top: 42px;
    color: #6c757d;
    font-size: 1rem;
  }

  .info-box input {
    width: 100%;
    padding: 12px 12px 12px 38px;
    font-size: 1.1rem;
    border: 1px solid #ced4da;
    border-radius: 10px;
    box-shadow: inset 0 1px 2px rgba(0,0,0,0.05);
  }

  .btn-wrapper {
    display: flex;
    gap: 15px;
    justify-content: center;
    margin-top: 20px;
    flex-wrap: wrap;
  }

  .btn-wrapper input[type="submit"],
  .btn-wrapper input[type="reset"] {
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

  .btn-wrapper input[type="submit"] {
    background-color: #0d6efd;
  }

  .btn-wrapper input[type="submit"]:hover {
    background-color: #0b5ed7;
  }

  .btn-wrapper input[type="reset"] {
    background-color: #6c757d;
  }

  .btn-wrapper input[type="reset"]:hover {
    background-color: #5c636a;
  }
</style>
</head>
<body>

<jsp:include page="../../include/header.jsp" />

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
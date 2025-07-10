<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

	<jsp:include page="../../include/header.jsp" />

	<div align="center">
		<hr width="65%" color="gray">
		<h3>주차관제시스템 로그인 페이지</h3>
		<hr width="65%" color="gray">
		<br> <br>

		<form method="post"
			action="<%=request.getContextPath()%>/admin_login_ok.go">
			<table border="1" width="400">
				<tr>
					<th>아이디</th>
					<td><input name="mem_id"></td>
				</tr>

				<tr>
					<th>비밀번호</th>
					<td><input type="password" name="mem_pwd"></td>
				</tr>

				<tr>
					<td colspan="2" align="center"><input type="submit"
						value="로그인">&nbsp;&nbsp; <input type="reset" value="다시작성">
					</td>
				</tr>
			</table>
		</form>
	</div>
</body>
</html>
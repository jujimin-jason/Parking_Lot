<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<title>출차 리스트</title>
<meta charset="UTF-8">

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

input {
	border-radius: 50px;
	padding: 5px 10px;
	font-size: 18px;
}

input[type="submit"] {
	background-color: #0d6efd;
	color: #fff;
	flex: 1 1 45%;
	border: none;
	cursor: pointer;
}

input[type="submit"]:hover {
	background-color: #0a58ca;
	transform: translateY(-2px);
	box-shadow: 0 6px 12px rgba(0,0,0,0.15);
}

#main-holder h3 {
	font-size: 2.2rem;
	font-weight: 800;
	margin-bottom: 30px;
	color: #0d6efd;
}

.btn-wrapper {
	display: flex;
	gap: 15px;
	justify-content: center;
	margin-top: 20px;
	flex-wrap: wrap;
}

.numpad {
	margin-top: 40px;
}

.numpad button {
	width: 100px;
	height: 60px;
	margin: 8px;
	font-size: 30px;
	border-radius: 12px;
	border: 1px solid #ddd;
	background: linear-gradient(to bottom, #ffffff, #d4d4d4);
	box-shadow: 0 4px 6px rgba(0,0,0,0.1);
	color: #333;
	cursor: pointer;
	transition: all 0.2s;
}

.numpad button:hover {
	background: linear-gradient(to bottom, #f0f0f0, #c0c0c0);
	transform: translateY(-2px);
	box-shadow: 0 6px 12px rgba(0,0,0,0.15);
}

</style>
</head>
<body>

	<jsp:include page="../include/header.jsp" />

	<div id="main-holder">
		<h3>차량 검색</h3>

		<form method="post" action="<%=request.getContextPath()%>/parking_search.go">
			<input name="keyword" id="keyword" placeholder="차량 뒤 4자리 입력"  autofocus>
			<input type="submit" value="검색">
		</form>

		<div class="numpad">
			<button type="button" onclick="appendDigit('1')">1</button>
			<button type="button" onclick="appendDigit('2')">2</button>
			<button type="button" onclick="appendDigit('3')">3</button><br>
			<button type="button" onclick="appendDigit('4')">4</button>
			<button type="button" onclick="appendDigit('5')">5</button>
			<button type="button" onclick="appendDigit('6')">6</button><br>
			<button type="button" onclick="appendDigit('7')">7</button>
			<button type="button" onclick="appendDigit('8')">8</button>
			<button type="button" onclick="appendDigit('9')">9</button><br>
			<button type="button" onclick="clearInput()"> 취소 </button>
			<button type="button" onclick="appendDigit('0')">0</button>
			<button type="button" onclick="deleteOne()">←</button>
			
		</div>
		
	</div>
	
		

	<script>
		function appendDigit(num) {
			const input = document.getElementById("keyword");
			if (input.value.length < 4) {
				input.value += num;
			}
		}

		function clearInput() {
			document.getElementById("keyword").value = '';
		}
		
		function deleteOne() {
			const input = document.getElementById("keyword");
			input.value = input.value.slice(0, -1);
		}
	</script>

</body>
</html>

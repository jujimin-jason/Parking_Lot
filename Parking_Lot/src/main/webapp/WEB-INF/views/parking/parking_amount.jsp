<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>출차 결제</title>
<script src="https://cdn.iamport.kr/js/iamport.payment-1.2.0.js"></script>

<style>
body {
	font-family: sans-serif;
	background-color: #f4f4f4;
	padding: 30px;
	text-align: center;
}

table {
	margin: 0 auto;
	border-collapse: collapse;
	width: 600px;
	background: #fff;
}

th, td {
	border: 1px solid #444;
	padding: 12px;
}

th {
	background-color: #e0e0e0;
}

h1 {
	margin-bottom: 30px;
}

.btn-area {
	margin-top: 20px;
}

.btn {
	padding: 10px 20px;
	margin: 0 10px;
	font-size: 16px;
	cursor: pointer;
}

.container-pspace > button {
	margin: 5px 5px 3px 3px;
	width: 	40px;
	height: 60px;
}

#pspaceModalLabel {
	align-content: center;
}
</style>

</head>
<body>

	<jsp:include page="../../include/header.jsp" />	
	
	<c:set var="pspace" value="${Pspace }" />

	<h1>출차 결제 진행</h1>

	<table class="table table-success table-striped" style="width: 70%; margin: 0 auto;">
		<tr>
			<th>차량 번호</th>
			<th>입차 시간</th>
			<th>출차 시간</th>
			<th>주차위치</th>
			<th>총 요금</th>
			
		</tr>
		<tr class="table-info">
			<td>${pking.car_num}</td>
			<td>${pking.in_time}</td>
			<td>${amount.pay_time}</td>
			
			<!-- 차량 현재 위치 클릭시 모달창 팝업 -->
			<td>
				<button type="button" data-bs-toggle="modal" data-bs-target="#pspaceModal">
					${psdetail.floor }층 ${psdetail.sno }
				</button>
			</td>
			
			<div class="modal fade" id="pspaceModal" tabindex="-1" aria-labelledby="pspaceModalLabel" aria-hidden="true">
			  <div class="modal-dialog modal-dialog-centered modal-lg">
			    <div class="modal-content">
			      <div class="modal-header">
			        <h1 class="modal-title fs-5" id="pspaceModalLabel">
			        현재 차량 위치는 <b>${psdetail.floor }층 ${psdetail.sno }</b> 입니다 
			        </h1>
			        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			      </div>
			      <div class="modal-body">
			      
					<!-- pspace 현황 보여질 영역 -->
			       <div class="container-pspace">
					  <c:if test="${!empty pspace}">
					    <c:forEach items="${pspace}" var="space" varStatus="status">
					    	<c:if test="${space.sid != psdetail.sid}">
					      		<button class="btn btn-info" id="full" 
					      		onclick="#">
					      			${space.sno}
					      		</button>
					      	</c:if>
					      	
					      	<c:if test="${space.sid == psdetail.sid}">
					      		<button class="btn btn-danger" id="empty" 
					      		onclick="#">
					      			${space.sno}
					      		</button>
					      	</c:if>
					      <c:if test="${status.count % 10 == 0}">
					        <br/>
					      </c:if>
					    </c:forEach>
					  </c:if>
					</div>			        
			        
			      </div>
			      <div class="modal-footer">
			        <button type="button" data-bs-dismiss="modal" class="btn btn-secondary">확인</button>
			      </div>
			    </div>
			  </div>	
			</div>
			
			
			<td>${amount.amount}원</td>
		</tr>
	</table>

	<br />

	<button onclick="requestPay()">결제하기</button>
	&nbsp;&nbsp;&nbsp;
	<button onclick="location.href='/'">취소</button>

	<script>
  var IMP = window.IMP;
  IMP.init("imp87828078"); // 가맹점 식별 코드

  function requestPay() {
    const amount = ${amount.amount}; // 서버에서 전달받은 결제금액

    // 결제 금액이 0원이면 바로 출차 처리
      if (true) {
      alert("무료 주차입니다. 출차를 진행합니다.");

      const form = document.createElement("form");
      form.method = "POST";
      form.action = "<%=request.getContextPath()%>/parking_out_ok.go";

      const params = {
        parking_id: "${pking.pid}",
        pay_time: "${amount.pay_time}",
        amount: "${amount.amount}",
      };

  for (const key in params) {
	  console.log(key);
        const input = document.createElement("input");
        input.type = "hidden";
        input.name = key;
        input.value = params[key];
        form.appendChild(input);
      }

      document.body.appendChild(form);
      form.submit();
      return; // 결제창 띄우지 않음
    }

    // 결제 금액이 1원 이상이면 결제창 띄움
    IMP.request_pay({
      pg: "mobilians",
      pay_method: "card",
      merchant_uid: "test_" + new Date().getTime(),
      name: "주차장 정산",
      amount: amount,
      buyer_email: "test@example.com",
      buyer_name: "홍길동",
      buyer_tel: "01012345678",
      buyer_addr: "서울특별시 강남구",
      buyer_postcode: "123-456"
    }, function (rsp) {
      if (rsp.success) {
        alert("결제 성공!");

        const form = document.createElement("form");
        form.method = "POST";
        form.action = "<%=request.getContextPath()%>/parking_out_ok.go";

									const params = {
										parking_id : "${pking.pid}",
										pay_time : "${amount.pay_time}",
										amount : "${amount.amount}",
										aid : "${pking.pid}"
									};

									for ( const key in params) {
										const input = document
												.createElement("input");
										input.type = "hidden";
										input.name = key;
										input.value = params[key];
										form.appendChild(input);
									}

									document.body.appendChild(form);
									form.submit();

								} else {
									alert("결제 실패: " + rsp.error_msg);
								}
							});
		}
	</script>


</body>
</html>
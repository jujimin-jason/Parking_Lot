<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>출차 결제</title>
<script src="https://cdn.iamport.kr/js/iamport.payment-1.2.0.js"></script>

<style>
#main-holder {
	width: 850px;
	/* width: 100%; */
	background: #fff;
	border-radius: 15px;
	box-shadow: 0 8px 24px rgba(0, 0, 0, 0.1);
	padding: 40px 0px;
	text-align: center;
	margin: 0px auto;
}

.title {
	margin-bottom: 50px;
	font-size: 2.2rem;
	font-weight: 800;
	color: #0d6efd;
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

.container-pspace {
	width: 600px;
	margin: 0px auto;
	display: flex;
	flex-wrap: wrap;
	justify-content: center;
}

.container-pspace>div {
	margin: 9px;
	padding: 0px;
	width: 40px;
	height: 50px;
	border: 1px solid #6c757d;
	border-radius: 10px;
	display: flex;
	justify-content: center;
	align-items: center;
}

#pspaceModalLabel {
	align-content: center;
}

#floor-info {
	font-weight: 800;
}

.modal-cus {
	--bs-modal-width: 800px;
	min-width: var(--bs-modal-width);
}

.btn:hover {
    transform: translateY(-2px);
    box-shadow: 0 6px 14px rgba(0, 0, 0, 0.15);
}
</style>

</head>
<body>

	<jsp:include page="../../include/header.jsp" />

	<c:set var="pspace" value="${Pspace }" />

	<div id="main-holder">

		<div class="title">
			<p>출차 결제 진행</p>
		</div>

		<table class="table table-striped" style="width: 80%; margin: 0 auto;">
			<tr>
				<th>차량 번호</th>
				<th>입차 시간</th>
				<th>출차 시간</th>
				<th>주차위치</th>
				<th>총 요금</th>

			</tr>
			<tr class="table align-middle">
				<td>${pking.car_num}</td>
				<td>${pking.in_time}</td>
				<td>${amount.pay_time}</td>

				<!-- 차량 현재 위치 클릭시 모달창 팝업 -->
				<td>
					<button class="btn btn-secondary" type="button"
						data-bs-toggle="modal" data-bs-target="#pspaceModal">${psdetail.floor }층
						${psdetail.sno }</button>
				</td>

				<div class="modal fade" id="pspaceModal" tabindex="-1"
					aria-labelledby="pspaceModalLabel" aria-hidden="true">
					<div class="modal-dialog modal-dialog-centered modal-cus">
						<div class="modal-content">
							<div class="modal-header">
								<h1 class="modal-title fs-5" id="pspaceModalLabel">
									해당 차량 위치는 <b>${psdetail.floor }층 ${psdetail.sno }</b> 입니다
								</h1>
								<button type="button" class="btn-close" data-bs-dismiss="modal"
									aria-label="Close"></button>
							</div>
							<div class="modal-body">

								<!-- pspace 현황 보여질 영역 -->
								<h1 id="floor-info">${psdetail.floor }층</h1>
								<div class="container-pspace">

									<c:if test="${!empty pspace}">
										<c:forEach items="${pspace}" var="space" varStatus="status">
											<c:if test="${space.sid != psdetail.sid}">
												<div style="background:  #e6e6e6">${space.sno}</div>
											</c:if>

											<c:if test="${space.sid == psdetail.sid}">
												<div
													style="border: 0px; background-color: #0d6efd; color: white;">${space.sno}</div>
											</c:if>

										</c:forEach>
									</c:if>
								</div>

							</div>
							<div class="modal-footer">
								<button type="button" data-bs-dismiss="modal"
									class="btn btn-secondary">확인</button>
							</div>
						</div>
					</div>
				</div>


				<td>${amount.amount}원</td>
			</tr>
		</table>

		<br />

		<div>
			<button class="btn btn-primary" onclick="requestPay()">결제하기</button>
			&nbsp;&nbsp;&nbsp;
			<button class="btn btn-primary" onclick="history.back()">취소</button>
		</div>

	</div>
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
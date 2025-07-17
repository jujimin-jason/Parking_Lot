package com.boot.parking.controller;

import java.io.IOException;
import java.io.PrintWriter;

import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import java.util.HashMap;
import java.util.Map;

import java.time.Duration;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.boot.parking.mapper.AdminMapper;
import com.boot.parking.mapper.ParkingMapper;
import com.boot.parking.model.Amount;
import com.boot.parking.model.Page;
import com.boot.parking.model.Parking;
import com.boot.parking.model.Plist;
import com.boot.parking.model.Pspace;
import com.boot.parking.model.PspaceDetail;
import com.boot.parking.model.Admin;
import com.boot.parking.model.Member;

import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@Controller
public class ParkingController {

	@Autowired
	private ParkingMapper mapper;

	@Autowired
	private AdminMapper adminMapper;

	// 한 페이지당 보여질 기록 수
	private final int rowsize = 10;

	// DB 상의 전체 기록 수
	private int totalRecord = 0;

	// 무작위로 생성될 차량 번호.
	String bun = null;

	// 동일번호판의 차량이 있는지 확인할 Parking 객체
	Parking chkDupl = null;

	String in_time = null;

	// 지하주차장 층수.
	int floor;
	// 한층당 주차가능 가능 대수.
	int ava = 50;

	@GetMapping("/")
	public String main() {

		return "main"; // application.properties 에서 JSP 경로 설정해둔 경로의 main.jsp 로 이동.

	}

	@GetMapping("/parking_in.go")
	public String entry(Model model, @RequestParam(value = "floor", defaultValue = "1") int floor) {
		// 특정 층수를 매개변수로 주차장 현황 리스트를 가져오는 메서드.s
		List<Pspace> pspace = this.mapper.getPspace(floor);

		model.addAttribute("Pspace", pspace);

		return "parking/parking_in";
	}

	@GetMapping("/parking_in_ok.go")
	public void entry_ok(HttpServletResponse response, Model model, @RequestParam("sid") int sid) throws IOException {
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();

		// 무작위로 번호판을 생성. -> bun 전역 변수에 저장.
		MakeRandomCarnum mrc = MakeRandomCarnum.getInstance();
		bun = mrc.mrc();

		// DB에 동일번호판의 차량이 현재 입차상태인지 확인하는 메서드. -> chkDupl 객체에 저장.
		chkDupl = this.mapper.checkDupl(bun);

		if (chkDupl != null) {

			while (true) {
				bun = mrc.mrc();

				chkDupl = this.mapper.checkDupl(bun);

				if (chkDupl == null) {
					out.println("<script>");
					out.println("alert('중복 데이터 처리 완료')");
					out.println("</script>");

					break;
				}
			}
		}

		// 페이징 처리를 위한 페이징 객체 생성
		Parking pdto = new Parking();
		pdto.setCar_num(bun);

		// pspace 테이블에 주차 현황 정보 업데이트필요.
		pdto.setPspace_id(sid);

		// 입차된 차량의 층수를 구하는 작업.
		for (int i = 1; i <= 3; i++) {
			if (sid <= i * ava) {
				floor = i;
				break;
			}
		}

		int chk1 = this.mapper.entry(pdto);

		if (chk1 > 0) {
			int chk2 = this.mapper.updatePspaceIn(sid);

			if (chk2 > 0) {
				out.println("<script>");
				out.println("alert('차량번호 " + bun + " 입차되었습니다.')");
				out.println("location.href='parking_in.go?floor=" + floor + "'");
				out.println("</script>");
			} else {
				out.println("<script>");
				out.println("alert('입차 실패')");
				out.println("history.back()");
				out.println("</script>");
			}
		} else {
			out.println("<script>");
			out.println("alert('입차 실패')");
			out.println("history.back()");
			out.println("</script>");
		}

	}

	@GetMapping("/pk_list.go")
	public String list(@RequestParam(value = "page", defaultValue = "1") int page, Model model) {

		// DB 상의 전체 기록수를 반환하는 메서드 호출.
		totalRecord = this.mapper.count();

		// 매개변수로 던져줄 페이징 객체 생성.
		Page paging = new Page(page, rowsize, totalRecord);

		// 페이징 조건에 맞춰 주차 기록 리스트를 반환하는 메서드 호출.
		List<Plist> pkList = this.mapper.pkList(paging);

		model.addAttribute("pkList", pkList);
		model.addAttribute("Paging", paging);

		return "parking/pk_list";
	}

	@RequestMapping("/pk_search_detail.go")
	public String search_detail(@RequestParam(value = "page", defaultValue = "1") int page,
			@RequestParam("car_num") String car_num, @RequestParam("date") String date, Model model,
			HttpServletResponse response) throws IOException {

		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();

		// car_num 유효성 검사
		Pattern p = Pattern.compile("^[0-9]{4}$");
		Matcher m = p.matcher(car_num); // 문제있을시 false, 없으면 true

		if (car_num == "" && date == "") {
			out.println("<script>");
			out.println("alert('차량 번호 혹은 입차일을 입력하세요.')");
			out.println("history.back()");
			out.println("</script>");
			return null;
		} else if (!m.matches() && date == "") {
			out.println("<script>");
			out.println("alert('차량번호 뒷자리 4자리를 입력하세요.')");
			out.println("history.back()");
			out.println("</script>");
			return null;
		}

		if (date != "") {
			if (car_num != "") {
				if (!m.matches()) {
					out.println("<script>");
					out.println("alert('차량번호 뒷자리 4자리를 입력하세요.')");
					out.println("history.back()");
					out.println("</script>");
					return null;
				}
			}
		}

		// DB 조회를 위해 in_time 변수의 형식을 바꿔줘야 함.
		// ex) java : 2025-07-08 / oracle sql : 25/07/08
		if (date.length() == 10) {
			in_time = date.substring(2, 10).replaceAll("-", "/");
		} else {
			in_time = date;
		}

		Parking pk = new Parking();
		pk.setCar_num(car_num);
		pk.setIn_time(in_time);

		// 차량 번호로 검색된 기록의 수를 반환하는 메서드.
		totalRecord = this.mapper.sCount(pk);

		// 매개변수로 던져줄 페이징 객체 생성.
		Page pagingCnum = new Page(page, rowsize, totalRecord, car_num, in_time);

		// 전체 주차 기록 조회를 하는 메서드.
		List<Plist> searchList = this.mapper.pkSearchDetail(pagingCnum);

		model.addAttribute("SearchList", searchList);
		model.addAttribute("Paging", pagingCnum);
		model.addAttribute("Date", date);

		return "parking/pk_search_list";
	}

	@GetMapping("pk_now.go")
	public String pnow(Model model, @RequestParam(value = "floor", defaultValue = "1") int floor) {

		// 특정 층수를 매개변수로 주차장 현황 리스트를 가져오는 메서드.
		List<Pspace> pspace = this.mapper.getPspace(floor);

		model.addAttribute("Pspace", pspace);

		return "parking/pk_now";
	}

	@GetMapping("pk_now_detail.go")
	public String pnow_detail(Model model, @RequestParam("sid") int sid) {
		PspaceDetail psdetail = this.mapper.getPspaceDetail(sid);

		model.addAttribute("Psdetail", psdetail);

		return "parking/pk_now_detail";
	}

	@GetMapping("parking_out.go")
	public String pout() {

		return "parking/parking_out";

	}

	@PostMapping("parking_search.go")
	public String search(Model model, @RequestParam("keyword") String keyword, HttpServletResponse response) throws IOException {

		List<Parking> list = this.mapper.search(keyword);

		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();
		
		model.addAttribute("list", list);
		
		if(list == null || list.isEmpty()) {
			out.println("<script>");
			out.println("alert('일치하는 차량이 없습니다')");
			out.println("history.back()");
			out.println("</script>");
		    return null;
			
		}

		return "parking/parking_search";
	}

	@GetMapping("parking_amount.go")
	public String carAmount(Model model, @RequestParam("num") String car_num) {

		// 입차 정보 조회
		Parking pking = this.mapper.pcar(car_num);

		// 차량 주차 위치
		PspaceDetail psdetail = this.mapper.getPspaceDetail(pking.getPspace_id());

		// 현재 시간 = 출차 시간
		LocalDateTime now = LocalDateTime.now();
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
		String nowStr = now.format(formatter);

		// 입차 시간 → LocalDateTime 변환
		LocalDateTime inTime = LocalDateTime.parse(pking.getIn_time(), formatter);

		// 요금 계산 (10분당 500원)
		long minutes = Duration.between(inTime, now).toMinutes();
		int price = (int) (Math.ceil(minutes / 10.0) * 500);
		// amount 객체 만들기 (아직 DB에 저장 X)
		Amount amount = new Amount();
		amount.setParking_id(pking.getPid());
		amount.setPay_time(nowStr);
		amount.setAmount(price);

		// 모달창에 현재 주차위치를 띄워야함.
		floor = psdetail.getFloor();
		// 특정 층수를 매개변수로 주차장 현황 리스트를 가져오는 메서드.
		List<Pspace> pspace = this.mapper.getPspace(floor);

		model.addAttribute("pking", pking);
		model.addAttribute("amount", amount);
		model.addAttribute("psdetail", psdetail);
		model.addAttribute("Pspace", pspace);

		return "parking/parking_amount";
	}

	@PostMapping("/parking_out_ok.go")
	public void processOut(@RequestParam("parking_id") int parking_id, @RequestParam("pay_time") String payTime,
			@RequestParam("amount") int amount, HttpServletResponse response) throws IOException {

		Amount dto = new Amount();
		dto.setParking_id(parking_id);
		dto.setPay_time(payTime);
		dto.setAmount(amount);
		this.mapper.insertAmount(dto);

		Map<String, String> map = new HashMap<String, String>();

		Parking pk = new Parking();
		pk.setPid(parking_id);
		pk.setOut_time(payTime);

		// res = 출차 성공 여부
		int res = this.mapper.updateParkingOut(pk);

		response.setContentType("text/html; charset=UTF-8");

		PrintWriter out = response.getWriter();

		if (res > 0) {
			// 출차 성공 후 pspace 테이블 업데이트
			this.mapper.updatePspaceOut(parking_id);

			out.println("<script>");
			out.println("alert('출차 완료!');");
			out.println("location.href='/'");
			out.println("</script>");

		} else {
			out.println("<script>");
			out.println("alert('출차 실패!');");
			out.println("history.back()");
			out.println("</script>");

		}

	}

	@GetMapping("/store_page.go")
	public String storePage() {
		return "store/store_main";
	}

	// 매장 주차 정산 페이지 이동 (검색폼 페이지)
	@GetMapping("/store_parking_list.go")
	public String storeParking() {
		return "store/store_parking_list";
	}

	// 차량 선택(검색) 후 리스트 페이지 이동
	@GetMapping("/store_parking_list_ok.go")
	public String storeParkingList(@RequestParam("car_back") String carBack, Model model) {
		// 뒷자리로 차량 검색
		List<Parking> carList = mapper.search(carBack);
		// 검색된 차량 리스트를 JSP에 전달
		model.addAttribute("carList", carList);
		// 검색 여부 flag 전달
		model.addAttribute("searched", true);
		// 차량 선택 리스트 페이지로 이동
		return "store/store_parking_list";
	}

	// 선택한 차량의 상세 정보 페이지
	@GetMapping("/store_parking.go")
	public String storeParking(@RequestParam("car_num") String carNum, Model model, HttpSession session) {
		// 차량 정보 조회
		Parking car = mapper.pcar(carNum);

		if (car != null) {
			DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
			LocalDateTime inTime = LocalDateTime.parse(car.getIn_time(), formatter);
			LocalDateTime now = LocalDateTime.now();
			long diffMinutes = Duration.between(inTime, now).toMinutes();

			// DB에서 할인 시간 가져오기
			int currentDcTime = car.getDc_time();
			if (currentDcTime < 0) {
				currentDcTime = 0;
			}

			long discountedTime = diffMinutes - currentDcTime;
			if (discountedTime < 0)
				discountedTime = 0;

			String parkingTimeStr = (diffMinutes / 60) + "시간 " + (diffMinutes % 60) + "분";
			String discountedTimeStr = (discountedTime / 60) + "시간 " + (discountedTime % 60) + "분";
			String discountTimeStr = (currentDcTime / 60) + "시간 " + (currentDcTime % 60) + "분";

			model.addAttribute("car", car);
			model.addAttribute("parkingTime", diffMinutes);
			model.addAttribute("parkingTimeStr", parkingTimeStr);
			model.addAttribute("discountedTime", discountedTime);
			model.addAttribute("discountedTimeStr", discountedTimeStr);
			model.addAttribute("discountTime", discountTimeStr);
		}

		// 로그인한 매장 정보 가져오기
		Member loginMember = (Member) session.getAttribute("loginMember");
		int storeCode = loginMember.getStore_code();
		Admin admin = adminMapper.getAdminByStoreCode(storeCode);
		if (admin != null) {
			model.addAttribute("adminCoupons", admin);
		}

		return "store/store_parking";
	}

	// 쿠폰 구매 페이지 이동
	@GetMapping("/store_coupon.go")
	public String storeCoupin() {
		// 단순히 쿠폰 구매 페이지로 이동
		return "store/store_coupon";
	}

	@PostMapping("/apply_coupon.go")
	public void applyCoupon(@RequestParam("car_num") String carNum, @RequestParam("discount") int discount,
			HttpSession session, HttpServletResponse response) throws IOException {

		// 로그인한 매장 정보 가져오기
		Member loginMember = (Member) session.getAttribute("loginMember");
		int storeCode = loginMember.getStore_code();

		// 매장 관리자 쿠폰 정보 가져오기
		Admin admin = adminMapper.getAdminByStoreCode(storeCode);

		// 차량 정보 가져오기
		Parking car = mapper.pcar(carNum);

		// 현재까지 할인 시간 가져오기
		int currentDcTime = car.getDc_time();

		boolean hasCoupon = false;

		if (discount == 30 && admin.getDc_coupon_30m() > 0) {
			admin.setDc_coupon_30m(admin.getDc_coupon_30m() - 1);
			currentDcTime += 30;
			hasCoupon = true;
		} else if (discount == 60 && admin.getDc_coupon_1h() > 0) {
			admin.setDc_coupon_1h(admin.getDc_coupon_1h() - 1);
			currentDcTime += 60;
			hasCoupon = true;
		}

		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();

		if (hasCoupon) {
			// DB에 관리자 쿠폰 정보 업데이트
			adminMapper.updateCoupons(admin);

			// DB에 할인 시간 업데이트
			Map<String, Object> map = new HashMap<>();
			map.put("pid", car.getPid());
			map.put("dc_time", currentDcTime);
			mapper.updateDcTime(map);

			// 쿠폰 적용 후 다시 차량 정산 페이지로 리다이렉트
			out.println("<script>");
			out.println("location.href='store_parking.go?car_num=" + carNum + "'");
			out.println("</script>");
		} else {
			// 쿠폰 부족 시 alert만 띄움 후 뒤로가기
			out.println("<script>");
			out.println("alert('쿠폰이 부족합니다!')");
			out.println("history.back()");
			out.println("</script>");
		}
	}

	// 쿠폰 구매 처리
	@PostMapping("/coupon_buy.go")
	public void buyCoupon(@RequestParam("coupon_type") String couponType, @RequestParam("quantity") int quantity,
			HttpSession session, HttpServletResponse response) throws IOException {

		// 로그인한 매장 관리자 정보 가져오기
		Member loginMember = (Member) session.getAttribute("loginMember");
		int storeCode = loginMember.getStore_code();

		// 매장 관리자 쿠폰 정보 가져오기
		Admin admin = adminMapper.getAdminByStoreCode(storeCode);

		// 선택된 쿠폰 종류에 따라 수량 증가
		if (couponType.equals("30분")) {
			admin.setDc_coupon_30m(admin.getDc_coupon_30m() + quantity);
		} else if (couponType.equals("1시간")) {
			admin.setDc_coupon_1h(admin.getDc_coupon_1h() + quantity);
		}

		// DB 업데이트
		adminMapper.updateCoupons(admin);

		// 구매하기 누르면 alert 창 띄우고 메인 페이지로 이동
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();
		out.println("<script>");
		out.println("alert('쿠폰이 성공적으로 구매되었습니다!')");
		out.println("location.href='store_page.go'");
		out.println("</script>");
	}

}

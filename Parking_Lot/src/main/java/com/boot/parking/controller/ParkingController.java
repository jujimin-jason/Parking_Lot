package com.boot.parking.controller;

import java.io.IOException;
import java.io.PrintWriter;

import java.util.List;
import java.util.Random;
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

import com.boot.parking.mapper.ParkingMapper;
import com.boot.parking.model.Amount;
import com.boot.parking.model.Page;
import com.boot.parking.model.Parking;

import jakarta.servlet.http.HttpServletResponse;

@Controller
public class ParkingController {

	@Autowired
	private ParkingMapper mapper;

	// 한 페이지당 보여질 기록 수
	private final int rowsize = 10;

	// DB 상의 전체 기록 수
	private int totalRecord = 0;

	@GetMapping("/")
	public String main() {

		return "main"; // application.properties 에서 JSP 경로 설정해둔 경로의 main.jsp 로 이동.

	}

	@GetMapping("/parking_in.go")
	public void entry(HttpServletResponse response, Model model) throws IOException {
		// 입차 비지니스 로직. // 입차번호 생성후 중복인 경우를 위한 예외처리 필요
		// 1. 랜덤으로 차량번호를 만들자.

		// 난수 발생을 위한 클래스 객체 생성.
		Random rand = new Random();

		// 랜덤으로 생성시킬 차량 가운데 한글자. (32개)
		String[] kor = { "가", "나", "다", "라", "마", "거", "너", "더", "러", "머", "버", "서", "어", "저", "고", "노", "도", "로", "모",
				"보", "소", "오", "조", "구", "누", "두", "루", "무", "부", "수", "우", "주" };

		// 문자열로 변환시킬 차량 번호
		String bun;

		// 1-1. 앞번호 - 01 ~ 699
		int ran1 = (int) (Math.random() * 699) + 1;

		String num = Integer.toString(ran1);
		String string1 = num.replaceFirst("^0+", "");
		int num1 = Integer.parseInt(string1);

		// System.out.println(num1);

		// 1-2. 중간 한글
		String kor1 = kor[rand.nextInt(kor.length)];

		// 1-3. 뒷번호 - 0100 ~ 9999
		int num2 = (int) (Math.random() * 9900) + 100;

		if (num1 > 100) {
			bun = String.format("%03d", num1) + kor1 + " " + String.format("%04d", num2);
		} else {
			bun = String.format("%02d", num1) + kor1 + " " + String.format("%04d", num2);
		}

		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();

		Parking pdto = new Parking();
		pdto.setCar_num(bun);

		int chk = this.mapper.entry(pdto);

		if (chk > 0) {
			out.println("<script>");
			out.println("alert('차량번호 " + bun + " 입차되었습니다.')");
			out.println("history.back()");
			out.println("</script>");
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
		List<Parking> pkList = this.mapper.pkList(paging);

		model.addAttribute("pkList", pkList);
		model.addAttribute("Paging", paging);

		return "parking/pk_list";
	}

	@RequestMapping("/pk_search_cnum.go")
	public String search_cnum(@RequestParam(value = "page", defaultValue = "1") int page,
			@RequestParam("car_num") String car_num, Model model) {

		// 차량 번호로 검색된 기록의 수를 반환하는 메서드.
		totalRecord = this.mapper.sCountCnum(car_num);

		// 매개변수로 던져줄 페이징 객체 생성.
		Page pagingCnum = new Page(page, rowsize, totalRecord, car_num);

		List<Parking> searchList = this.mapper.pkSearchCnum(pagingCnum);

		model.addAttribute("SearchList", searchList);
		model.addAttribute("Paging", pagingCnum);

		return "parking/pk_search_list";
	}

	// 날짜로 검색
	@RequestMapping("/pk_search_date.go")
	public String search_date(@RequestParam(value = "page", defaultValue = "1") int page,
			@RequestParam("date") String date, Model model) {
		// 날짜로 검색된 기록의 수를 반환하는 메서드.
		totalRecord = this.mapper.sCountIntime(date);

		// 매개변수로 던져줄 페이징 객체 생성.
		Page paging = new Page(page, rowsize, totalRecord, date, 0);

		List<Parking> searchList = this.mapper.pkSearchIntime(paging);

		model.addAttribute("SearchList", searchList);
		model.addAttribute("Paging", paging);

		return "parking/pk_search_list";
	}

	@GetMapping("parking_out.go")
	public String pout() {

		return "parking/parking_out";
	}

	@PostMapping("parking_search.go")
	public String search(Model model, @RequestParam("keyword") String keyword) {

		System.out.println(keyword);

		List<Parking> list = this.mapper.search(keyword);

		System.out.println(list);

		model.addAttribute("list", list);

		return "parking/parking_search";
	}

	@GetMapping("parking_amount.go")
	public String carAmount(Model model, @RequestParam("num") String car_num) {

		// 입차 정보 조회
		Parking pking = this.mapper.pcar(car_num);

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
		amount.setCar_num(car_num);
		amount.setPay_time(nowStr);
		amount.setAmount(price);

		model.addAttribute("pking", pking);
		model.addAttribute("amount", amount);

		return "parking/parking_amount";
	}

	@PostMapping("/parking_out_ok.go")
	public void processOut(@RequestParam("car_num") String carNum, @RequestParam("pay_time") String payTime,
			@RequestParam("amount") int amount, @RequestParam("aid") int aid, HttpServletResponse response)
			throws IOException {

		Amount dto = new Amount();
		dto.setAid(aid);
		dto.setCar_num(carNum);
		dto.setPay_time(payTime);
		dto.setAmount(amount);
		this.mapper.insertAmount(dto);

		Map<String, String> map = new HashMap<String, String>();
		map.put("car_num", carNum);
		map.put("pay_time", payTime);
		int res = this.mapper.updateParkingOut(map);

		response.setContentType("text/html; charset=UTF-8");

		PrintWriter out = response.getWriter();

		if (res > 0) {

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

}

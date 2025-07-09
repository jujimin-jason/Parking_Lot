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

	// 무작위로 생성될 차량 번호.
	String bun = null;

	// 동일번호판의 차량이 있는지 확인할 Parking 객체
	Parking chkDupl = null;
	
	String in_time = null;

	@GetMapping("/")
	public String main() {

		return "main"; // application.properties 에서 JSP 경로 설정해둔 경로의 main.jsp 로 이동.

	}

	@GetMapping("/parking_in.go")
	public void entry(HttpServletResponse response, Model model) throws IOException {
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

	@RequestMapping("/pk_search_detail.go")
	public String search_cnum(@RequestParam(value = "page", defaultValue = "1") int page,
			@RequestParam("car_num") String car_num,
			@RequestParam("date") String date,
			Model model) {
		
		// DB 조회를 위해 in_time 변수의 형식을 바꿔줘야 함. 
		// ex) java : 2025-07-08 / oracle sql : 25/07/08
		if(date.length() == 10) {
			in_time = date.substring(2, 10).replaceAll("-", "/");
		}else {
			in_time = date;
		}
		
		Parking pk = new Parking();
		pk.setCar_num(car_num);
		pk.setIn_time(in_time);

		// 차량 번호로 검색된 기록의 수를 반환하는 메서드.
		totalRecord = this.mapper.sCount(pk);

		// 매개변수로 던져줄 페이징 객체 생성.
		Page pagingCnum = new Page(page, rowsize, totalRecord, car_num, in_time);

		List<Parking> searchList = this.mapper.pkSearchDetail(pagingCnum);

		model.addAttribute("SearchList", searchList);
		model.addAttribute("Paging", pagingCnum);
		model.addAttribute("Date", date);

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
	
	@GetMapping("/store_parking.go")
	public String storeParking() {
	    return "store/store_parking";
	}

	@GetMapping("/store_parking_ok.go")
	public String storeParking(@RequestParam("car_back") String carBack, Model model) {
	    List<Parking> carList = mapper.search(carBack);	    
	    Parking car = null;
	    if (!carList.isEmpty()) {
	        car = carList.get(0);

	        String inTimeStr = car.getIn_time();
	        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
	        LocalDateTime inTime = LocalDateTime.parse(inTimeStr, formatter);
	        LocalDateTime now = LocalDateTime.now();
	        long diffMinutes = Duration.between(inTime, now).toMinutes();

	        model.addAttribute("car", car);
	        model.addAttribute("parkingTime", diffMinutes);
	        model.addAttribute("discountedTime", diffMinutes);
	    }
	    return "store/store_parking";
	}

	@GetMapping("/store_coupon.go")
	public String storeCoupin() {
	    return "store/store_coupon";
	}

}

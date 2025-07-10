package com.boot.parking.controller;

import java.io.IOException;
import java.io.PrintWriter;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.boot.parking.model.Member;
import com.boot.parking.mapper.MemMapper;

import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@Controller
public class MemController {

	@Autowired
	private MemMapper mapper;

//	// 메인 페이지
//	@GetMapping("/")
//	public String main() {
//		return "main";
//	}

	@GetMapping("/admin_login.go")
	public String loginForm() {

		return "login/admin_login";

	}

	@PostMapping("/admin_login_ok.go")
	public void login_ok(@RequestParam("mem_id") String mem_id, @RequestParam("mem_pwd") String mem_pwd,
			HttpServletResponse response, HttpSession session) throws IOException {

		response.setContentType("text/html; charset=UTF-8");

		PrintWriter out = response.getWriter();
		
		Member login = this.mapper.login(mem_id, mem_pwd);		

		if (login != null) {		
			session.setAttribute("loginMember", login);

			out.println("<script>");
			out.println("alert('로그인 성공!')");
			out.println("location.href='store_page.go'");// test를 위해서 location.href='store_page.go 변경 원래("location.href='/';")
			out.println("</script>");
		} else {			
			out.println("<script>");
			out.println("alert('로그인 실패!')");
			out.println("history.back()");
			out.println("</script>");
		}
	}

	@GetMapping("admin_logout.go")
	public void logout(HttpSession session, HttpServletResponse response) throws IOException {

		session.invalidate();

		response.setContentType("text/html; charset=UTF-8");

		PrintWriter out = response.getWriter();

		out.println("<script>");
		out.println("alert('로그아웃 되었습니다.')");
		out.println("location.href='/';");
		out.println("</script>");
	}
	
	@GetMapping("/store_page.go")
	public String storePage() {
	    return "store/store_page"; // JSP 위치 기준
	}

}
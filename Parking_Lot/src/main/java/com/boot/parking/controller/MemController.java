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
			
			int storeCode = login.getStore_code();

			out.println("<script>");
			out.println("alert('로그인 성공!')");
			
			if(storeCode == 0) {
				out.println("location.href='/admin_main.go';");
			}else {
				out.println("location.href='/store_main.go?storeCode="+storeCode+"';");
			}
		 
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
	
	
	@GetMapping("/admin_main.go")
	public String adminmain(HttpSession session) {
		Member loginMember = (Member) session.getAttribute("loginMember");
		if(loginMember == null || loginMember.getStore_code() != 0) {
			return "redirect:/admin_login.go";
		}
		
		return "admin/admin_main";
	}
	
	
	@GetMapping("/store_main.go")
	public String storeMain(@RequestParam("storeCode") int storeCode, HttpSession session) {
		Member loginMember = (Member) session.getAttribute("loginMember");
		if (loginMember == null || loginMember.getStore_code() != storeCode) {
			return "redirect:/admin_login.go";
		}
		
		session.setAttribute("storeCode", storeCode);
		
		return "store/store_main";
	}
	
}
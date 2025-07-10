package com.boot.parking.model;

import lombok.Data;

@Data
public class Member {

	private int mid; // 사용자 db id
	private String mem_id; // 사용자 아이디
	private String mem_pwd; // 사용자 비밀번호
	private int store_code; // 매장 코드 (0 = 관리자, 1 이상 = 매장 번호)
}

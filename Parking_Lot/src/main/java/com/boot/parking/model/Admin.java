package com.boot.parking.model;

import lombok.Data;

@Data
public class Admin {
	
	private int admin_id;         // 관리자 고유 번호
    private int store_code;       // 매장 코드
    private String store_name;    // 매장 이름
    private int dc_coupon_30m;    // 30분 할인권 개수
    private int dc_coupon_1h;     // 1시간 할인권 개수
}

package com.boot.parking.model;

import lombok.Data;

//쿼리문 결과를 위한 부가 모델
@Data
public class Plist {
	private int pid; // 입차 식별용 id
	private String car_num; // 차량번호
	private String in_time; // 입차 시간
	private String out_time; // 출차 시간
	private String state; // 현재 입차 여부
	private int amount;	// 정산 요금
}

package com.boot.parking.model;

import lombok.Data;

// 쿼리문 결과를 위한 부가 모델
@Data
public class PspaceDetail {
	private int sid;		// 식별용 id
	private int floor;		// 주차장 층
	private String sno; 	// 주차 위치
	private String state; 	// 현재 입차 여부
	private String car_num;	// 차량 번호판
	private String in_time;	// 입차 시간
}

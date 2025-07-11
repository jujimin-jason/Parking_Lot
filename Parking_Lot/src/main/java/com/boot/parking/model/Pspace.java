package com.boot.parking.model;

import lombok.Data;

@Data
public class Pspace {
	private int sid;		// 식별용 id
	private int floor;		// 주차장 층
	private String sno; 	// 주차 위치
	private String state; 	// 현재 입차 여부
}

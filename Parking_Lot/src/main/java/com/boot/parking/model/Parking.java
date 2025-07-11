package com.boot.parking.model;

import lombok.Data;

@Data
public class Parking {

	private int pid; // 입차 식별용 id
	private String car_num; // 차량번호
	private String in_time; // 입차 시간
	private String out_time; // 출차 시간
	private String state; // 현재 입차 여부
	private int pspace_id; // pspace table id
}

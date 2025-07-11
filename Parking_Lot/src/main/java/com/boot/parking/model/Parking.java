package com.boot.parking.model;

import lombok.Data;

@Data
public class Parking {

    private int pid;          // 입차 식별용 id
    private String car_num;   // 차량 번호
    private String in_time;   // 입차 시간
    private String out_time;  // 출차 시간
    private String state;     // 입차 상태
    private int pspace_id; // 자리 FK (nullable 가능성 높음)    
    private int dc_time;      // 할인 시간
}

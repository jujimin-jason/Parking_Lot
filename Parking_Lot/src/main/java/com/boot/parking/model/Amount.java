package com.boot.parking.model;

import lombok.Data;

@Data
public class Amount {

    private int aid;          // 정산 식별용 id
    private int parking_id;   // 주차 PK (외래키)
    private int amount;       // 정산 금액
    private String pay_time;  // 정산 시간
}

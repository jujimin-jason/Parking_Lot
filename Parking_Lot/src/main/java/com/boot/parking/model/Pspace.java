package com.boot.parking.model;

import lombok.Data;

@Data
public class Pspace {
    private int sid;      // 식별용 id
    private int floor;    // 층수
    private String sno;   // 자리 번호
    private String state; // 자리 사용 여부
}

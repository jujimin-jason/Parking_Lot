package com.boot.parking.model;

import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@Data
public class Page {

	// 페이징 처리 멤버 선언
	private int page; // 현재 페이지
	private int rowsize; // 한 페이지당 보여질 기록 수
	private int totalRecord; // DB 상의 전체 기록 수
	private int startNo; // 해당 페이지에서 시작 번호
	private int endNo; // 해당 페이지에서 끝 번호
	private int startBlock; // 해당 페이지에서 시작 블럭
	private int endBlock; // 해당 페이지에서 끝 블럭
	private int allPage; // 전체 페이지 수
	private int block = 5; // 하단에 보여질 최대 블럭 수

	// 검색 관련 멤버 선언 <- 보류
	private String car_num; // 검색에 사용될 차량번호
	private String in_time; // 검색에 사용될 입차시간
	private int none = 0; // 세번째 인자생성자를 위한 무의미한 데이터

	// 페이징 처리 인자 생성자
	public Page(int page, int rowsize, int totalRecord) {
		this.page = page;
		this.rowsize = rowsize;
		this.totalRecord = totalRecord;

		// 해당 페이지에서 시작 번호
		this.startNo = (this.page * this.rowsize) - (this.rowsize - 1);

		// 해당 페이지에서 끝 번호
		this.endNo = (this.page * this.rowsize);

		// 해당 페이지에서 시작 블럭
		this.startBlock = (((this.page - 1) / this.block) * this.block) + 1;

		// 해당 페이지에서 끝 블럭
		this.endBlock = (((this.page - 1) / this.block) * this.block) + this.block;

		// 전체 페이지 수
		this.allPage = (int) Math.ceil(this.totalRecord / (double) this.rowsize);

		if (this.endBlock > this.allPage) {
			this.endBlock = this.allPage;
		}

	} // 페이징 처리 인자 생성자

	// 차량번호로 검색할때 사용될 페이징 처리 인자 생성자
	public Page(int page, int rowsize, int totalRecord, String car_num) {
		this(page, rowsize, totalRecord);
		this.car_num = car_num;
	}

	// 입차시간으로 검색할때 사용될 페이징 처리 인자 생성자
	public Page(int page, int rowsize, int totalRecord, String in_time, int none) {
		this(page, rowsize, totalRecord);
		this.in_time = in_time;
	}

}

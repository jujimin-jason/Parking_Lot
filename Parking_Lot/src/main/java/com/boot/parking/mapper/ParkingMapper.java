package com.boot.parking.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.boot.parking.model.Amount;
import com.boot.parking.model.Page;
import com.boot.parking.model.Parking;

@Mapper
public interface ParkingMapper {

	// 차량번호를 매개변수로 DB에 입차 데이터를 생성해주는 메서드.
	int entry(Parking pdto);

	// DB 상의 전체 기록 수를 반환하는 메서드.
	int count();

	// 현재 입차 현황을 조회하는 메서드.
	List<Parking> pkList(Page paging);

	// 차량 번호로 검색된 게시물의 수를 반환하는 메서드.
	int sCountCnum(String car_num);

	// 차량 번호로 기록을 조회하는 메서드.
	List<Parking> pkSearchCnum(Page paging);

	// 차량 번호로 검색된 기록의 수를 반환하는 메서드.
	int sCountIntime(String in_time);

	// 차량 번호로 기록을 조회하는 메서드.
	List<Parking> pkSearchIntime(Page paging);

//	-------------------------------------------------------------------

	List<Parking> list();

	List<Parking> search(String keyword);

	Parking pcar(String cnum);

	int insertAmount(Amount amount);

	int updateParkingOut(Map<String, String> map);

}

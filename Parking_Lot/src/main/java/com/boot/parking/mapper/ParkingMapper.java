package com.boot.parking.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.boot.parking.model.Amount;
import com.boot.parking.model.Page;
import com.boot.parking.model.Parking;
import com.boot.parking.model.Plist;
import com.boot.parking.model.Pspace;
import com.boot.parking.model.PspaceDetail;

@Mapper
public interface ParkingMapper {
	
	// DB에 동일번호판의 차량이 현재 입차상태인지 확인하는 메서드.
	Parking checkDupl(String car_num);

	// 차량번호를 매개변수로 DB에 입차 데이터를 생성해주는 메서드.
	int entry(Parking pdto);
	
	// sid 를 매개변수로 pspace 테이블에 해당 sid 컬럼을 입차상태로 바꿔주는 메서드.
	int updatePspaceIn(int sid);

	// DB 상의 전체 기록 수를 반환하는 메서드.
	int count();

	// 전체 주차 기록을 조회하는 메서드.
	List<Plist> pkList(Page paging);

	// 상세정보를 통해 검색된 기록의 수를 반환하는 메서드.
	int sCount(Parking pk);

	// 상세정보를 통해 기록을 조회하는 메서드.
	List<Plist> pkSearchDetail(Page paging);
	
	// 특정 층수를 매개변수로 주차장 현황 리스트를 가져오는 메서드.
	List<Pspace> getPspace(int floor);
	
	// 특정 주차위치를 매개변수로 현재 주차 정보(pspace + 입차시간)를 가져오는 메서드.
	PspaceDetail getPspaceDetail(int sid);

//	-------------------------------------------------------------------

	List<Parking> list();

	List<Parking> search(String keyword);

	Parking pcar(String cnum);

	int insertAmount(Amount amount);

	int updateParkingOut(Parking parking);
	
	// 출차시 pspace 테이블 업데이트 메서드.
	void updatePspaceOut(int parking_id);
	
	// 할인 시간 업데이트 메서드 추가
    int updateDcTime(Map<String, Object> map);	
}

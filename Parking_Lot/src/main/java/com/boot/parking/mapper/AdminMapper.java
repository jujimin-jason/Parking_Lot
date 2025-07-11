package com.boot.parking.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.boot.parking.model.Admin;

@Mapper
public interface AdminMapper {
	// store_code로 Admin 정보 가져오기
    Admin getAdminByStoreCode(@Param("store_code") int store_code);
    // 쿠폰 개수 업데이트
    int updateCoupons(Admin admin);
}



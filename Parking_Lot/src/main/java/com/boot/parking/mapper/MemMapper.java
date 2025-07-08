package com.boot.parking.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.boot.parking.model.Member;

@Mapper
public interface MemMapper {

	Member login(@Param("mem_id") String mem_id, @Param("mem_pwd") String mem_pwd);
}

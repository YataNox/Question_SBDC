package com.sbdc.dao;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Mapper;

import com.sbdc.dto.MemoryVO;

@Mapper
public interface IMemoryDAO {
	public void MemoryWrite(MemoryVO mvo);
	public ArrayList<MemoryVO> GetMemoryList(int memo_data_num, String memo_data_kind);
}

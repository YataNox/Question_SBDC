package com.sbdc.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sbdc.dao.IMemoryDAO;
import com.sbdc.dto.MemoryVO;


@Service
public class MemoryService {

	@Autowired
	IMemoryDAO imdao;
	
	public void MemoryWrite(MemoryVO mvo) {
		if(mvo.getMemo_update_text().equals(""))
			return;
		
		imdao.MemoryWrite(mvo);
	}
	
	public ArrayList<MemoryVO> GetMemoryList(int memo_data_num, String memo_data_kind){
		return imdao.GetMemoryList(memo_data_num, memo_data_kind);
	}
}

package com.sbdc.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sbdc.dao.IResultDAO;
import com.sbdc.dto.Paging;
import com.sbdc.dto.ResultVO;
import com.sbdc.dto.StatisticsVO;

@Service
public class ResultService {

	@Autowired
	IResultDAO irdao;
	
	// biz_num에 해당하는 결과를 리턴하는 함수
	public ResultVO GetResult(int biz_Num) {
		return irdao.GetResult(biz_Num);
	}
	
	// 결과의 biz_num들을 리턴하는 함수
	public ArrayList<Integer> GetBiz_Nums(){
		return irdao.GetBiz_Nums();
	}
	
	// DB의 결과의 총 갯수를 리턴하는 함수
	public int GetResultCount() {
		return irdao.GetResultCount();
	}
	
	// 페이지 객체와 정렬타입에 맞는 최대 10개의 결과리스트를 리턴하는 함수
	public ArrayList<ResultVO> GetResultList(Paging paging, String sortType){
		return irdao.GetResultList(paging, sortType);
	}
	
	// biz_num에 해당하는 결과를 비공개 처리하는 함수
	public void DeleteResult(int biz_num) {
		irdao.DeleteResult(biz_num);
	}
	
	// 입력받은 ResultVO를 기반으로 데이터를 수정하는 함수
	public boolean UpdateResult(ResultVO rvo) {
		// update시 성공한 행의 개수를 반환
		int isSuccess = irdao.UpdateResult(rvo);
		
		// 1이상일 경우 수정 성공의미, true 반환
		if(isSuccess > 0)
			return true;
		
		// 실패 시 false 반환
		return false;
	}
	
	// 입력받은 ResultVO를 기반으로 새로운 데이터를 Insert하는 함수	
	public boolean WriteResult(ResultVO rvo) {
		// insert시 성공한 행의 개수를 반환
		int isSuccess = irdao.WriteResult(rvo);
		
		// 1이상일 경우 삽입 성공의미, true 반환
		if(isSuccess > 0)
			return true;
		
		// 실패 시 false 반환
		return false;
	}
	
	// 결과 테이블의 모든 결과들을 리턴하는 함수
	public ArrayList<ResultVO> getResultALL(){
		return irdao.getResultALL();
	}
	
	// 사용자 페이지에서 도출된 결과의 도출횟수를 +1 하기위한 함수
	public void SetResultCount(int biz_num) {
		irdao.SetResultCount(biz_num);
	}
	
	public StatisticsVO GetTotalCount() {
		return irdao.GetTotalCount();
	}
	
	public int GetLastBiz_num() {
		return irdao.GetLastBiz_num();
	}
}

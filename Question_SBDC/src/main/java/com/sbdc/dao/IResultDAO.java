package com.sbdc.dao;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Mapper;

import com.sbdc.dto.Paging;
import com.sbdc.dto.ResultVO;
import com.sbdc.dto.StatisticsVO;

@Mapper
public interface IResultDAO {
	public ResultVO GetResult(int bizNum);
	public ArrayList<Integer> GetBiz_Nums();
	public int GetResultCount();
	public ArrayList<ResultVO> GetResultList(Paging paging, String sortType);
	public void DeleteResult(int biz_num);
	public int UpdateResult(ResultVO rvo);
	public int WriteResult(ResultVO rvo);
	public ArrayList<ResultVO> getResultALL();
	public void SetResultCount(int biz_num);
	public StatisticsVO GetTotalCount();
	public int GetLastBiz_num();
}

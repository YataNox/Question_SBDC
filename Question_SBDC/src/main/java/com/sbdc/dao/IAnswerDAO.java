package com.sbdc.dao;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Mapper;

import com.sbdc.dto.AnswerVO;

@Mapper
public interface IAnswerDAO {
	public ArrayList<AnswerVO> GetAnswers(int questionNum);
	public void DeleteAnswer(int answ_q_inside_num);
	public void DeleteAnswerByRealNum(int realNum);
	public int UpdateAnswer(AnswerVO avo);
	public int WriteAnswer(AnswerVO avo);
	public int GetLastAnswer(int answ_q_inside_num);
}

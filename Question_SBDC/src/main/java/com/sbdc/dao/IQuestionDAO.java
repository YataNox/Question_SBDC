package com.sbdc.dao;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Mapper;

import com.sbdc.dto.Paging;
import com.sbdc.dto.QuestionVO;

@Mapper
public interface IQuestionDAO {
	
	public QuestionVO GetQuestion(int depth, int questionNum);
	public QuestionVO GetQuestionByRealQNum(int realQNum);
	public ArrayList<QuestionVO> GetQuestionList(Paging paging, String sortType);
	public int GetQuestionCount();
	public void DeleteQuestion(int ques_real_q_num);
	public int UpdateQuestion(QuestionVO qvo);
	public int QuestionWrite(QuestionVO qvo);
}

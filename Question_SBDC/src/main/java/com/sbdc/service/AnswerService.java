package com.sbdc.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sbdc.dao.IAnswerDAO;
import com.sbdc.dto.AnswerVO;

@Service
public class AnswerService {
	
	@Autowired
	IAnswerDAO iadao;
	
	// ques_real_Q_num에 해당하는 하위 답변들을 가져오는 함수
	public ArrayList<AnswerVO> GetAnswers(int questionNum){
		return iadao.GetAnswers(questionNum);
	}
	
	// 해당 answ_q_inside_num에 해당하는 답변들을 비공개처리하는 함수
	public void DeleteAnswer(int answ_q_inside_num) {
		iadao.DeleteAnswer(answ_q_inside_num);
	}
	
	// 입력받은 AnswerVO 객체를 기반으로 DB 답변 테이블을 수정하는 함수
	public boolean UpdateAnswer(AnswerVO avo) {
		// Update 성공시 수정한 행의 개수 반환
		int isSuccess = iadao.UpdateAnswer(avo);
		
		// 1이상일 경우 성공을 의미 true 반환
		if(isSuccess > 0)
			return true;
		
		// 실패 시 false 반환
		return false;
	}
	
	// 입력받은 답변 번호들에 해당하는 답변들을 비공개처리하기 위한 함수
	public void DeleteAnswerByRealNum(int realNum) {
		iadao.DeleteAnswerByRealNum(realNum);
	}
	
	// 입력받은 AnswerVO를 기반으로 새 답변을 DB에 입력하는 함수
	public boolean WriteAnswer(AnswerVO avo) {
		// Insert 후 삽입한 행의 개수를 리턴
		int isSuccess = iadao.WriteAnswer(avo);
		
		// 1이상일 경우 성공을 의미 true 반환
		if(isSuccess > 0)
			return true;
		
		// 실패 시 false 반환
		return false;
	}
	
	public int GetLastAnswer(int answ_q_inside_num) {
		return iadao.GetLastAnswer(answ_q_inside_num);
	}
}


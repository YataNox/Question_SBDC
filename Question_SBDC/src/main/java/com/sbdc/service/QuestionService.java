package com.sbdc.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sbdc.dao.IQuestionDAO;
import com.sbdc.dto.Paging;
import com.sbdc.dto.QuestionVO;

@Service
public class QuestionService {
	
	@Autowired
	IQuestionDAO iqdao;
	
	// 입력받은 단계, 세부번호에 해당하는 문항을 가져와 리턴하는 함수
	public QuestionVO GetQuestion(int depth, int questionNum) {
		return iqdao.GetQuestion(depth, questionNum);
	}
	
	// 입력받은 문항번호에 해당하는 문항을 리턴하는 함수
	public QuestionVO GetQuestionByRealQNum(int realQNum) {
		return iqdao.GetQuestionByRealQNum(realQNum);
	}
	
	// 페이지 객체와 정렬타입에 맞는 최대 10개의 문항 리스트를 리턴하는 함수
	public ArrayList<QuestionVO> GetQuestionList(Paging paging, String sortType){
		return iqdao.GetQuestionList(paging, sortType);
	}
	
	// 문항 테이블의 총 데이터 개수를 리턴하는 함수
	public int GetQuestionCount() {
		return iqdao.GetQuestionCount();
	}
	
	// 입력받은 문항번호의 문항을 비공개 처리하는 함수
	public void DeleteQuestion(int ques_real_q_num) {
		iqdao.DeleteQuestion(ques_real_q_num);
	}
	
	// 입력받은 QuestionVO를 기반으로 문항을 수정하는 함수
	public boolean UpdateQuestion(QuestionVO qvo) {
		// DAO에 QuestionVO를 넘겨 Update 실행
		// Update에 성공한 Row 수를 리턴 받는다.
		// 성공 : 1 이상, 0 업데이트 실패
		int isSuccess = iqdao.UpdateQuestion(qvo);
		
		// 업데이트에 성공할 경우 true 반환
		if(isSuccess > 0)
			return true;
		
		// 실패 시 false 반환
		return false;
	}
	
	// 단계와 세부번호를 이용해서 작성할 문항의 중복을 체크하는 함수
	public boolean DuplicateChk(int realDepth, int quesNum) {
		QuestionVO qvo = iqdao.GetQuestion(realDepth, quesNum);
		
		if(qvo != null)
			return true;
		else
			return false;
	}
	
	// 입력받은 QuestionVO를 기반으로 새로운 문항을 Insert하는 함수
	public boolean QuestionWrite(QuestionVO qvo) {
		// Insert를 실행 후 Insert한 row 수를 반환한다.
		int isSuccess = iqdao.QuestionWrite(qvo);
		
		// 변수 값이 1이상일 경우 삽입에 성공했다는 의미.
		// true 반환
		if(isSuccess > 0)
			return true;
		
		// 실패 일경우 false 반환
		return false;
	}
}

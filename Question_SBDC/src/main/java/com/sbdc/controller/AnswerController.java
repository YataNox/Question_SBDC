package com.sbdc.controller;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.sbdc.dto.AdminVO;
import com.sbdc.dto.AnswerVO;
import com.sbdc.dto.MemoryVO;
import com.sbdc.service.AnswerService;
import com.sbdc.service.MemoryService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
public class AnswerController {
	@Autowired
	AnswerService aws;
	
	@Autowired
	MemoryService ms;
	
	// 답변 수정
	// 답변 수정 페이지에서 수정 버튼을 눌렀을 때 실행하는 함수로 입력한 값을 기반으로
	// 해당 답변 데이터의 값을 Update 한다.
	// RequestParam의 값을 [] 배열로 받는 이유는 답변 수정 시 하나씩만 수정하는 것이아닌
	// 여러 답변의 수정 값을 받아서 수정하기에 '같은 이름의 여러 값'이온다. 그래서 배열로 받는 것.
	@RequestMapping(value = "/AnswerUpdate", method = RequestMethod.POST)
	public ModelAndView AnswerUpdate(HttpServletRequest request,
			@RequestParam("ques_real_q_num") int realQNum, @RequestParam("answ_real_num") int[] realNum,
			@RequestParam("answ_text") String[] answerText, @RequestParam("answ_final_yn") String[] finalyn,
			@RequestParam(value="biz_num", defaultValue = "") String[] biz_num, @RequestParam("answ_next_level") int[] nextLevel,
			@RequestParam("answ_next_num") int[] nextNum) {
		ModelAndView mav = new ModelAndView();
		HttpSession session = request.getSession();
		
		if(session.getAttribute("loginAdmin") == null) {
			mav.setViewName("redirect:/AdminLoginForm");
			return mav;
		}
		
		AdminVO loginAdmin = (AdminVO)session.getAttribute("loginAdmin");
		
		// 수정 기록용 VO에 관리자 정보 저장
		MemoryVO mvo = new MemoryVO();
		mvo.setMemo_admin_name(loginAdmin.getAdm_id());
		mvo.setMemo_dept_name(loginAdmin.getAdm_dept_name());
		
		// view에서 받은 문항 번호를 이용해서 하위 답변들을 가져온 뒤에 vo에 저장한다.
		ArrayList<AnswerVO> avoList = aws.GetAnswers(realQNum);
		
		// 가져와서 저장된 vo의 값을 view에서 입력받은 값으로 바꿔준 뒤 바꿔준 값을 DB에 갱신하는 작업
		// 넘어온 댓글 개수 별로 실행을 반복한다.
		// 기존 값과 넘어온 값을 비교한 뒤 변경된 값들만 기존 값에 덮어씌워주고 기록내용을 저장한다.
		for(int i = 0; i < avoList.size(); i++) {
			// 기록 내용 초기화, 답변 번호 저장
			mvo.setMemo_update_text("");
			avoList.get(i).setAnsw_real_num(realNum[i]);
			
			// 다음 단계 비교
			if(avoList.get(i).getAnsw_next_level() != nextLevel[i]) {
				mvo.setMemo_update_text(mvo.getMemo_update_text() + "['" + avoList.get(i).getAnsw_next_level() + "'다음 단계 -> '" + nextLevel[i] + "'다음 단계] ");
				avoList.get(i).setAnsw_next_level(nextLevel[i]);
			}
			// 다음 하위단계 비교
			if(avoList.get(i).getAnsw_next_num() != nextNum[i]) {
				mvo.setMemo_update_text(mvo.getMemo_update_text() + "['" + avoList.get(i).getAnsw_next_num() + "'다음 하위단계 -> '" + nextNum[i] + "'다음 하위단계] ");
				avoList.get(i).setAnsw_next_num(nextNum[i]);
			}
			// 내용 비교
			if(!avoList.get(i).getAnsw_text().equals(answerText[i])) {
				mvo.setMemo_update_text(mvo.getMemo_update_text() + "['" + avoList.get(i).getAnsw_text() + "' -> '" + answerText[i] + "'] ");
				avoList.get(i).setAnsw_text(answerText[i]);
			}
			// 최종 답변 여부 비교
			if(!avoList.get(i).getAnsw_final_yn().equals(finalyn[i])) {
				mvo.setMemo_update_text(mvo.getMemo_update_text() + "['" + avoList.get(i).getAnsw_final_yn() + "'최종 답변 여부 -> '" + finalyn[i] + "'최종 답변 여부] ");
				avoList.get(i).setAnsw_final_yn(finalyn[i]);
			}
			
			// 수정 페이지에서 연결 결과페이지를 선택을 안할 시
			// 링크가 안걸려있는 0번 데이터에 연결하기 위한 조치
			if(biz_num.length != 0) {
				if(biz_num[i] == "")
					biz_num[i] = "0";
				
				if(avoList.get(i).getBiz_num() != Integer.parseInt(biz_num[i])) {
					mvo.setMemo_update_text(mvo.getMemo_update_text() + "['" + avoList.get(i).getBiz_num() + "'사업번호 -> '" + biz_num[i] + "'사업번호]");
				}
				avoList.get(i).setBiz_num(Integer.parseInt(biz_num[i]));
			}
			
			// 이후 AnswerService의 UpdateAnswer 함수를 실행해 데이터를 변경한다.
			// 현재 수정 사항이 없어도 avo는 기존 값으로 들어있기 때문에 기존 값으로 수정을 시도해
			// if문이 별의미가 없음 Memory쪽에서 한 번 더 확인을 해야함
			// text 부분이 "" 비어있을 경우 수정된 내용이 없다는 판단으로 Service쪽에서 처리
			if(aws.UpdateAnswer(avoList.get(i))) {
				mvo.setMemo_data_kind("답변");
				mvo.setMemo_data_num(avoList.get(i).getAnsw_real_num());
				mvo.setMemo_kind("수정");
				ms.MemoryWrite(mvo);
			}
		}
		
		// 이후 변경된 값을 보여주기위해 문항 상세 페이지로 돌아간다.
		mav.addObject("ques_real_q_num", realQNum);
		mav.setViewName("redirect:/AdminQuestionDetailForm");
		return mav;
	}
	
	// 답변 삭제
	// 답변 삭제를 위한 함수
	// View에서 체크박스로 체크한 답변들의 답변번호를 가지고 와서
	// DB의 데이터의 answ_is_showing 값을 'Y'에서 'N'으로 처리해 리스트에 보이지 않게 한다.
	// view에서 삭제할 답변의 번호 값은 delete라는 이름으로 저장되어 가져와 ansArr 배열에 저장되어 사용되어진다.
	@RequestMapping("/AnswerDelete")
	public ModelAndView AnswerDelete(HttpServletRequest request,
			@RequestParam("delete") int[] answArr, @RequestParam("ques_real_q_num") int realQNum) {
		ModelAndView mav = new ModelAndView();
		HttpSession session = request.getSession();
		
		if(session.getAttribute("loginAdmin") == null) {
			mav.setViewName("redirect:/AdminLoginForm");
			return mav;
		}
		
		// 가져온 번호들에 해당하는 답변을 하나씩 비공개 처리한다.
		for(int realNum : answArr)
			aws.DeleteAnswerByRealNum(realNum);
		
		mav.addObject("ques_real_q_num", realQNum);
		mav.setViewName("redirect:/AdminQuestionDetailForm");
		return mav;
	}
	
	
	// 답변 작성 
	// 작성페이지에서 입력한 답변을 DB에 Insert 하기 위한 함수
	@RequestMapping(value="/AnswerWrite", method = RequestMethod.POST)
	public ModelAndView AnswerWrite(HttpServletRequest request,
			@RequestParam("ques_real_q_num") int realQNum, 
			@RequestParam("answ_text") String answerText,
			@RequestParam("answ_final_yn") String finalyn, 
			@RequestParam(value="biz_num", defaultValue = "") String biz_num, 
			@RequestParam("answ_next_level") int nextLevel,
			@RequestParam("answ_next_num") int nextNum) {
		ModelAndView mav = new ModelAndView();
		HttpSession session = request.getSession();
		
		if(session.getAttribute("loginAdmin") == null) {
			mav.setViewName("redirect:/AdminLoginForm");
			return mav;
		}
		
		AdminVO loginAdmin = (AdminVO)session.getAttribute("loginAdmin");	
		
		// 빈 Answervo 객체를 생성하여
		AnswerVO avo = new AnswerVO();
		
		// 입력받은 값을 집어넣어서 저장한다.
		avo.setAnsw_q_inside_num(realQNum);
		avo.setAnsw_next_level(nextLevel);
		avo.setAnsw_next_num(nextNum);
		avo.setAnsw_text(answerText);
		avo.setAnsw_first_writer(loginAdmin.getAdm_dept_name());
		avo.setAnsw_final_yn(finalyn);
		
		if(biz_num.equals("")) {
			biz_num = "0";
			avo.setBiz_num(Integer.parseInt(biz_num));
		}
		
		// 입력받은 값이 저장되어 있는 AnswerVO를 이용해
		// DB에 Insert한다. 
		// Insert에 성공하면 Insert기록을 작성하여 Memory테이블에 저장한다.
		if(aws.WriteAnswer(avo)) {
			int answ_Real_Num = aws.GetLastAnswer(realQNum);
	
			MemoryVO mvo = new MemoryVO();
			mvo.setMemo_admin_name(loginAdmin.getAdm_id());
			mvo.setMemo_dept_name(loginAdmin.getAdm_dept_name());
			mvo.setMemo_data_kind("답변");
			mvo.setMemo_data_num(answ_Real_Num);
			mvo.setMemo_kind("작성");
			mvo.setMemo_update_text("[상위 문항 번호 : " + realQNum + "] [다음 문항 단계 : " + nextLevel + "] [다음 문항 세부단계 : " + nextNum + 
					"] [답변 내용 : " + answerText + "] [최종 답변 여부 : " + finalyn + "] [최종 사업 번호 : " + biz_num + "]");
			ms.MemoryWrite(mvo);
		}
		
		mav.addObject("ques_real_q_num", realQNum);
		mav.setViewName("redirect:/AdminQuestionDetailForm");
		return mav;
	}
}
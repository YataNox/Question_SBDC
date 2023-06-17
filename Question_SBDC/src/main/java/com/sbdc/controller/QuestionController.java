package com.sbdc.controller;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.sbdc.dto.AdminVO;
import com.sbdc.dto.AnswerVO;
import com.sbdc.dto.MemoryVO;
import com.sbdc.dto.QuestionVO;
import com.sbdc.service.AnswerService;
import com.sbdc.service.MemoryService;
import com.sbdc.service.QuestionService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
public class QuestionController {

	@Autowired
	QuestionService qs;
	
	@Autowired
	AnswerService as;
	
	@Autowired
	MemoryService ms;
	
	// 사용자 Intro 페이지 이동
	@GetMapping("/")
	public String Main()
	{
		return "main/Intro";
	}
	
	// 설문 페이지 이동
	// N단계에 해당하는 설문 페이지로 이동하기 위한 함수.
	// 문항의 단계와 세부번호를 VIEW에서 받아서 이에 해당하는 문항과 답변을 출력해서 
	// 보여주는 함수
	@RequestMapping("/PageShift")
	public ModelAndView PageShift(@RequestParam("ques_real_depth") int depth,
			@RequestParam("ques_num") int questionNum) 
	{
		ModelAndView mav = new ModelAndView();
		
		// 해당 문항의 단계와 세부번호에 해당하는 문항을 가져와서 vo에 저장하고
		// 그 문항의 문항번호에 해당하는 하위 답변들을 가져와서 vo에 저장한다.
		QuestionVO qvo = qs.GetQuestion(depth, questionNum);
		ArrayList<AnswerVO> avoList = as.GetAnswers(qvo.getQues_real_q_num());
		
		// 이후 값들과 함께 main폴더 안의 Question.jsp를 띄워준다.
		mav.addObject("qvo", qvo);
		mav.addObject("avoList", avoList);
		mav.setViewName("main/Question");
		return mav;
	}
	
	// 문항들 삭제
	// 관리자 페이지에서 체크박스에 체크한 문항들을 비공개(삭제)처리하기 위한 함수
	// 문항들의 문항번호들을 받아서 해당 문항의 ques_is_showing을 'N' 처리한다.
	@RequestMapping(value = "/QuestionDelete", method = RequestMethod.POST)
	public ModelAndView AdminQuestionDelete(HttpServletRequest request,
			@RequestParam("ques_real_q_num") int[] quesArr) {
		ModelAndView mav = new ModelAndView();
		HttpSession session = request.getSession();
		
		if(session.getAttribute("loginAdmin") == null) {
			mav.setViewName("redirect:/AdminLoginForm");
			return mav;
		}

		// 문항을 비공개(삭제) 할 때 문항의 하위 답변들도 비공개 처리를 해야한다.
		// 비공개 처리할 문항의 하위 답변부터 비공개 처리를 한 후,
		// 해당 문항을 비공개한다.
		for (int ques_real_q_num : quesArr) {
			as.DeleteAnswer(ques_real_q_num);
			qs.DeleteQuestion(ques_real_q_num);
		}
		
		mav.setViewName("redirect:/AdminMain");
		return mav;
	}
	
	// 문항 수정
	// 수정 페이지에서 입력한 문항 수정 내용 대로 문항을 수정하기 위한 함수
	// 입력받은 데이터를 기반으로 문항을 Update 한다.
	@RequestMapping(value = "/QuestionUpdate", method = RequestMethod.POST)
	public ModelAndView QuestionUpdate(HttpServletRequest request,
			@RequestParam("ques_real_q_num") int realQNum, @RequestParam("ques_real_depth") int realDepth,
			@RequestParam("ques_num") int quesNum, @RequestParam("ques_text") String qText) {
		ModelAndView mav = new ModelAndView();
		HttpSession session = request.getSession();
		
		if(session.getAttribute("loginAdmin") == null) {
			mav.setViewName("redirect:/AdminLoginForm");
			return mav;
		}
		// 로그인한 관리자 정보를 가져온다.
		AdminVO loginAdmin = (AdminVO)session.getAttribute("loginAdmin");
		
		// 수정 기록용 VO에 관리자 정보 저장
		MemoryVO mvo = new MemoryVO();
		mvo.setMemo_admin_name(loginAdmin.getAdm_id());
		mvo.setMemo_dept_name(loginAdmin.getAdm_dept_name());
		mvo.setMemo_update_text("");
		
		// 해당 문항 번호를 가진 문항을 가져와서 VO에 저장한 뒤 입력받은 값으로 변경한다.
		// VO 저장 전 변경 된 값들을 확인한 뒤 기록에 남기고 저장한다.
		// if문으로 기존 문항의 값들과 새로 입력받은 값을 비교하여 변경사항이 있으면 기록내용과 그 값을 갱신한다.
		QuestionVO qvo = qs.GetQuestionByRealQNum(realQNum);
		// 단계 비교
		if(qvo.getQues_real_depth() != realDepth) {
			mvo.setMemo_update_text(mvo.getMemo_update_text() + "['" + qvo.getQues_real_depth() + "'단계 -> '" + realDepth + "'단계] ");
			qvo.setQues_real_depth(realDepth);
		}
		// 하위 단계 비교
		if(qvo.getQues_num() != quesNum) {
			mvo.setMemo_update_text(mvo.getMemo_update_text() + "['" + qvo.getQues_num() + "'하위단계 -> '" + quesNum + "'하위단계] ");
			qvo.setQues_num(quesNum);
		}
		// 문항 내용 비교
		if(!qvo.getQues_text().equals(qText)) {
			mvo.setMemo_update_text(mvo.getMemo_update_text() + "['" + qvo.getQues_text() + "' -> '" + qText + "]");
			qvo.setQues_text(qText);
		}
		
		// 그 변경된 VO를 이용해 QuestionService의 UpdateQuestion 함수를 실행해 Update한다.
		// 성공했을 시 true, 실패시 false를 반환 받는다.
		// update에 성공했을 시 수정 기록을 추가한다.
		if(qs.UpdateQuestion(qvo)) {
			mvo.setMemo_data_kind("문항");
			mvo.setMemo_data_num(qvo.getQues_real_q_num());
			mvo.setMemo_kind("수정");
			ms.MemoryWrite(mvo);
		}
		
		mav.addObject("ques_real_q_num", realQNum);
		mav.setViewName("redirect:/AdminQuestionDetailForm");
		return mav;
	}
	
	// 문항 작성
	// 작성 페이지에서 입력받은 대로 새로운 문항을 Insert한다.
	@RequestMapping(value = "/QuestionWrite", method = RequestMethod.POST)
	public ModelAndView QuestionWrite(HttpServletRequest request,
			@RequestParam("ques_real_depth") int realDepth,
			@RequestParam("ques_num") int quesNum, @RequestParam("ques_text") String qText) {
		ModelAndView mav = new ModelAndView();
		HttpSession session = request.getSession();
		
		if(session.getAttribute("loginAdmin") == null) {
			mav.setViewName("redirect:/AdminLoginForm");
			return mav;
		}
		
		AdminVO loginAdmin = (AdminVO)session.getAttribute("loginAdmin");		
		
		// 중복 단계를 체크하는 과정
		// 단계와 세부번호가 일치하는 문항이 이미 있으면 실패 메시지와 함께 작성 페이지로 돌아간다.
		if(qs.DuplicateChk(realDepth, quesNum)){
			mav.addObject("ErrorText", "(실패) : 단계(세부번호)가 중복되는 문항입니다.");
			mav.setViewName("admin/QuestionWriteForm");
			return mav;
		}
		
		// 중복이 아니라면 빈 QuestionVO 객체를 생성해 입력받은 값을 넣고 
		QuestionVO qvo = new QuestionVO();
		qvo.setQues_first_writer(loginAdmin.getAdm_dept_name());
		qvo.setQues_real_depth(realDepth);
		qvo.setQues_num(quesNum);
		qvo.setQues_text(qText);
		
		// QuestionService의 QuestionWrite함수를 실행해 Insert 한다.
		// Insert 성공시 true, 실패시 false를 리턴 받는다.
		// Insert에 성공했을 경우 작성기록을 추가한다.
		if(qs.QuestionWrite(qvo)){
			qvo = qs.GetQuestion(realDepth, quesNum);
			
			// 빈 MemoryVO를 생성한다.
			MemoryVO mvo = new MemoryVO();
			// 빈 VO에 로그인한 관리자의 id, 부서명, 작성한 값들에 대한 정보를 저장한다.
			mvo.setMemo_admin_name(loginAdmin.getAdm_id());
			mvo.setMemo_dept_name(loginAdmin.getAdm_dept_name());
			mvo.setMemo_data_kind("문항");
			mvo.setMemo_data_num(qvo.getQues_real_q_num());
			mvo.setMemo_kind("작성");
			mvo.setMemo_update_text("[단계 : " + qvo.getQues_real_depth() + "] [하위단계 : " + qvo.getQues_num() + "] [내용 : " + qvo.getQues_text() + "]");
			// 새로운 기록이 저장된 MemoryVO를 Insert하는 함수를 실행
			ms.MemoryWrite(mvo);
		}
		
		mav.setViewName("redirect:/AdminMain");
		return mav;
	}
}

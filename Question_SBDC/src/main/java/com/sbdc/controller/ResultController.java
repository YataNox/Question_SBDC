package com.sbdc.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.sbdc.dto.AdminVO;
import com.sbdc.dto.MemoryVO;
import com.sbdc.dto.ResultVO;
import com.sbdc.service.MemoryService;
import com.sbdc.service.ResultService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
public class ResultController {
	
	@Autowired
	ResultService rs;
	
	@Autowired
	MemoryService ms;
	
	// 결과 페이지 이동
	// 설문 페이지에서 마지막 답변을 선택해서 결과를 출력해야할 때 
	// 해당 결과 페이지를 띄우기 위한 함수
	// 답변 데이터에 저장된 biz_num 값을 가져와 해당 결과 데이터를 뽑아내 출력한다.
	@RequestMapping("/ResultForm")
	public ModelAndView ResultForm(@RequestParam("biz_num") int biz_Num){
		ModelAndView mav = new ModelAndView();
		
		// 해당 biz_num에 해당하는 결과를 가져와 저장
		ResultVO rvo = rs.GetResult(biz_Num);
		 
		// 이후 해당 결과의 도출 횟수를 +1한다.
		rs.SetResultCount(biz_Num);
		
		mav.addObject("rvo", rvo);
		mav.setViewName("main/ResultForm");
		return mav;
	}
	
	// 최종 사업 삭제
	// 사업 리스트에서 사업을 삭제하기 위한 함수
	@RequestMapping("/ResultDelete")
	public ModelAndView ResultDelete(HttpServletRequest request,
			@RequestParam("delete") int[] resArr) {
		ModelAndView mav = new ModelAndView();
		HttpSession session = request.getSession();
		
		if(session.getAttribute("loginAdmin") == null) {
			mav.setViewName("redirect:/AdminLoginForm");
			return mav;
		}
		
		for(int biz_num : resArr)
			rs.DeleteResult(biz_num);
		
		mav.setViewName("redirect:/AdminMain?ListType=Result");
		return mav;
	}
	
	// 최종 사업 수정
	// 수정 페이지에서 입력받은 데이터를 기반으로 결과를 수정하기 위한 함수
	@RequestMapping("/ResultUpdate")
	public ModelAndView ResultUpdate(HttpServletRequest request,
	@RequestParam("biz_num") int biz_num, @RequestParam("res_biz_text") String res_biz_text,
	@RequestParam("res_link") String res_link) {
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
		
		// 입력받은 biz_num을 기반으로 결과 정보를 가져와서 ResultVO에 저장하고
		// 저장되어 있는 기존 값과 View에서 넘겨받은 값을 비교한 후
		// 달라진 값만 덮어쓰고 기록 내용을 갱신한다.
		ResultVO rvo = rs.GetResult(biz_num);
		if(!rvo.getRes_biz_text().equals(res_biz_text)) {
			mvo.setMemo_update_text(mvo.getMemo_update_text() + "['" + rvo.getRes_biz_text() + "' -> '" + res_biz_text + "'] ");
			rvo.setRes_biz_text(res_biz_text);
		}
		if(!rvo.getRes_link().equals(res_link)) {
			mvo.setMemo_update_text(mvo.getMemo_update_text() + "['" + rvo.getRes_biz_text() + "'연결링크 -> '" + res_biz_text + "'연결링크] ");
			rvo.setRes_link(res_link);
		}
		
		// 이후 ResultService의 UpdateResult함수를 실행해 Update한다.
		// 성공 여부를 true, fasle로 받아서 성공시 기록을 남긴다.
		if(rs.UpdateResult(rvo)) {
			mvo.setMemo_data_kind("결과");
			mvo.setMemo_data_num(rvo.getBiz_num());
			mvo.setMemo_kind("수정");
			ms.MemoryWrite(mvo);
		}
		
		mav.addObject("biz_num", biz_num);
		mav.setViewName("redirect:/AdminResultDetailForm");
		return mav;
	}
	
	// 결과 작성
	// 작성 페이지에서 입력받은 값을 기반으로 새 결과를 Insert한다.
	@RequestMapping("/ResultWrite")
	public ModelAndView ResultWrite(HttpServletRequest request,
		@RequestParam("res_biz_text") String res_biz_text,
		@RequestParam("res_link") String res_link) {
		ModelAndView mav = new ModelAndView();
		HttpSession session = request.getSession();
		
		if(session.getAttribute("loginAdmin") == null) {
			mav.setViewName("redirect:/AdminLoginForm");
			return mav;
		}
		
		// 로그인한 관리자 정보를 가져온다.
		AdminVO loginAdmin = (AdminVO)session.getAttribute("loginAdmin");
		
		ResultVO rvo = new ResultVO();
		rvo.setRes_biz_text(res_biz_text);
		rvo.setRes_link(res_link);
		
		// WriteResult 함수를 이용해 값을 DB에 저장
		// 입력받은 값을 저장에 성공했을 경우 해당 기록을 DB에 저장한다.
		if(rs.WriteResult(rvo)) {
			int biz_num = rs.GetLastBiz_num();
			
			// 빈 MemoryVO를 만들어 그 안에 기록 값을 저장한다.
			MemoryVO mvo = new MemoryVO();
			mvo.setMemo_admin_name(loginAdmin.getAdm_id());
			mvo.setMemo_dept_name(loginAdmin.getAdm_dept_name());
			mvo.setMemo_data_kind("결과");
			mvo.setMemo_data_num(biz_num);
			mvo.setMemo_kind("작성");
			mvo.setMemo_update_text("[내용 : " + rvo.getRes_biz_text() + "] [연결링크 : " + rvo.getRes_link() + "]");
			// 저장한 Memory값을 DB에 Insert 한다.
			ms.MemoryWrite(mvo);
		}
		
		mav.setViewName("redirect:/AdminMain?ListType=Result");
		return mav;
	}
}

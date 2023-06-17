package com.sbdc.controller;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.sbdc.dto.AdminVO;
import com.sbdc.dto.AnswerVO;
import com.sbdc.dto.MemoryVO;
import com.sbdc.dto.Paging;
import com.sbdc.dto.QuestionVO;
import com.sbdc.dto.ResultVO;
import com.sbdc.dto.StatisticsVO;
import com.sbdc.service.AdminService;
import com.sbdc.service.AnswerService;
import com.sbdc.service.MemoryService;
import com.sbdc.service.QuestionService;
import com.sbdc.service.ResultService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

// 컨트롤러는 앱의 사용자로부터의 입력에 대한 응답으로 모델 및/또는 뷰를 업데이트하는 로직을 포함한다.
// 요청에 따라 어떤 처리를 할지 결정하는 역할.
// 실질적인 처리는 Service쪽에 요청을 하여 리턴받고
// 사용자 뷰쪽에 리턴하는 것이 기본 구조
@Controller // 처리의 시작점인 Controller임을 지정해주는 어노테이션(주석)
public class AdminController {
	
	@Autowired // 의존성 주입을 도와주는 어노테이션으로 여기서는 해당 service객체의 생성을 보조한다.
	AdminService as;
	
	@Autowired
	AnswerService aws;
	
	@Autowired
	QuestionService qs;
	
	@Autowired
	ResultService rs;
	
	@Autowired
	MemoryService ms;
	
	//  클라이언트는 URL로 요청을 전송하는데, GetMapping이나 ReqeustMapping 어노테이션은 요청 URL을 어떤 메서드가 처리할 지 여부를 결정하는 것
	// ex) localhost/AdminLoginForm url을 치면 /AdminLoginForm과 GetMapping("path")의 path 부분에 일치하는 매핑 함수를 실행 
	// 관리자 로그인 페이지
	@GetMapping("/AdminLoginForm")  
	public String Admin() {
		return "admin/LoginForm"; // resources/application.properties 파일을 열어서 5~6 줄을 보면
		// 기본 jsp의 위치가 /WEB-INF/views/ 안에 .jsp 파일로 있다고 지정이 되어있음
		// 해당 함수가 실행되면 /WEB-INF/views/admin 폴더안에 LoginForm.jsp 파일을 실행한다는 의미
	}
	
	// 관리자 로그인
	//@RequestParam : HttpServletRequest와 같이 사용자의 요청에 관련된 정보를 가져온다. 
	//구조 : @RequestParam("View에서 가져올 데이터의 이름") [데이터타입] [가져온데이터를 담을 변수 이름]
	// HttpServletRequest에는 request 단에서 관리자의 정보를 담아서 저장하려고 가져다쓰는 객체(로그인 상태 확인)
	@RequestMapping("/AdminLogin")
	public ModelAndView AdminLogin(@RequestParam("id") String id, @RequestParam("pwd") String pwd,
			HttpServletRequest request){
		ModelAndView mav = new ModelAndView(); // view 객체를 저장하기 위한 변수
		
		AdminVO avo = as.AdminCheck(id); // AdminService에서 AdminCheck라는 함수를 사용해서 DAO에게 명령하여 입력한 ID에 해당하는 관리자 정보가 있는지 확인.
		// 해당 id의 관리자 정보가 있으면 AdminVO 객체에 담아서 저장.
		// VO : DB의 TB_ADMIN 테이블의 어트리뷰트 구조를 자바구조에 맞게 가지고 있는 객체
		
		mav.setViewName("admin/LoginForm");  // 해당 함수가 종료 됬을 때 추가로 실행할 매핑함수나, 사용자에게 띄워줄 view.jsp 파일을 지정하는 함수.
		// 이 함수가 종료 됬을 때 admin폴더안의 LoginForm.jsp 파일을 찾아서 실행하라는 의미.
		if (avo == null) { // avo, 즉 id에 해당하는 관리자 정보가 없을 때 오류 메시지를 담아서 LoginForm으로 돌아간다.
			mav.addObject("message", "id가 없습니다.");
			return mav;
		} else if (avo.getAdm_password() == null) { // 데이터를 가져왔지만 pwd 데이터가 없는 db 오류가 있을 때
			mav.addObject("message", "관리자에게 문의하세요");
			return mav;
		} else if (!avo.getAdm_password().equals(pwd)) { // 관리자 정보가 있지만 패스워드가 틀렸을 때
			mav.addObject("message", "비밀번호가 맞지 않습니다.");
			return mav;
		} else if (avo.getAdm_password().equals(pwd)) { // 정상 실행 일 때.
			HttpSession session = request.getSession(); // 세션을 저장할 객체
			session.setAttribute("loginAdmin", avo); // 세션에 loginAdmin이란 이름으로 avo, 즉 관리자의 정보를 저장한다.
			mav.setViewName("redirect:/AdminMain"); // 이후 /AdminMain 매핑함수를 실행한다.
			return mav;
		} else { // 이외의 오류가 발생했을 시
			mav.addObject("message", "원인미상의 오류로 로그인 불가");
			return mav;
		}
	}
	
	// 관리자 로그아웃
	@RequestMapping("/AdminLogout")
	public String logout(HttpServletRequest request) {
		HttpSession session = request.getSession();
		
		// 로그인 이후의 모든 함수에서는 세션에 loginAdmin이 있는지 확인하여 정상 로그인을 했는지 확인하는 작업을 거친다.
		// loginAdmin이 없다. = 정상 로그인을 하지 않고 접근했다
		if(session.getAttribute("loginAdmin") == null)
			return "redirect:/AdminLoginForm"; // 로그인 페이지로 돌아간다.
		
		session.removeAttribute("loginAdmin"); // 세션이 있어서 그 세션을 삭제하고 로그아웃을 한다.
		return "redirect:/AdminLoginForm";
	}
	
	// 관리자 메인페이지 : 문항 리스트 출력
	// 관리자의 메인 페이지로 문항 혹은 결과의 리스트를 보여주는 페이지
	// RequestParam의 변수는 ques_SortType : 문항리스트의 정렬타입을 가지고 있음.
	// res_SortType : 결과리스트의 정렬 타입을 가지고 있음.
	// listType : 문항리스트를 보여줄지 결과리스트를 보여줄지에 대한 값을 가지고 있음
	// page : 10개 씩 끊어서 보여주는 리스트에서 몇 페이지를 보여줄 지에 대한 값을 가지고 있음.
	@RequestMapping(value="/AdminMain")
	public ModelAndView AdminMain(HttpServletRequest request,
			@RequestParam(defaultValue = "ques_real_q_num", value="Question_Search") String ques_SortType,
			@RequestParam(defaultValue = "biz_num", value="Result_Search") String res_SortType,
			@RequestParam(defaultValue = "Question", value="ListType") String listType) {
		ModelAndView mav = new ModelAndView();
		HttpSession session = request.getSession();
		
		// 로그인을 한 상태인지 확인하는 작업. 없으면 로그인 페이지로 돌아간다.
		if(session.getAttribute("loginAdmin") == null)
		{
			mav.setViewName("redirect:/AdminLoginForm");
			return mav;
		}
		
		// 몇 페이지를 보여줄 지에 대한 설정을 하는 코드
		// 기본으로 1페이지를 보여주기 위해 page=1;을 해놓았지만
		// 세션 request의 page 파라미터를 받아와서 값이 있으면 해당 값에 해당하는 page를 가져오기 위해 저장한다.
		// 다른 기타 상황에서는 1페이지로 초기화한다.
		int page = 1;
		if (request.getParameter("page") != null) {
			page = Integer.parseInt(request.getParameter("page"));
			session.setAttribute("page", page);
		} else if (session.getAttribute("page") != null) {
			page = (int) session.getAttribute("page");
		} else {
			page = 1;
			session.removeAttribute("page");
		}
		
		// 페이지에 대한 정보를 가지고 있는 페이지 객체. 자세한 구조는 페이지객체를 확인할 것.
		Paging paging = new Paging();
		paging.setPage(page); // 위의 페이지 값을 집어넣어서 몇 페이지를 보여줄지 설정한다.
		
		if(listType.equals("Question")){ // listType이 Question일 때 문항리스트를 보여준다.
			int ques_Count = qs.GetQuestionCount(); // TB_Question 테이블에 데이터가 총 몇개인지를 가져온다.
			
			// 페이지 객체가 총 데이터가 몇 개 인지를 알아야 총 페이지 수가 계산이 되기 때문에
			// 총 문항 갯수를 페이지 객체에 집어 넣는다.
			paging.setTotalCount(ques_Count);
			paging.paging(); // 이후 그 개수를 기준으로 총 페이지 갯수를 계산한다.
			
			// 계산이 끝난 페이지 객체와 문항 정렬 타입을 가지고 QuestionService의 GetQuestionList 함수를 실행해
			// 정렬타입과 페이지에 맞는 문항리스트 10개의 정보를 가져와서 저장한다.
			ArrayList<QuestionVO> qvoList = qs.GetQuestionList(paging, ques_SortType);
			
			mav.addObject("qvoList", qvoList);// 가져온 문항 10개 정보를 qvoList란 이름으로 view에 보내기 위해 객체에 저장한다.
		}else if(listType.equals("Result")) { // listType이 Result일 때 결과리스트를 보여준다.
			int res_Count = rs.GetResultCount(); // 위의 문항과 마찬가지 데이터의 총 개수를 가져옴
			
			// 이하 같은 작업
			paging.setTotalCount(res_Count);
			paging.paging();
			
			ArrayList<ResultVO> rvoList = rs.GetResultList(paging, res_SortType);
			
			mav.addObject("rvoList", rvoList);
		}else { // listType이 Question도 Result도 아닐때 로그인 페이지로 돌아가게 만든다.
			mav.setViewName("redirect:/AdminLogout");
			return mav;
		}
		
		// 이후 View에서 사용할 수 있게 페이지 객체와 listType을 담아서 
		// admin 폴더안에 AdminMain.jsp를 띄워준다.
		mav.addObject("paging", paging);
		mav.addObject("listType", listType);
		mav.setViewName("admin/AdminMain");
		return mav;
	}
	
	// 문항 상세 페이지(하위 답변도 같이 출력)
	// view에서 보고싶은 문항의 텍스트를 클릭하면 문항의 ques_real_q_num값을 가져와서
	// 해당 문항의 데이터를 뽑아와 보여주기 위한 함수
	@RequestMapping("AdminQuestionDetailForm")
	public ModelAndView AdminQuestionDetailForm(HttpServletRequest request,
			@RequestParam("ques_real_q_num") int realQNum) {
		ModelAndView mav = new ModelAndView();
		HttpSession session = request.getSession();
		mav.setViewName("admin/QuestionDetailForm");
		
		if(session.getAttribute("loginAdmin") == null)
		{
			mav.setViewName("redirect:/AdminLoginForm");
			return mav;
		}
		
		// view에서 보내온 realQNum에 해당하는 문항 하나를 가져와 QuestionVO에 저장한다.
		// QuestionVO는 DB의 TB_QUESTION의 속성구조를 가지고 있다.
		QuestionVO qvo = qs.GetQuestionByRealQNum(realQNum);
		
		// 혹시나 삭제처리가 된 데이터가 리스트에 있어서 해당 리스트 상세를 검색한 것이라면
		// 상세를 보여주지 않고 메인으로 돌아가기 위한 코드
		if(qvo.getQues_is_showing().equals("N"))
		{
			mav.setViewName("redirect:/AdminMain");
			return mav;
		}
		
		// 해당 문항에 대한 하위 답변을 AnswerService의 GetAnswers 함수를 실행해 가져온다.
		ArrayList<AnswerVO> avoList = aws.GetAnswers(realQNum);
		
		// 이후 가져온 문항과 답변들의 정보를 저장해서 보낸다.
		// 위의 187줄에서 지정한 Admin폴더안의 QuestionDetailForm.jsp를 띄움
		mav.addObject("qvo", qvo);
		mav.addObject("avoList", avoList);
		return mav;
	}
	
	// 최종 사업 상세 페이지
	// 위의 문항 상세 페이지와 기본골자는 같음
	// biz_num에 해당하는 결과의 데이터를 가져와서 상세페이지에 띄움
	@RequestMapping("AdminResultDetailForm")
	public ModelAndView AdminResultDetailForm(HttpServletRequest request,
			@RequestParam("biz_num") int biz_num) {
		ModelAndView mav = new ModelAndView();
		HttpSession session = request.getSession();
		mav.setViewName("admin/ResultDetailForm");
			
		if(session.getAttribute("loginAdmin") == null)
		{
			mav.setViewName("redirect:/AdminLoginForm");
			return mav;
		}
		
		// ResultService의 GetResult 함수를 실행해 결과 정보를 ResultVO에 담는다.
		// ResultVO : DB의 TB_RESULT의 속성 구조를 가지고 있다.
		ResultVO rvo = rs.GetResult(biz_num);
		
		if(rvo.getRes_is_showing().equals("N"))
		{
			mav.setViewName("redirect:/AdminMain?ListType=Result");
			return mav;
		}
			
		// 이후 가져온 결과 정보를 담아서 225줄에 설정한
		// admin폴더의 ResultDetailForm.jsp 를 띄운다.
		mav.addObject("rvo", rvo);
		return mav;
	}
	
	// 문항 수정 페이지
	// 문항 수정페이지를 띄우기 위한 함수
	// view에서 선택한 문항 번호를 가져와 해당 문항의 정보를 검색해
	// 정보와 같이 수정 페이지를 띄우는 함수
	@RequestMapping("/AdminQuestionUpdateForm")
	public ModelAndView AdminQuestionUpdateForm(HttpServletRequest request,
			@RequestParam("ques_real_q_num") int realQNum) {
		ModelAndView mav = new ModelAndView();
		HttpSession session = request.getSession();
		mav.setViewName("admin/QuestionUpdateForm");
		
		if(session.getAttribute("loginAdmin") == null)
		{
			mav.setViewName("redirect:/AdminLoginForm");
			return mav;
		}
		
		// QuestionService의 GetQuestionByRealQNum를 실행
		// 문항 번호에 해당하는 문항정보를 가져와 VO에 저장함
		QuestionVO qvo = qs.GetQuestionByRealQNum(realQNum);
		
		if(qvo.getQues_is_showing().equals("N"))
		{
			mav.setViewName("redirect:/AdminMain");
			return mav;
		}
		
		// 문항 수정 페이지에서도 해당 문항의 답변정도는 보여줄 예정이기에 
		// 문항 번호에 해당하는 답변들의 정보도 가져옴
		ArrayList<AnswerVO> avoList = aws.GetAnswers(realQNum);
		
		mav.addObject("qvo", qvo);
		mav.addObject("avoList", avoList);
		return mav;
	}
	
	// 답변 수정 페이지
	// 문항 수정 페이지와 같이 문항 상세 페이지에서 시작하는 답변 수정 페이지를 띄우기 위한 함수
	// 선택한 문항 번호에 해당하는 하위 답변들의 데이터를 가져와 답변 수정 페이지와 같이 띄운다.
	@RequestMapping("/AdminAnswerUpdateForm")
	public ModelAndView AdminAnswerUpdateForm(HttpServletRequest request,
			@RequestParam("ques_real_q_num") int realQNum) {
		ModelAndView mav = new ModelAndView();
		HttpSession session = request.getSession();
		
		if(session.getAttribute("loginAdmin") == null)
		{
			mav.setViewName("redirect:/AdminLoginForm");
			return mav;
		}
		
		QuestionVO qvo = qs.GetQuestionByRealQNum(realQNum);
		
		if(qvo.getQues_is_showing().equals("N"))
		{
			mav.setViewName("redirect:/AdminMain");
			return mav;
		}
		
		// 문항 수정 페이지와 다른 점은 답변 수정 시에 해당 답변이
		// 최종 결과를 출력해야하는 마지막 답변일 때 어떤 결과와 연결되어야 하는지의 대한
		// 값도 설정을 해야한다. 그 때 결과 테이블에 없는 번호도 적을 수 있으면 데이터를 집어넣는데 있어서 큰 오류.
		// 때문에 결과 테이블에서 biz_num 값들만 가져와서 해당 번호들만 이용하여 결과테이블을 연결할 수 있게한다.
		// 아래 rs.GetBiz_Nums()함수는 그것을 위한 함수.(결과 테이블에서 biz_num들 값만 가져온다.)
		ArrayList<AnswerVO> avoList = aws.GetAnswers(realQNum);
		ArrayList<Integer> bizNumList = rs.GetBiz_Nums();
		
		mav.addObject("bizNumList", bizNumList);
		mav.addObject("qvo", qvo);
		mav.addObject("avoList", avoList);
		mav.setViewName("admin/AnswerUpdateForm");
		return mav;
	}
	
	// 최종 사업 수정 페이지
	@RequestMapping("/AdminResultUpdateForm")
	public ModelAndView AdminResultUpdateForm(HttpServletRequest request,
			@RequestParam("biz_num") int biz_num) {
		ModelAndView mav = new ModelAndView();
		HttpSession session = request.getSession();
		mav.setViewName("admin/ResultUpdateForm");
		
		if(session.getAttribute("loginAdmin") == null)
		{
			mav.setViewName("redirect:/AdminLoginForm");
			return mav;
		}
		
		ResultVO rvo = rs.GetResult(biz_num);
		
		if(rvo.getRes_is_showing().equals("N"))
		{
			mav.setViewName("redirect:/AdminMain");
			return mav;
		}
		
		mav.addObject("rvo", rvo);
		return mav;
	}
	
	// 문항 작성 페이지
	// 문항 작성 페이지를 띄우기 위한 함수
	// 새 문항을 작성하는 것이기 때문에 로그인 확인을 제외한 기본적인 작업은 없다.
	@RequestMapping("/AdminQuestionWriteForm")
	public ModelAndView AdminQuestionWriteForm(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		HttpSession session = request.getSession();
		
		if(session.getAttribute("loginAdmin") == null)
		{
			mav.setViewName("redirect:/AdminLoginForm");
			return mav;
		}
		
		mav.setViewName("admin/QuestionWriteForm");
		return mav;
	}
	
	// 답변 작성 페이지
	// 문항 작성 페이지와는 다르게 문항의 하위 답변을 작성하는 것이기에
	// 답변을 작성할 상위 문항의 번호는 가지고 와서 그걸 기반으로 작성한다.
	// 그래서 답변 작성 페이지에는 답변 입력 창 위에 해당 문항의 정보를 출력해서 보여준다.(AnswerWriteForm 확인)
	@RequestMapping("/AdminAnswerWriteForm")
	public ModelAndView AdminAnswerWriteForm(HttpServletRequest request,
			@RequestParam("ques_real_q_num") int realQNum) {
		ModelAndView mav = new ModelAndView();
		HttpSession session = request.getSession();
		
		if(session.getAttribute("loginAdmin") == null)
		{
			mav.setViewName("redirect:/AdminLoginForm");
			return mav;
		}
		
		QuestionVO qvo = qs.GetQuestionByRealQNum(realQNum);
		ArrayList<Integer> bizNumList = rs.GetBiz_Nums();
		
		mav.addObject("bizNumList", bizNumList);
		mav.addObject("qvo", qvo);
		mav.setViewName("admin/AnswerWriteForm");
		return mav;
	}
	
	// 결과 작성 페이지
	@RequestMapping("/AdminResultWriteForm")
	public ModelAndView AdminResultWriteForm(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		HttpSession session = request.getSession();
		
		if(session.getAttribute("loginAdmin") == null)
		{
			mav.setViewName("redirect:/AdminLoginForm");
			return mav;
		}
		
		mav.setViewName("admin/ResultWriteForm");
		return mav;
	}
	
	// 통계 페이지 이동
	// 통계 페이지로 이동하기 위한 함수.
	// 결과들의 통계를 위한 페이지이기 때문에 결과들을 뽑아내서 통계페이지와 함께 띄운다.
	@RequestMapping("/AdminStatisticsForm")
	public ModelAndView AdminStatisticsForm(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		HttpSession session = request.getSession();
		
		if(session.getAttribute("loginAdmin") == null)
		{
			mav.setViewName("redirect:/AdminLoginForm");
			return mav;
		}
		
		// 모든 결과들의 리스트를 저장해서
		ArrayList<ResultVO> rvoList = rs.getResultALL();
		
		// 통계 페이지에 통계가 텍스트때문에 안뜨는 문제를 해결하기 위해
		// 텍스트를 한 번 가공하는 작업을 거친 후
		for(ResultVO rvo : rvoList) {
			rvo.setRes_biz_text("\""+rvo.getRes_biz_text().replaceAll(" ", "")+"\"");
		}
		
		// 총 사업 수 저장
		StatisticsVO svo = rs.GetTotalCount();
		
		// 통계 페이지를 띄운다.
		mav.addObject("svo", svo);
		mav.addObject("rvoList", rvoList);
		mav.setViewName("admin/StatisticsForm");
		return mav;
	}
	
	// 추가/수정 기록 팝업창
	// 데이터의 종류(문항, 답변, 결과)와 데이터의 번호의 값에 맞는 기록을 불러오는 함수
	// 불러온 값들을 보여주는 기록 페이지를 출력한다.
	@RequestMapping("/MemoryPopup")
	public ModelAndView MemoryPopup(HttpServletRequest request, @RequestParam("memo_data_num") int memo_data_num,
			@RequestParam("memo_data_kind") String memo_data_kind) {
		ModelAndView mav = new ModelAndView();
		HttpSession session = request.getSession();
		
		if(session.getAttribute("loginAdmin") == null) {
			mav.setViewName("redirect:/AdminLoginForm");
			return mav;
		}
		
		// 데이터 종류와 번호에 맞는 기록리스트들을 가져와서 저장한다.
		ArrayList<MemoryVO> mvoList = ms.GetMemoryList(memo_data_num, memo_data_kind);
		
		mav.addObject("mvoList", mvoList);
		mav.setViewName("admin/MemoryPopup");
		return mav;
	}
}

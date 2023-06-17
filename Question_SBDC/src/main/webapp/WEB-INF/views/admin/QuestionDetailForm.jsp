<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri='http://java.sun.com/jsp/jstl/core' prefix='c'%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>소상공인 자가진단 시스템 관리자</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link href="./CSS/frontstyle.css" rel="stylesheet">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
	href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@500&display=swap"
	rel="stylesheet">
<link rel="icon" href="./image/SBDC_favicon.png">
<script type="text/javascript" src="script/AdminScript.js"></script>
</head>
<body>
	<script
		src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.7/dist/umd/popper.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.min.js"></script>
	<!-- header -->
	<div class="header-container">
		<header
			class="d-flex flex-wrap justify-content-center py-3 mb-4 border-bottom">
			<a href=""
				class="d-flex align-items-center mb-3 mb-md-0 me-md-auto link-body-emphasis text-decoration-none">
				<svg class="bi me-2" width="40" height="32">
					<use xlink:href="#bootstrap"></use></svg> <span class="fs-4"> <img
					class="img-fluid" src=" ./image/SBDC_Logo_header2.png"
					style="width: 195px; height: 40px;"></img>
			</span>
			</a><input class="btn btn-danger rounded px-4" type="button"
				value="Logout" style="float: right;"
				onclick="location.href='AdminLogout'">
		</header>
	</div>

	<!-- main -->
	<div class="container-fluid" style = "height : 600px;">
		<div class="row">
			<div class="col-1"></div>
			<div class="col-10">
				<form name="frm" method="Post">
					<input type="hidden" name="ques_real_q_num"
						value="${qvo.ques_real_q_num}" checked="checked">
					<button type="button" class="btn btn-primary px-3"
						onclick="location.href='AdminMain'">목록으로</button>
					<button type="button" class="btn btn-primary px-3"
						onclick="location.href='AdminQuestionUpdateForm?ques_real_q_num=${qvo.ques_real_q_num}'">문항수정</button>
					<button type="button" class="btn btn-primary px-3"
						onclick="del_Question()">문항삭제</button>
					<button type="button" class="btn btn-primary px-3"
						onclick="Popup_Memory('${qvo.ques_real_q_num}', '문항');">문항 이력관리</button>

					<br> <br>
					<h4>
						<b>문항 상세</b>
					</h4>
					<table class="table table-striped table-sm">
						<thead>
							<tr>
								<th scope="col">문항 번호</th>
								<th scope="col">작성 부서</th>
								<th scope="col">문항 단계</th>
								<th scope="col">문항 세부단계</th>
								<th scope="col">문항 내용</th>
								<!-- 230523 (문항텍스트) 에서 (문항 내용)으로 변경 -->
								<th scope="col">등록일자</th>
								<th scope="col">수정횟수</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td>${qvo.ques_real_q_num}</td>
								<td>${qvo.ques_first_writer}</td>
								<td>${qvo.ques_real_depth}</td>
								<td>${qvo.ques_num}</td>
								<td>${qvo.ques_text}</td>
								<td>${qvo.ques_date}</td>
								<td>${qvo.ques_revise}</td>
							</tr>
					</table>
					<hr>
					<br> <br>
					<c:choose>
						<c:when test="${empty avoList}">
							<button type="button" class="btn btn-primary px-3"
								onclick="location.href='AdminAnswerWriteForm?ques_real_q_num=${qvo.ques_real_q_num}'">답변추가</button>
						</c:when>
						<c:otherwise>
							<button type="button" class="btn btn-primary px-3"
								onclick="location.href='AdminAnswerWriteForm?ques_real_q_num=${qvo.ques_real_q_num}'">답변추가</button>
							<button type="button" class="btn btn-primary px-3"
								onclick="location.href='AdminAnswerUpdateForm?ques_real_q_num=${qvo.ques_real_q_num}'">답변수정</button>
							<input type="button" class="btn btn-primary px-3" class="btn"
								value="답변삭제" onclick="del_Answer();">
						</c:otherwise>
					</c:choose>
					<br> <br>
					<h4>
						<b>문항 답변</b> <!-- 230601 (하위 선택가능 답변) 에서 (문항 답변)로 용어 수정-->
					</h4>
					<table class="table table-striped table-sm">
						<c:choose>
							<c:when test="${empty avoList}">
								<p>작성된 답변이 없습니다.</p> <!-- 230601 (작성된 하위 답변이 없습니다.) 에서 (작성된 답변이 없습니다.) 로 수정 -->
							</c:when>
							<c:otherwise>
								<table class="table table-striped table-sm">
									<thead style = "vertical-align : top;">
										<tr>
											<th scope="col" style="">삭제</th>
											<th scope="col">번호</th>
											<th scope="col">작성부서</th>
											<th scope="col">해당 문항<br>세부답변 번호</th>
											<th scope="col">다음 문항<br>연계 단계</th>
											<th scope="col">다음 문항<br>연계 세부번호</th>
											<th scope="col">답변 내용</th>
											<!-- 230523 (답변 텍스트) -> (답변 내용) 으로 수정-->
											<th scope="col">마지막<br>답변 여부</th>
											<th scope="col">최종<br>사업 번호</th>
											<th scope="col">등록일자</th>
											<th scope="col">수정횟수</th>
											<th scope="col">이력</th> <!-- 230601 (작성기록) 에서 (로그)로 수정 -->
										</tr>
									</thead>
									</c:otherwise>
									</c:choose>

									<c:forEach var="avoList" items="${avoList}">
										<tr>
											<td><input type="checkbox" name="delete"
												value="${avoList.answ_real_num}"></td>
											<td>${avoList.answ_real_num}</td>
											<td>${avoList.answ_first_writer}</td>
											<td>${avoList.answ_q_inside_num}</td>
											<td>${avoList.answ_next_level}</td>
											<td>${avoList.answ_next_num}</td>
											<td>${avoList.answ_text}</td>
											<td>${avoList.answ_final_yn}</td>
											<c:if test="${avoList.answ_final_yn eq 'Y'}">
												<td>${avoList.biz_num}</td>
											</c:if>
											<c:if test="${avoList.answ_final_yn eq 'N'}">
												<td></td>
											</c:if>
											<td>${avoList.answ_date}</td>
											<td>${avoList.answ_revise}</td>
											<td><button type="button" class="btn btn-primary px-3"
													onclick="Popup_Memory('${avoList.answ_real_num}', '답변');">기록</button></td>
										</tr>
									</c:forEach>
								</table>
								</form>
								<div class="col-1"></div>
								</div>
								</div>

								<!-- footer -->
								<hr>
								<div class="footer-container" style="box-sizing: border-box;">
									<div class="box_footer">
										<!--   <div class="footer_link clearfix">
                <button type="button">Footer Link</button>
                <ul>
                    <li class="point"><a
                            href="https://www.sbdc.or.kr/etc/privacy-rule"
                            target="_blank">개인정보처리방침</a></li>
                    <li><a href="https://www.sbdc.or.kr/etc/cctv"
                           target="_blank">CCTV 설치 및 운영방침</a></li>
                    <li><a href="https://www.sbdc.or.kr/etc/site-term"
                           target="_blank">이용약관</a></li>
                </ul>
            </div>
            <div class="footBtn">
                <button type="button">
                    <span>기관관련 홈페이지</span>
                </button>
                <div class="f_btn_scroll">
                    <ul>
                        <li><a href="https://www.sbdc.or.kr/" target="_blank">중소기업유통센터</a>
                        </li>
                        <li><a href="https://www.haengbok.com/main/main.asp"
                               target="_blank">행복한백화점</a></li>
                        <li><a href="https://v.dongbanmall.com/main"
                               target="_blank">가치삽시다</a></li>
                        <li><a href="http://www.sblink.or.kr/front/main.do"
                               target="_blank">아임셀러</a></li>
                        <li><a href="https://www.imstars.or.kr/"
                               target="_blank">아임스타즈</a></li>
                        <li><a href="https://www.smpp.go.kr/smpp/index.do"
                               target="_blank">공공구매정보망</a></li>
                        <li><a href="https://support.dongbanmall.com/"
                               target="_blank">동반성장몰</a></li>
                    </ul>
                </div>
            </div> -->
										<div class="container"
											style="flex-direction: row; box-sizing: border-box; display: flex; align-items: center;">
											<div>
												<img alt="footerLogo" src="/image/footer-logo.png">
											</div>
											<div>
												<div style="width: 800px; padding-left: 5%;">
													<div>
														<p
															style="color: rgb(135, 138, 143); margin: 0; padding: 0; border: 0; font-size: 100%; text-align: left;">
															(07997) 서울특별시 양천구 목동동로 309 중소기업유통센터</p>
														<p
															style="color: rgb(135, 138, 143); margin: 0; padding: 0; border: 0; font-size: 100%; text-align: left;">
															대표자 : 이태식 / 대표전화 : 02-6678-9000 / 사업자등록번호 : 107-81-53660</p>
														<p
															style="color: rgb(135, 138, 143); margin: 0; padding: 0; border: 0; font-size: 100%; text-align: left;">
															© Small &amp; Medium Business Distribution Center. All
															Rights Reserved.</p>

													</div>
												</div>


											</div>
										</div>
									</div>
								</div>
								</div>
</body>
</html>
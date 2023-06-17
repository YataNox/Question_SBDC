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
	<div class="">
		<div class="container-fluid">
			<div class="row">
				<div class="col-1"></div>
				<div class="col-10">
					<div class="container text-center">
						<div class="row justify-content-between">
							<c:choose>
								<c:when test="${listType eq 'Result'}">
									<div class="col-md-5">
									<div style="float: left;">
										<form name="frm" method="post">
											<button type="button" class="btn btn-outline-secondary"
												onclick="Sort_QuestionList();">질문리스트 돌아가기</button>
											<button type="button" class="btn btn-primary"
												onclick="location.href='AdminResultWriteForm'">사업추가</button>
											<c:choose>
												<c:when test="${empty rvoList}">
												</c:when>
												<c:otherwise>
													<input type="button" class="btn btn-primary" value="사업삭제"
														onclick="del_Result();">
													<input type="button" class="btn btn-primary" value="통계보기"
														onclick="location.href='AdminStatisticsForm'">
												</c:otherwise>
											</c:choose>
										</div>
									</div>
									<div class="col col-lg-2">
										<!-- <select name="Result_Search" onchange="Sort_ResultList();">  -->
											<!-- <option>정렬 기준</option> -->
											<!-- <option value="biz_num ASC">사업번호 오름차순</option> -->
											<!-- <option value="biz_num DESC">사업번호 내림차순</option> -->
											<!-- 230522 등록일자 오름, 내림차순 삭제 -->
											<!-- <option value="res_date ASC">등록일자 오름차순</option> -->
											<!-- <option value="res_date DESC">등록일자 내림차순</option> -->
										</select> <br> <br>
									</div>
						</div>
					</div>
					<!-- 사업번호 버튼 -->
					<table class="table table-striped table-sm">
						<thead>
							<tr>
								<th scope="col"></th>
								<th scope="col">사업번호</th>
								<th scope="col">작성부서</th>
								<th scope="col">사업명</th>
								<th scope="col">연결주소/URL</th>
								<th scope="col">선호도</th>
								<th scope="col">등록일자</th>
								<th scope="col">수정횟수</th>
							</tr>
						</thead>
						<c:forEach var="rvoList" items="${rvoList}">
							<tr>
								<td><input type="checkbox" name="delete"
									value="${rvoList.biz_num}"></td>
								<td>${rvoList.biz_num}</td>
								<td>${rvoList.res_first_writer}</td>
								<td><a
									href="AdminResultDetailForm?biz_num=${rvoList.biz_num}">${rvoList.res_biz_text}</a></td>
								<td>${rvoList.res_link}</td>
								<td>${rvoList.res_count}</td>
								<td>${rvoList.res_date}</td>
								<td>${rvoList.res_revise}</td>
							</tr>
						</c:forEach>
					</table>
					</form>
					</c:when>
					<c:otherwise>
						<div class="container text-center">
							<div class="row justify-content-between">
								<div class="col-md-5">
								<div style="float: left;">
									<form name="frm" method="post">
										<button type="button" class="btn btn-primary"
											onclick="Sort_ResultList();">사업리스트</button>
										<button type="button" class="btn btn-primary"
											onclick="location.href='AdminQuestionWriteForm'">문항추가</button>
										<c:choose>
											<c:when test="${empty qvoList}">

											</c:when>
											<c:otherwise>
												<input type="button" class="btn btn-primary" value="문항삭제"
													onclick="del_Question();">
												<input type="button" class="btn btn-primary" value="통계보기"
													onclick="location.href='AdminStatisticsForm'">
											</c:otherwise>
										</c:choose>
										</div>
								</div>
								<div class="col col-lg-2">
									<!-- <select name="Question_Search" onchange="Sort_QuestionList();">  -->
										<!--  <option>정렬 기준</option>  -->
										<!-- <option value="ques_real_q_num ASC">내부번호 오름차순</option>  -->
										<!-- 20522 (번호 오름차순) 에서 (내부번호 오름차순) 으로 수정 -->
										<!-- <option value="ques_real_q_num DESC">내부번호 내림차순</option>  -->
										<!-- 20522 (번호 오름차순) 에서 (내부번호 내림차순) 으로 수정 -->
										<!-- 230522 단계, 등록일자 오름/내림차순 비활성화 -->
										<!-- <option value="ques_real_depth ASC">단계 오름차순</option>  -->
										<!-- <option value="ques_real_depth DESC">단계 내림차순</option>  -->
										<!-- <option value="ques_date ASC">등록일자 오름차순</option>  -->
										<!-- <option value="ques_date DESC">등록일자 내림차순</option> -->
									</select> <br> <br>
								</div>
							</div>
						</div>
						<table class="table table-striped table-sm">
							<thead>
								<tr>
									<th scope="col"></th>
									<!-- # 에서 공백으로 수정 -->
									<th scope="col">문항 번호</th>
									<!-- 230522 (문항실제번호) 에서 (문항내부번호)로 수정 -->
									<!-- 230526 (문항내부번호) 에서 (문항번호)로 수정 -->
									<th scope="col">작성 부서</th>
									<th scope="col">문항 단계</th>
									<th scope="col">문항 세부단계</th>
									<!-- 230526 (문항 세부번호) 에서 (문항 세부단계)로 수정-->
									<th scope="col">문항 내용</th>
									<th scope="col">등록일자</th>
									<th scope="col">수정횟수</th>
								</tr>
							</thead>
							<c:forEach var="qvoList" items="${qvoList}">
								<tr>
									<td><input type="checkbox" name="ques_real_q_num"
										value="${qvoList.ques_real_q_num}"></td>
									<td>${qvoList.ques_real_q_num}</td>
									<td>${qvoList.ques_first_writer}</td>
									<td>${qvoList.ques_real_depth}</td>
									<td>${qvoList.ques_num}</td>
									<td><a
										href="AdminQuestionDetailForm?ques_real_q_num=${qvoList.ques_real_q_num}">${qvoList.ques_text}</a></td>
									<td>${qvoList.ques_date}</td>
									<td>${qvoList.ques_revise}</td>
								</tr>
							</c:forEach>
						</table>
						</form>
					</c:otherwise>
					</c:choose>


					<!-- 페이징처리 -->
					<jsp:include page="../../views/paging/paging.jsp">
						<jsp:param name="page" value="${paging.page}" />
						<jsp:param name="beginPage" value="${paging.beginPage}" />
						<jsp:param name="endPage" value="${paging.endPage}" />
						<jsp:param name="prev" value="${paging.prev}" />
						<jsp:param name="next" value="${paging.next}" />
						<jsp:param name="command" value="AdminMain?ListType=${listType}" />
					</jsp:include>
					<br>
					<br>
					<br>
					<br>
					<div class="col-1"></div>
				</div>
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
									© Small &amp; Medium Business Distribution Center. All Rights
									Reserved.</p>

							</div>
						</div>


					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>
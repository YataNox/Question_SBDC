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
	<div class="container-fluid">
		<div class="row">
			<div class="col-1"></div>
			<div class="col-10">
				<form name="frm" method="post">
					<input type="hidden" name="ques_real_q_num"
						value="${qvo.ques_real_q_num}">
					<button type="button" class="btn btn-primary px-3"
						onclick="location.href='AdminMain'">목록으로</button>

					<br> <br>
					<h4>
						<b>문항 상세</b>
					</h4>
					<br>
					<table class="table table-striped table-sm">
						<thead>
							<tr>
								<td>문항 번호</td>
								<!-- 230522 (문항 실 번호)에서 (문항 내부 번호) 로 변경 -->
								<td>문항 단계</td>
								<!-- 230522 (문항 실 단계)에서 (문항 단계)로 변경 -->
								<td>문항 세부단계</td>
								<td>문항 내용</td>
								<td>등록일자</td>
								<td>수정횟수</td>
							</tr>
						</thead>
						<tr>
							<td>${qvo.ques_real_q_num}</td>
							<td>${qvo.ques_real_depth}</td>
							<td>${qvo.ques_num}</td>
							<td>${qvo.ques_text}</td>
							<td>${qvo.ques_date}</td>
							<td>${qvo.ques_revise}</td>
						</tr>
					</table>

					<br> <br>
					<h4>
						<b>해당 문항에 대한 답변 작성</b>
					</h4>
					<br>
					<!-- 230522 (하위 답변 작성) 에서 (해당 문항에 대한 답변 작성) 으로 수정 -->
					<table class="table table-striped table-sm">
						<tr>
							<th colspan="2">해당 문항 세부답변 번호</th>
							<th colspan="2">${qvo.ques_real_q_num}</th>
							<th colspan="1">마지막 답변 여부</th>
							<td><select name="answ_final_yn">
									<option value="Y">Y</option>
									<option value="N" selected="selected">N</option>
							</select></td>
						</tr>
						<tr>
							<th>다음 문항 연계 단계</th>
							<td colspan="1"><input size="3" type="text"
								name="answ_next_level"></td>
							<th>다음 문항 연계 세부단계</th>
							<td colspan="1"><input size="3" type="text"
								name="answ_next_num"></td>
							<th colspan="1">최종 사업 번호</th>
							<td><select name="biz_num">
									<option value="">선택안함</option>
									<c:forEach var="bizNumList" items="${bizNumList}">
										<option value="${bizNumList}">${bizNumList}</option>
									</c:forEach>
							</select></td>
						</tr>
						<tr>
							<th>답변 텍스트</th>
							<td colspan="6"><textarea cols="80" rows="10"
									name="answ_text"></textarea></td>
						</tr>
					</table>
					<button class="btn btn-primary px-3" type="submit"
						onclick="Answer_WriteChk();">저장</button>
					<button class="btn btn-outline-secondary" type="reset"
						onclick="history.back()">뒤로가기</button>
					<!-- 230522 해당 기능 검토 필요, 230524 (취소) 에서 (뒤로라기) 로 수정 -->
				</form>
			</div>
		</div>
	</div>



	<!-- footer -->
	<hr>
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
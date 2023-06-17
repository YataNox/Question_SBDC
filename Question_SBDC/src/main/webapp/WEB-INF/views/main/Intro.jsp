<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link href="./CSS/frontstyle.css" rel="stylesheet">
<link rel="icon" href="./image/SBDC_favicon.png">
<title>소상공인 자가진단 시스템</title>



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
			<a href="/"
				class="d-flex align-items-center mb-3 mb-md-0 me-md-auto link-body-emphasis text-decoration-none">
				<svg class="bi me-2" width="40" height="32">
					<use xlink:href="#bootstrap"></use></svg> <span class="fs-4"> <img
					class="img-fluid" src=" ./image/SBDC_Logo_header2.png"
					style="width: 195px; height: 40px;"></img>
			</span>
			</a>
			
			<ul class="nav nav-pills">
				<li class="nav-item"><a href="http://www.sbdc.or.kr"
					class="nav-link active" aria-current="page">중소기업유통센터</a></li>&nbsp;
				<li class="nav-item"><a href="http://www.fanfandaero.kr"
					class="nav-link active">판판대로</a></li>&nbsp;
				<li class="nav-item"><a href="http://www.valuebuy.kr"
					class="nav-link active">가치삽시다</a></li>&nbsp;
			</ul>
			
		</header>
	</div>

	<!-- main -->
	<div class="main-content">
		<div class="container col-xxl-8 px-4 py-4">
			<div class="row flex-lg-row-reverse align-items-center g-5 py-5">
				<div class="col-10 col-sm-8 col-lg-6">
					<img src=" ./image/intro_gach_right_2.png"
						class="d-block mx-lg-auto img-fluid" alt="Bootstrap Themes"
						width="700" height="400" loading="lazy">
				</div>
				<div class="col-lg-6">
					<h1 class="display-5 fw-bold text-body-emphasis lh-1 mb-3">환영합니다.</h1>
					<p class="lead">
						귀하는 지금 23년 소상공인 온라인 판로지원 사업 자가질문에 참여하셨습니다.<br> 소요시간은 약 3분
						미만으로 진행 될 예정이며,<br> <b>개인정보 및 민감정보는 일체 수집하지 않음</b>을 <br>밝힙니다.
					</p>
					<div class="d-grid gap-2 d-md-flex justify-content-md-start">
						<button type="button" class="btn btn-primary btn-lg px-4 me-md-2"
							onclick="location.href='PageShift?ques_real_depth=1&ques_num=1'">설문
							시작하기</button>
						<button type="button"
							class="btn btn-outline-secondary btn-lg px-4"
							onclick="window.close()">나가기</button>
					</div>
					
				</div>
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
								style="color: rgb(135, 138, 143); margin: 0; padding: 0; border: 0; font-size: 100%;">
								(07997) 서울특별시 양천구 목동동로 309 중소기업유통센터</p>
							<p
								style="color: rgb(135, 138, 143); margin: 0; padding: 0; border: 0; font-size: 100%;">
								대표자 : 이태식 / 대표전화 : 02-6678-9000 / 사업자등록번호 : 107-81-53660</p>
							<p
								style="color: rgb(135, 138, 143); margin: 0; padding: 0; border: 0; font-size: 100%;">
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
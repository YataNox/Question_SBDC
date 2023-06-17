<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri='http://java.sun.com/jsp/jstl/core' prefix='c'%>
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
					<use xlink:href="#bootstrap"></use></svg> <span class="fs-4">
					<img class="img-fluid" src=" ./image/SBDC_Logo_header2.png"
					style="width: 195px; height:40px;"></img>
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
	<div class="container my-5">
	<button type="button"
						class="btn btn-primary btn-lg px-4 me-md-2 fw-bold"
						onclick="location.href='https://valuebuy.kr/support'"
						style="positon: right;">전체사업 알아보기</button><br>
		<br><div class="row p-4 pb-0 pe-lg-0 pt-lg-5 align-items-center rounded-3 border shadow-lg">
		
			<div class="col-lg-6 p-1 p-lg-5 pt-lg-3">
				<h4 class="display-6 fw-bold lh-1 text-body-emphasis">응답결과</h4>
				<p class="lead">
					<h2>[ <b> ${rvo.res_biz_text} </b> ]</h2> <br><br>
					<h5>귀하의 응답 결과 <br><b>${rvo.res_biz_text}</b> 사업을 추천합니다! <br><br>아래 버튼을 클릭하여 해당 사업을 알아보세요!</h5>
				</p><br>
				<div
					class="d-grid gap-2 d-md-flex justify-content-md-start mb-4 mb-lg-3">
					<button type="button"
						class="btn btn-primary btn-lg px-4 me-md-2 fw-bold"
						onclick="location.href='${rvo.res_link}'">해당사업 알아보기</button>
					
					<a href="/"><button type="button"
						class="btn btn-primary btn-lg px-4 me-md-2 fw-bold">처음으로 돌아가기</button></a>
				</div>
			</div>
			<div class="col-lg-6  p-2 p-lg-5 pt-lg-3 ">
				<iframe width="550" height="380" src="https://www.youtube.com/embed/Hpuwv9YCS08?autoplay=1&loop=1&mute=1&controls=0" 
				title="🎥✨소상공인 디지털 전환의 시작, 가치삽시다 포털 홍보영상" frameborder="0" 
				allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" 
				allowfullscreen></iframe>	
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
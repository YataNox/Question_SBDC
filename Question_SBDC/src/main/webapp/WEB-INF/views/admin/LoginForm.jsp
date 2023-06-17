<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<script src="/docs/5.3/assets/js/color-modes.js"></script>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="">
<meta name="author"
	content="Mark Otto, Jacob Thornton, and Bootstrap contributors">
<meta name="generator" content="Hugo 0.111.3">
<title>소상공인 자가진단 시스템 관리자 로그인</title>
<link rel="canonical"
	href="https://getbootstrap.com/docs/5.3/examples/sign-in/">
<link href="/docs/5.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link href="/docs/5.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="icon" href="./image/SBDC_favicon.png">



<style>
.bd-placeholder-img {
	font-size: 1.125rem;
	text-anchor: middle;
	-webkit-user-select: none;
	-moz-user-select: none;
	user-select: none;
}

@media ( min-width : 768px) {
	.bd-placeholder-img-lg {
		font-size: 3.5rem;
	}
}

.b-example-divider {
	width: 100%;
	height: 3rem;
	background-color: rgba(0, 0, 0, .1);
	border: solid rgba(0, 0, 0, .15);
	border-width: 1px 0;
	box-shadow: inset 0 .5em 1.5em rgba(0, 0, 0, .1), inset 0 .125em .5em
		rgba(0, 0, 0, .15);
}

.b-example-vr {
	flex-shrink: 0;
	width: 1.5rem;
	height: 100vh;
}

.bi {
	vertical-align: -.125em;
	fill: currentColor;
}

.nav-scroller {
	position: relative;
	z-index: 2;
	height: 2.75rem;
	overflow-y: hidden;
}

.nav-scroller .nav {
	display: flex;
	flex-wrap: nowrap;
	padding-bottom: 1rem;
	margin-top: -1px;
	overflow-x: auto;
	text-align: center;
	white-space: nowrap;
	-webkit-overflow-scrolling: touch;
}

.btn-bd-primary {
	--bd-violet-bg: #712cf9;
	--bd-violet-rgb: 112.520718, 44.062154, 249.437846;
	--bs-btn-font-weight: 600;
	--bs-btn-color: var(--bs-white);
	--bs-btn-bg: var(--bd-violet-bg);
	--bs-btn-border-color: var(--bd-violet-bg);
	--bs-btn-hover-color: var(--bs-white);
	--bs-btn-hover-bg: #6528e0;
	--bs-btn-hover-border-color: #6528e0;
	--bs-btn-focus-shadow-rgb: var(--bd-violet-rgb);
	--bs-btn-active-color: var(--bs-btn-hover-color);
	--bs-btn-active-bg: #5a23c8;
	--bs-btn-active-border-color: #5a23c8;
}

.bd-mode-toggle {
	z-index: 1500;
}
</style>
</head>

<body class="text-center">

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
		</header>
	</div>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.min.js"></script>
	<main class="px-5 py-5 my-12 text-center">
		<form method="post" action="AdminLogin">
			<img class="" src=" ./image/gachi_logo.svg"
				style="width: 150px; height: 100px"></img>
			<h1 class="h4 mb-3 fw-normal"><b>소상공인 자가진단 시스템 관리자 페이지</b></h1>
			<div class="form-floating">
				<input type="text" class="form-control" name="id" id="floatingInput"
					placeholder="abdc1234" value="${dto.id}"> <label
					for="floatingInput">ID</label> <br>
			</div>
			<div class="form-floating">
				<input type="password" class="form-control" name="pwd"
					id="floatingPassword" placeholder="Password"> <label
					for="floatingPassword">Password</label> <br>
			</div>
			<button class="w-100 btn btn-lg btn-primary" type="submit">로그인</button>
			<br> <br>
			<h4 style="color: red">${message}</h4>
		</form>
	</main>
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
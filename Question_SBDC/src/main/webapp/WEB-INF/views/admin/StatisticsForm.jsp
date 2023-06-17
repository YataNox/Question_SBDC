<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri='http://java.sun.com/jsp/jstl/core' prefix='c'%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>소상공인 자가진단 시스템 관리자</title>
<script type="text/javascript" src="script/AdminScript.js"></script>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link href="./CSS/frontstyle.css" rel="stylesheet">
<link rel="icon" href="./image/SBDC_favicon.png">

<!-- 통계추출, 구글 차트 API -->
<script type="text/javascript"
	src="https://www.gstatic.com/charts/loader.js"></script>
<script type="text/javascript">
      google.charts.load('current', {'packages':['corechart']});
      google.charts.setOnLoadCallback(drawChart);
      
      function drawChart() {
    	  var data = google.visualization.arrayToDataTable([
              ['23년 지원사업명','선호도'],
              <c:forEach var="rvoList" items="${rvoList}">
    			[${rvoList.res_biz_text}, ${rvoList.res_count}],
    		  </c:forEach>
            ]);

        var options = {
            title: ' ',
            chartArea:{top:'5%',width:'50%',height:'800px'}
        };

        var chart = new google.visualization.BarChart(document.getElementById('columnchart_material'));

        chart.draw(data, options);
      }
    </script>
</head>
<body>
	<src ="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.7/dist/umd/popper.min.js">
	</script> <script
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
				<button type="button" class="btn btn-outline-secondary"
					onclick="history.back()">뒤로가기</button>
				<br> <br>
				<h5>
					<b>사업 리스트 및 사업별 선호도</b>
				</h5>
				<table class="table table-striped table-sm">
					<thead>
						<tr>
							<th scope="col">사업 번호</th>
							<th scope="col">사업명</th>
							<th scope="col">선호도</th>
						</tr>
					</thead>
					<c:forEach var="rvoList" items="${rvoList}">
						<tr>
							<td>${rvoList.biz_num}</td>
							<td>${rvoList.res_biz_text}</td>
							<td>${rvoList.res_count}</td>
						</tr>
					</c:forEach>
				</table>
				<br>
				<hr>
				<h5>
					<b>지원사업 및 응답현황</b>
				</h5>
				<table class="table table-striped table-sm"
					style="text-align: center">
					<thead>
						<tr>
							<th scope='col'>총 사업 수</th>
							<th scope='col'>총 응답 현황</th>
						</tr>
					</thead>
					<tr>
						<td>${svo.total_count}</td>
						<td>${svo.count_sum}</td>
					</tr>
				</table>
				<br>
				<hr>
				<br>
				<h5 style="text-align: left">
					<b>응답현황</b>
				</h5>
				<div id="columnchart_material" style="width: 100%; height: 1000px;"></div>
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
<!-- 원본 백업용(구조) 파일, 이 파일에 작업하지 말것 -->

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri='http://java.sun.com/jsp/jstl/core' prefix='c'%> 
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet">
	<link href="./CSS/frontstyle.css" rel="stylesheet">
	<title>23년도 소상공인지원사업</title>

</head>
<body>
	<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.7/dist/umd/popper.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.min.js"></script>
	
	<!-- header -->
	<div class="container">
    <header class="d-flex flex-wrap justify-content-center py-3 mb-4 border-bottom">
      <a href="/" class="d-flex align-items-center mb-3 mb-md-0 me-md-auto link-body-emphasis text-decoration-none">
        <svg class="bi me-2" width="40" height="32"><use xlink:href="#bootstrap"></use></svg>
        <span class="fs-4">
        	<img class="img-fluid" src =" ./image/SBDC_logo_header.JPG" style="width:340px; height:70px" href="#"></img>
        </span>
      </a>

    </header>
  	</div>
	
	<table>
		<tr>
			<td>문항 실번호</td>
			<td>문항 실단계</td>
			<td>문항 세부단계 번호</td>
			<td>문항 텍스트</td>
			<td>등록일자</td>
			<td>수정 횟수</td>
		</tr>
		<tr>
			<td>${qvo.ques_real_q_num}</td>
			<td>${qvo.ques_real_depth}</td>
			<td>${qvo.ques_num}</td>
			<td>${qvo.ques_text}</td>
			<td>${qvo.ques_date}</td>
			<td>${qvo.ques_revise}</td>
		</tr>
		<tr>
		<c:forEach var="avoList" items="${avoList}">
			<td>
			<c:choose>
				<c:when test="${avoList.answ_final_yn eq 'Y'}">
					<Button onclick="location.href='ResultForm?biz_num=${avoList.biz_num}'">${avoList.answ_text}</Button>
				</c:when>
				<c:otherwise>
					<Button onclick="location.href='PageShift?ques_real_depth=${avoList.answ_next_level}&ques_num=${avoList.answ_next_num}'">${avoList.answ_text}.</Button>
				</c:otherwise>
			</c:choose>
			</td>
		</c:forEach>
		</tr>
	</table>
	
	<!-- main -->
	<main>
		<div>
		
		</div>
	</main>
	
		<!-- footer -->
	<div class="container">
  		<footer class="py-3 my-4 mt-auto">
    		<ul class="nav justify-content-center border-bottom pb-3 mb-3"></ul>
   		 <p class="text-center text-body-secondary">
   		  주 소(07997) 서울특별시 양천구 목동동로 309 중소기업유통센터<br>
   		  대표자 이태식<br>
   		  사업자등록번호107-81-53660<br>
   		 </p>
  		</footer>
	</div>
</body>
</html>
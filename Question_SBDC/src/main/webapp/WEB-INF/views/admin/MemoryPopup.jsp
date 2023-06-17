<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri='http://java.sun.com/jsp/jstl/core' prefix='c'%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>이력관리</title>
	<script type="text/javascript" src="script/AdminScript.js"></script>
	<link rel="icon" href="./image/SBDC_favicon.png">
	<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link href="./CSS/frontstyle.css" rel="stylesheet">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
</head>
<body>
	<script
		src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.7/dist/umd/popper.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.min.js"></script>


	<div class="main-content">
		<div class="container my-5">
		<c:choose>
		<c:when test="${empty mvoList}">
			<div class="modal modal-sheet position-static d-block bg-body-secondary p-4 py-md-5" tabindex="-1" role="dialog" id="modalSheet">
  <div class="modal-dialog" role="document">
    <div class="modal-content rounded-4 shadow">
      <div class="modal-header border-bottom-0">
       
      </div>
      <div class="modal-body py-0">
		<h4><b>데이터 변경사항이 없습니다</b></h4>
      </div>
      <div class="modal-footer flex-column align-items-stretch w-100 gap-2 pb-3 border-top-0">
        <button type="button"
							class="btn btn-outline-secondary btn-lg px-4"
							onclick="window.close()">나가기</button>
      </div>
    </div>
  </div>
</div>
		</c:when>
		<c:otherwise>
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
			</a>
		</header>
		<br> <br>
	</div>
	
			<h3><b>이력관리</b></h3> <br>
			<table class="table table-striped table-sm">
				<thead>
				<tr>
					<th>작성일시</th>
					<th >부서(팀)</th>
					<th >ID</th>
					<th >구분</th>
					<th >종류</th>
					<th>내용</th>
					
				</tr>
				</thead>
				<c:forEach items="${mvoList}" var="mvoList">
				<tr>
					<td>${mvoList.memo_date}</td>
					<td>${mvoList.memo_dept_name}</td>
					<td>${mvoList.memo_admin_name}</td>
					<td>${mvoList.memo_data_kind}</td>
					<td>${mvoList.memo_kind}</td>					
					<td>${mvoList.memo_update_text}</td>
				<tr>			
				</c:forEach>
			</table>
		</c:otherwise>
	</c:choose>
		</div>
	</div>




	
</body>
</html>
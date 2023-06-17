function del_Question(){
	var count = 0;  //  체크된 체크박스의 갯수를 카운트 하기위한 변수
	if(document.frm.ques_real_q_num.length==undefined){   // length가 undefined라는 것은 배열로 넘어오지않고 단일변수로 넘어왔다는 의미.
	// 즉 체크박스가 하나일때를 의미한다.
		if( document.frm.ques_real_q_num.checked == true)   // 그 체크박스만 체크되어 있는지 확인
			count++;	 
	}else{ // length가 2이상으로 나와서 배열로 넘어왔다. 즉 체크박스가 두 개 이상이다를 의미한다.
		for( var i=0; i<document.frm.ques_real_q_num.length; i++){ // 넘어온 delete 개수 만큼 반복문 돌려보는 거야.
			if( document.frm.ques_real_q_num[i].checked==true)
				count++;
		}
	}
	// 지금의 스크립트 명령은 체크박스가 하나도 체크되지 않았다면 원래로 되돌아 가기위한 코드들입니다
	if( count == 0 ){ // 카운트가 0이라는건 삭제버튼은 눌렀는데 체크박스에 체크한게 없는거지. 즉 삭제하려는 데이터가 없다.
		alert("삭제할 항목을 선택해주세요"); // 그래서 삭제할 항목을 선택하라는 알람창만 띄우고 종료.
	} else{ // 카운트가 0이아니라는거는 삭제하려는게 하나라도 있다는 의미.
		if(confirm("정말로 삭제하시겠습니까?")){ // 정말 삭제할거냐는 팝업창을 띄워서 예를 눌렀을때.
			document.frm.action = "QuestionDelete"; // Controller의 삭제 함수를 실행하겠다는 의미다.
	    	document.frm.submit();
	    }
	}
}

function del_Answer(){
	var count = 0;  //  체크된 체크박스의 갯수를 카운트 하기위한 변수
	if(document.frm.delete.length==undefined){   // 체크박스가 하나일때
		if( document.frm.delete.checked == true)   // 그 체크박스만 체크되어 있는지 확인
			count++;	 
	}else{
		for( var i=0; i<document.frm.delete.length; i++){
			if( document.frm.delete[i].checked==true)
				count++;
		}
	}
	// 지금의 스크립트 명령은 체크박스가 하나도 체크되지 않았다면 원래로 되돌아 가기위한 코드들입니다
	if( count == 0 ){
		alert("삭제할 항목을 선택해주세요");
	} else{
		if(confirm("정말로 삭제하시겠습니까?")){
			document.frm.action = "AnswerDelete";
	    	document.frm.submit();
	    }
	}
}

function del_Result(){
	var count = 0;  //  체크된 체크박스의 갯수를 카운트 하기위한 변수
	if(document.frm.delete.length==undefined){   // 체크박스가 하나일때
		if( document.frm.delete.checked == true)   // 그 체크박스만 체크되어 있는지 확인
			count++;	 
	}else{
		for( var i=0; i<document.frm.delete.length; i++){
			if( document.frm.delete[i].checked==true)
				count++;
		}
	}
	// 지금의 스크립트 명령은 체크박스가 하나도 체크되지 않았다면 원래로 되돌아 가기위한 코드들입니다
	if( count == 0 ){
		alert("삭제할 항목을 선택해주세요");
	} else{
		if(confirm("정말로 삭제하시겠습니까?")){
			document.frm.action = "ResultDelete";
	    	document.frm.submit();
	    }
	}
}

function Sort_QuestionList(){
	document.frm.action = "AdminMain?ListType=Question";
	document.frm.submit();
}

function Sort_ResultList(){
	document.frm.action = "AdminMain?ListType=Result";
	document.frm.submit();
}

function Question_UpdateChk(){	
	if(document.frm.ques_real_depth.value==""){
		alert("문항 실 단계를 입력하세요.");
		document.frm.ques_real_depth.focus();
	}else if(document.frm.ques_num.value==""){
		alert("문항 세부단계 번호를 입력하세요.");
		document.frm.ques_num.focus();
	}else if(document.frm.ques_text.value==""){
		alert("문항 텍스트를 입력하세요.");
		document.frm.ques_text.focus();
	}else{
		if(confirm('수정하시겠습니까?')){
			document.frm.action = "QuestionUpdate";
			document.frm.submit();
		}
	}
}

function Question_WriteChk(){	
	if(document.frm.ques_real_depth.value==""){
		alert("문항 실 단계를 입력하세요.");
		document.frm.ques_real_depth.focus();
	}else if(document.frm.ques_num.value==""){
		alert("문항 세부단계 번호를 입력하세요.");
		document.frm.ques_num.focus();
	}else if(document.frm.ques_text.value==""){
		alert("문항 텍스트를 입력하세요.");
		document.frm.ques_text.focus();
	}else{
		if(confirm('수정하시겠습니까?')){
			document.frm.action = "QuestionWrite";
			document.frm.submit();
		}
	}
}

function Answer_UpdateChk(){
	var answ_real_num = document.getElementsByName("answ_real_num");
	var answ_next_level = document.getElementsByName("answ_next_level");
	var answ_next_num = document.getElementsByName("answ_next_num");
	var answ_text = document.getElementsByName("answ_text");
	var answ_final_yn = document.getElementsByName("answ_final_yn");
	var biz_num = document.getElementsByName("biz_num");
	var updatable = true;
	
	for(var i = 0; i < answ_real_num.length; i++){
		if(answ_next_level[i].value==""){
			alert((i+1) + "번 답변의 다음 문항 연계 단계를 입력하세요.");
			updatable = false;
		}else if(answ_next_num[i].value==""){
			alert((i+1) + "번 답변의 다음 문항 연계 세부번호를 입력하세요.");
			updatable = false;
		}else if(answ_text[i].value==""){
			alert((i+1) + "번 답변의 답변 텍스트를 입력하세요.");
			updatable = false;
		}else if(answ_final_yn[i].value==""){
			alert((i+1) + "번 답변의 마지막 답변 여부를 선택하세요.");
			updatable = false;
		}else if(biz_num[i].value=="" && answ_final_yn[i].value=="Y"){
			alert((i+1) + "번 답변의 최종 사업번호를 선택하세요.");
			updatable = false;
		}else if(biz_num[i].value!="" && answ_final_yn[i].value=="N"){
			alert((i+1) + "번 답변의 최종사업번호가 선택되었습니다.\n마지막 답변 여부를 'Y'로 선택해주세요.");
			updatable = false;
		}
	}
	
	if(updatable && confirm('수정하시겠습니까?')){
		document.frm.action = "AnswerUpdate";
		document.frm.submit();
	}
}

function Answer_WriteChk(){
	if(document.frm.answ_next_level.value==""){
		alert("다음 문항 연계 단계를 입력하세요.");
	}else if(document.frm.answ_next_num.value==""){
		alert("다음 문항 연계 세부번호를 입력하세요.");
	}else if(document.frm.answ_text.value==""){
		alert("답변 텍스트를 입력하세요.");
	}else if(document.frm.answ_final_yn.value==""){
		alert("마지막 답변 여부를 선택하세요.");
	}else if(document.frm.biz_num.value=="" && document.frm.answ_final_yn.value=="Y"){
		alert("최종 사업번호를 선택하세요.");
	}else if(document.frm.biz_num.value!="" && document.frm.answ_final_yn.value=="N"){
		alert("최종사업번호가 선택되었습니다.\n마지막 답변 여부를 'Y'로 선택해주세요.");
	}else{
		if(confirm('수정하시겠습니까?')){
			document.frm.action = "AnswerWrite";
			document.frm.submit();
		}
	}
}

function Result_UpdateChk(){	
	if(document.frm.res_biz_text.value==""){
		alert("최종 사업 텍스트를 입력하세요.");
		document.frm.res_biz_text.focus();
	}else if(document.frm.res_link.value==""){
		alert("연결 주소 URL을 입력하세요.");
		document.frm.res_link.focus();
	}else{
		if(confirm('수정하시겠습니까?')){
			document.frm.action = "ResultUpdate";
			document.frm.submit();
		}
	}
}

function Result_WriteChk(){	
	if(document.frm.res_biz_text.value==""){
		alert("최종 사업 텍스트를 입력하세요.");
		document.frm.res_biz_text.focus();
	}else if(document.frm.res_link.value==""){
		alert("연결 주소 URL을 입력하세요.");
		document.frm.res_link.focus();
	}else{
		if(confirm('수정하시겠습니까?')){
			document.frm.action = "ResultWrite";
			document.frm.submit();
		}
	}
}

// 기록 불러오기
function Popup_Memory(memo_data_num, memo_data_kind){
	var url = "MemoryPopup?memo_data_num="+memo_data_num+"&memo_data_kind="+memo_data_kind;
	var opt = "toolbar=0,location=0,menubar=0,scrollbars=0,resizable=0,height=" + screen.height + ",width=" + screen.width + "fullscreen=yes";
	window.open(url,"기록열람창",opt);
}
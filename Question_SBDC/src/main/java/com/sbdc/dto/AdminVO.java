package com.sbdc.dto;

import lombok.Data;

// VO는 DB의 데이터를 자바에 맞게 변환하기 위한 데이터 객체이다.
// db에 저장된 속성에 맞게 변수들을 가지고 있어서
// 가져온 데이터를 VO에 매칭해서 저장해서 사용한다.
// 예시로 TB_ADMIN 테이블은 관리자 번호, 아이디, 비밀번호 3개를 Attribute(속성)으로 가지고 있는데
// 아래 클래스를 보면 각각 번호, 아이디, 비밀번호에 해당하는 변수를 가지고 있는걸 볼 수 있다.
// 관리자 Data를 DAO가 가져오면 각각의 변수에 맞춰서 넣어서 저장하는 것.
@Data
public class AdminVO {
	// 관리자 번호
	private int adm_num;
	// 관리자 ID
	private String adm_id;
	// 관리자 비밀번호
	private String adm_password;
	// 관리자 팀 이름
	private String adm_dept_name;
}

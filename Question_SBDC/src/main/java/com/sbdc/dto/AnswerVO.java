package com.sbdc.dto;

import java.sql.Timestamp;

import lombok.Data;

@Data
public class AnswerVO {
	// 답변 번호
	private int answ_real_num;
	// 해당 문항 세부 답변 번호
	private int answ_q_inside_num;
	// 다음 문항 연계 단계
	private int answ_next_level;
	// 다음 문항 연계 세부 번호
	private int answ_next_num;
	// 답변 테스트
	private String answ_text;
	// 마지막 답변 여부
	private String answ_final_yn;
	// 최종 사업 번호
	private int biz_num;
	// 등록일자
	private Timestamp answ_date;
	// 수정 횟수
	private int answ_revise;
	// 보여주기 여부
	private String answ_is_showing;
	// 최초 작성자
	private String answ_first_writer;
}

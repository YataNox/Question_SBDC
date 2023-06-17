package com.sbdc.dto;

import java.sql.Timestamp;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class QuestionVO {
	// 문항 실 번호
	private int	ques_real_q_num;
	// 문항 실 단계
	private int ques_real_depth;
	// 문항 세부단계 번호
	private int ques_num;
	// 문항 텍스트
	private String ques_text;
	// 등록일자
	private Timestamp ques_date;
	// 수정 횟수
	private int ques_revise;
	// 보여주기 여부
	private String ques_is_showing;
	// 최초 작성자
	private String ques_first_writer;
}

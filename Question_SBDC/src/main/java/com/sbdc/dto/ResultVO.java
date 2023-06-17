package com.sbdc.dto;

import java.sql.Timestamp;

import lombok.Data;

@Data
public class ResultVO {
	// 최종 사업 번호
	private int biz_num;
	// 최종 사업 텍스트
	private String res_biz_text;
	// 연결 주소 URL
	private String res_link;
	// 결과 도출 카운트
	private int res_count;
	// 등록일자
	private Timestamp res_date;
	// 수정횟수
	private int res_revise;
	// 보여주기 여부
	private String res_is_showing;
	// 최초 작성자
	private String res_first_writer;
}

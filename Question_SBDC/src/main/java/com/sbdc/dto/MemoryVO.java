package com.sbdc.dto;

import java.sql.Timestamp;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class MemoryVO {
	private int memo_num;
	private String memo_dept_name;
	private String memo_admin_name;
	private String memo_data_kind;
	private int memo_data_num;
	private String memo_kind;
	private String memo_update_text;
	private Timestamp memo_date;
}

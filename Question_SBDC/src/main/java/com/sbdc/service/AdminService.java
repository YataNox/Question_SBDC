package com.sbdc.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sbdc.dao.IAdminDAO;
import com.sbdc.dto.AdminVO;

// 웹요청과 응답을 처리하는 Controller와 달리
// Service는 내부에서 자바 로직을 처리하는 객체
// 현재로써는 DAO의 함수를 실행하는 역할만 담당중
// Interface로 생성되어 있는 DAO의 함수를 실행해서 DB에 접근해 값을 가져와 Controller에 리턴해준다.
@Service // 서비스 객체임을 나타내기 위한 어노테이션 자세한 건 검색.
public class AdminService {

	@Autowired
	IAdminDAO iadao;
	
	// 전달받은 ID에 해당하는 관리자 정보를 찾는 함수
	public AdminVO AdminCheck(String id) {
		return iadao.AdminCheck(id);
	}
}

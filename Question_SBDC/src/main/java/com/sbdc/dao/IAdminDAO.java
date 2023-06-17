package com.sbdc.dao;

import org.apache.ibatis.annotations.Mapper;

import com.sbdc.dto.AdminVO;

// DAO는 DB에 접근하는 객체로서 db 데이터를 조회, 조작하는 역할을 담당한다.
// 이 프로젝트는 실제 접근을 mybatis를 이용해서 함으로 DAO.xml 파일로 실행한다. 
// 해당 IDAO 파일은 인터페이스로 해당 DAO가 어떤 함수를 가지고 있어야할지만 기술한 파일로
// 실제 xml 파일에 매칭하여 이용한다.
// 그래서 Service가 해당 IDAO의 함수를 실행하면
// 매칭된 DAO.xml 파일의 태그가 실행되어 SQL Query문을 DB에 실행해 접근한다.
@Mapper
public interface IAdminDAO {
	public AdminVO AdminCheck(String id);
}

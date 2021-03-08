package com.team04.spring.freeboard.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;


import com.team04.spring.freeboard.dto.FreeBoardDto;

@Repository
public class FreeBoardDaoImpl implements FreeBoardDao{
	//핵심 의존객체 DI
	@Autowired
	private SqlSession session;	
	//글 업로드	
	@Override
	public void insert(FreeBoardDto dto) {
		session.insert("freeboard.insert",dto);
	}	
	//글 목록
	@Override
	public List<FreeBoardDto> getlist(FreeBoardDto dto) {
		List<FreeBoardDto> list=session.selectList("freeboard.getList",dto);
		return list;
	}
	//글 갯수
	@Override
	public int getCount(FreeBoardDto dto) {
		int count=session.selectOne("freeboard.getCount",dto);
		return count;
	}
	//글 하나의 데이터 가져오기
	@Override
	public FreeBoardDto getData(int num) {
		FreeBoardDto dto=session.selectOne("freeboard.getData",num);
		return dto;
	}
	@Override
	public void update(FreeBoardDto dto) {
		session.update("freeboard.update",dto);
		
	}
	@Override
	public void delete(int num) {
		session.delete("freeboard.delete",num);
		
		
	}
	@Override
	public void addViewCount(int num) {
		session.update("freeboard.addViewCount",num);
				
	}

	
	
}

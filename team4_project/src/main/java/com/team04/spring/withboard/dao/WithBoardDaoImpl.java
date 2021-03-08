package com.team04.spring.withboard.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.team04.spring.withboard.dto.WithBoardDto;

@Repository
public class WithBoardDaoImpl implements WithBoardDao{

	//핵심 의존객체 DI
	@Autowired
	private SqlSession session;	
	//글 업로드	
	@Override
	public void insert(WithBoardDto dto) {
		session.insert("withboard.insert",dto);
	}	
	//글 목록
	@Override
	public List<WithBoardDto> getlist(WithBoardDto dto) {
		List<WithBoardDto> list=session.selectList("withboard.getList",dto);
		return list;
	}
	//글 갯수
	@Override
	public int getCount(WithBoardDto dto) {
		int count=session.selectOne("withboard.getCount",dto);
		return count;
	}
	//글 하나의 데이터 가져오기
	@Override
	public WithBoardDto getData(int num) {
		WithBoardDto dto=session.selectOne("withboard.getData",num);
		return dto;
	}
	@Override
	public void update(WithBoardDto dto) {
		session.update("withboard.update",dto);
		
	}
	@Override
	public void delete(int num) {
		session.delete("withboard.delete",num);
		
		
	}
	@Override
	public void addViewCount(int num) {
		session.update("withboard.addViewCount",num);
				
	}

}

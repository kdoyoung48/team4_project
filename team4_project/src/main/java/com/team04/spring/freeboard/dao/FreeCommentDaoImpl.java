package com.team04.spring.freeboard.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.team04.spring.freeboard.dto.FreeCommentDto;

@Repository
public class FreeCommentDaoImpl implements FreeCommentDao{
	
	@Autowired
	private SqlSession session;
	
	@Override
	public List<FreeCommentDto> getList(FreeCommentDto dto) {
		List<FreeCommentDto> list=
				session.selectList("freeComment.getList",dto);
		return list;
	}

	@Override
	public void insert(FreeCommentDto dto) {
		session.insert("freeComment.insert",dto);
		
	}

	@Override
	public void update(FreeCommentDto dto) {
		session.update("freeComment.update",dto);
		
	}

	@Override
	public void delete(int num) {
		//댓글 삭제는 deleted 칼럼내용 yes 수정하는 작업
		session.update("freeComment.delete",num);
		
	}

	@Override
	public int getSequence() {
		int seq=session.selectOne("freeComment.getSequence");
		return seq;
	}

	@Override
	public FreeCommentDto getData(int num) {
		return session.selectOne("freeComment.getData",num);
	}

	@Override
	public int getCount(int ref_group) {	
		return session.selectOne("freeComment.getCount",ref_group);
	}

}

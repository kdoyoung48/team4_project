package com.team04.spring.withboard.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;


import com.team04.spring.withboard.dto.WithCommentDto;

@Repository
public class WithCommentDaoImpl implements WithCommentDao{

	@Autowired
	private SqlSession session;
	
	@Override
	public List<WithCommentDto> getList(WithCommentDto dto) {
		List<WithCommentDto> list=
				session.selectList("withComment.getList",dto);
		return list;
	}

	@Override
	public void insert(WithCommentDto dto) {
		session.insert("withComment.insert",dto);
		
	}

	@Override
	public void update(WithCommentDto dto) {
		session.update("withComment.update",dto);
		
	}

	@Override
	public void delete(int num) {
		//댓글 삭제는 deleted 칼럼내용 yes 수정하는 작업
		session.update("withComment.delete",num);
		
	}

	@Override
	public int getSequence() {
		int seq=session.selectOne("withComment.getSequence");
		return seq;
	}

	@Override
	public WithCommentDto getData(int num) {
		return session.selectOne("withComment.getData",num);
	}

	@Override
	public int getCount(int ref_group) {	
		return session.selectOne("withComment.getCount",ref_group);
	}

}

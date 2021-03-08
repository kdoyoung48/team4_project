package com.team04.spring.withboard.dao;

import java.util.List;

import com.team04.spring.withboard.dto.WithCommentDto;

public interface WithCommentDao {
	//댓글 목록 얻어오기
	public List<WithCommentDto> getList(WithCommentDto dto);
	//댓글 추가
	public void insert(WithCommentDto dto);
	//댓글 수정
	public void update(WithCommentDto dto);
	//댓글 삭제
	public void delete(int num);
	//댓글의 시퀀스값(글번호)리턴
	public int getSequence();
	//댓글 하나의 정보를 리턴하는 메소드
	public WithCommentDto getData(int num);
	//댓글의 갯수를 리턴하는 메소드
	public int getCount(int ref_group);
}

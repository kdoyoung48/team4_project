package com.team04.spring.freeboard.dao;

import java.util.List;

import com.team04.spring.freeboard.dto.FreeCommentDto;

public interface FreeCommentDao {
	//댓글 목록 얻어오기
	public List<FreeCommentDto> getList(FreeCommentDto dto);
	//댓글 추가
	public void insert(FreeCommentDto dto);
	//댓글 수정
	public void update(FreeCommentDto dto);
	//댓글 삭제
	public void delete(int num);
	//댓글의 시퀀스값(글번호)리턴
	public int getSequence();
	//댓글 하나의 정보를 리턴하는 메소드
	public FreeCommentDto getData(int num);
	//댓글의 갯수를 리턴하는 메소드
	public int getCount(int ref_group);
}

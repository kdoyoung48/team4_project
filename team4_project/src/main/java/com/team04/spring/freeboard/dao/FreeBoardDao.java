package com.team04.spring.freeboard.dao;

import java.util.List;

import com.team04.spring.freeboard.dto.FreeBoardDto;

public interface FreeBoardDao {
	//글 추가
	public void insert(FreeBoardDto dto);
	//글 목록 얻어오고 페이징처리 키워드 검색 고려
	public List<FreeBoardDto> getlist(FreeBoardDto dto);
	//글의 갯수 얻어오기(검색 키워드에 해당하는 갯수)
	public int getCount(FreeBoardDto dto);
	//글 하나의 정보 얻어오기
	public FreeBoardDto getData(int num);
	//글 수정
	public void update(FreeBoardDto dto);
	//글 삭제
	public void delete(int num);
	//글 조회수 올리기
	public void addViewCount(int num);
}

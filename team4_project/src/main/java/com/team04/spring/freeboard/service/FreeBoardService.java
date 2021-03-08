package com.team04.spring.freeboard.service;

import javax.servlet.http.HttpServletRequest;

import org.springframework.web.servlet.ModelAndView;

import com.team04.spring.freeboard.dto.FreeBoardDto;
import com.team04.spring.freeboard.dto.FreeCommentDto;

public interface FreeBoardService {
	//새글을 저장하는 메소드
	public void saveContent(FreeBoardDto dto);
	//글 목록을 얻어오고 페이징처리 ModelAndView 객체에 담아주는 메소드
	public void getList(ModelAndView mView, HttpServletRequest request);
	//글 하나의 정보를 ModelAndView 객체에 담아주는 메소드
	public void getDetail(int num, ModelAndView mView);
	//글 수정
	public void updateContent(FreeBoardDto dto);
	//글 삭제 
	public void deleteContent(int num);
	//댓글을 저장하는 메소드
	public void saveComment(HttpServletRequest request);
	public void deleteComment(HttpServletRequest request);//댓글 삭제
	public void updateComment(FreeCommentDto dto); //댓글 수정
	public void moreCommentList(HttpServletRequest request); //댓글 추가 응답
}

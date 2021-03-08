package com.team04.spring.freeboard;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.team04.spring.freeboard.dto.FreeBoardDto;
import com.team04.spring.freeboard.dto.FreeCommentDto;
import com.team04.spring.freeboard.service.FreeBoardService;



@Controller
public class FreeBoardController {
	//의존객체 DI
	@Autowired
	private FreeBoardService service;
	
	//ajax 댓글 list
	@RequestMapping("/freeboard/ajax_comment_list")
	public ModelAndView ajaxCommentList(HttpServletRequest request,
			ModelAndView mView) {
		service.moreCommentList(request);
		mView.setViewName("freeboard/ajax_comment_list");
		return mView;
	}
	
	//댓글 수정 ajax 요청에 대한 요청 처리 
	@RequestMapping(value = "/freeboard/private/comment_update", 
			method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> commentUpdate(FreeCommentDto dto){
		//댓글을 수정 반영하고 
		service.updateComment(dto);
		//JSON 문자열을 클라이언트에게 응답한다.
		Map<String, Object> map=new HashMap<>();
		map.put("num", dto.getNum());
		map.put("content", dto.getContent());
		return map;
		
	}
	

	
	//댓글 삭제 요청처리
	@RequestMapping("/freeboard/private/comment_delete")
	public ModelAndView commentDelete(HttpServletRequest request,
			ModelAndView mView,@RequestParam int ref_group) {
		service.deleteComment(request);
		mView.setViewName("redirect:/freeboard/detail.do?num="+ref_group);
		return mView;
	}
	//새 댓글 저장 요청 처리
	@RequestMapping(value = "/freeboard/private/comment_insert",
			method = RequestMethod.POST)
	public String commentInsert(HttpServletRequest request,
			@RequestParam int ref_group) {
		service.saveComment(request);
		return "redirect:/freeboard/detail.do?num="+ref_group;
	}
	//글 delete 요청 
	@RequestMapping("/freeboard/private/delete")
	public String delete(@RequestParam int num) {
		service.deleteContent(num);
		return "freeboard/private/delete";
	}
	//글 update 페이지 요청 처리
	@RequestMapping("/freeboard/private/update")
	public String update(@ModelAttribute("dto") FreeBoardDto dto) {
		service.updateContent(dto);
		return "freeboard/private/update";
	}
	
	//updateform 페이지 요청처리
	@RequestMapping("/freeboard/private/updateform")
	public ModelAndView updateform(@RequestParam int num, ModelAndView mView) {
		service.getDetail(num, mView);
		mView.setViewName("freeboard/private/updateform");
		return mView;
	}
	
	
	//detail 페이지 요청 처리
	@RequestMapping("/freeboard/detail")
	public ModelAndView detail(@RequestParam int num,ModelAndView mView) {
		service.getDetail(num, mView);
		mView.setViewName("freeboard/detail");
		return mView;
	}
	
	//freeboard 글 목록 요청처리
	@RequestMapping("/freeboard/list")
	public ModelAndView list(ModelAndView mView, HttpServletRequest request) {
		service.getList(mView, request);
		mView.setViewName("freeboard/list");
		return mView;
	}
	
	//freeboard 새글 추가 폼 요청처리
	@RequestMapping("/freeboard/private/insertform")
	public String insertform() {
		return "freeboard/private/insertform";
	}
	
	//freeboard 새글 저장 요청처리
	@RequestMapping(value = "/freeboard/private/insert",method=RequestMethod.POST )
	public String insert(FreeBoardDto dto,HttpSession session) {
		String id=(String)session.getAttribute("id");
		dto.setWriter(id);
		service.saveContent(dto);
		return "freeboard/private/insert";		
	}
	
	
	
	
	
	
}

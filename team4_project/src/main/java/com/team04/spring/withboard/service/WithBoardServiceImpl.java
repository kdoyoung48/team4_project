package com.team04.spring.withboard.service;

import java.net.URLEncoder;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

import com.team04.spring.withboard.dao.WithBoardDao;
import com.team04.spring.withboard.dao.WithCommentDao;
import com.team04.spring.withboard.dto.WithBoardDto;
import com.team04.spring.withboard.dto.WithCommentDto;

@Service
public class WithBoardServiceImpl implements WithBoardService{
	//의존 객체 DI
	@Autowired
	private WithBoardDao WithBoardDao;	
	
	@Autowired
	private WithCommentDao WithCommentDao;
	
	
	//글 저장
	@Override
	public void saveContent(WithBoardDto dto) {
		WithBoardDao.insert(dto);
		
	}
	//글 목록 (페이징처리)
	@Override
	public void getList(ModelAndView mView, HttpServletRequest request) {
		//한 페이지에 몇개씩 표시할 것인지
		final int PAGE_ROW_COUNT=5;
		//하단 페이지를 몇개씩 표시할 것인지
		final int PAGE_DISPLAY_COUNT=5;
		
		//보여줄 페이지의 번호를 일단 1이라고 초기값 지정
		int pageNum=1;
		//페이지 번호가 파라미터로 전달되는지 읽어와 본다.
		String strPageNum=request.getParameter("pageNum");
		//만일 페이지 번호가 파라미터로 넘어 온다면
		if(strPageNum != null){
			//숫자로 바꿔서 보여줄 페이지 번호로 지정한다.
			pageNum=Integer.parseInt(strPageNum);
		}
		
		//보여줄 페이지의 시작 ROWNUM
		int startRowNum=1+(pageNum-1)*PAGE_ROW_COUNT;
		//보여줄 페이지의 끝 ROWNUM
		int endRowNum=pageNum*PAGE_ROW_COUNT;
		
		/*
			[ 검색 키워드에 관련된 처리 ]
			-검색 키워드가 파라미터로 넘어올수도 있고 안넘어 올수도 있다.		
		*/
		String keyword=request.getParameter("keyword");
		String condition=request.getParameter("condition");
		//만일 키워드가 넘어오지 않는다면 
		if(keyword==null){
			//키워드와 검색 조건에 빈 문자열을 넣어준다. 
			//클라이언트 웹브라우저에 출력할때 "null" 을 출력되지 않게 하기 위해서  
			keyword="";
			condition=""; 
		}
		
		//특수기호를 인코딩한 키워드를 미리 준비한다. 
		String encodedK=URLEncoder.encode(keyword);
		
		//startRowNum 과 endRowNum  을 WithBoardDto 객체에 담고
		WithBoardDto dto=new WithBoardDto();
		dto.setStartRowNum(startRowNum);
		dto.setEndRowNum(endRowNum);
		
		//ArrayList 객체의 참조값을 담을 지역변수를 미리 만든다.
		List<WithBoardDto> list=null;
		//전체 row 의 갯수를 담을 지역변수를 미리 만든다.
		int totalRow=0;
		//만일 검색 키워드가 넘어온다면 
		if(!keyword.equals("")){
			//검색 조건이 무엇이냐에 따라 분기 하기
			if(condition.equals("title_content_category")){//제목 +내용+카테고리 검색인 경우
				//검색 키워드를 WithBoardDto 에 담아서 전달한다.
				dto.setTitle(keyword);
				dto.setContent(keyword);	
				dto.setCategory(keyword);
			}else if(condition.equals("title")){ //제목 검색인 경우
				dto.setTitle(keyword);			
			}else if(condition.equals("writer")){ //작성자 검색인 경우
				dto.setWriter(keyword);	
			}else if(condition.equals("category")) {//카테고리 검색인 경우
				dto.setCategory(keyword);
				// 다른 검색 조건을 추가 하고 싶다면 아래에 else if() 를 계속 추가 하면 된다.
			}
		}
		//글목록 얻어오기
		list=WithBoardDao.getlist(dto);
		//글의 갯수
		totalRow=WithBoardDao.getCount(dto);
		
		//하단 시작 페이지 번호 
		int startPageNum = 1 + ((pageNum-1)/PAGE_DISPLAY_COUNT)*PAGE_DISPLAY_COUNT;
		//하단 끝 페이지 번호
		int endPageNum=startPageNum+PAGE_DISPLAY_COUNT-1;
		
		//전체 페이지의 갯수 구하기
		int totalPageCount=(int)Math.ceil(totalRow/(double)PAGE_ROW_COUNT);
		//끝 페이지 번호가 이미 전체 페이지 갯수보다 크게 계산되었다면 잘못된 값이다.
		if(endPageNum > totalPageCount){
			endPageNum=totalPageCount; //보정. 
		}
		
		//view page 에서 필요한 내용을 ModelAndView 객체에 담아준다
		mView.addObject("list", list);
		mView.addObject("pageNum", pageNum);
		mView.addObject("startPageNum", startPageNum);
		mView.addObject("endPageNum", endPageNum);
		mView.addObject("totalPageCount", totalPageCount);
		mView.addObject("condition", condition);
		mView.addObject("keyword", keyword);
		mView.addObject("encodedK", encodedK);
		mView.addObject("totalRow", totalRow);
		
	}
	//디테일 페이지
	@Override
	public void getDetail(int num, ModelAndView mView) {
		WithBoardDto dto=WithBoardDao.getData(num);
		mView.addObject("dto",dto);
		//조회수
		WithBoardDao.addViewCount(num);
		
		/* 아래는 댓글 페이징 처리 관련 비즈니스 로직 입니다.*/
		final int PAGE_ROW_COUNT=5;

		//보여줄 페이지의 번호
		int pageNum=1;

		//보여줄 페이지 데이터의 시작 ResultSet row 번호
		int startRowNum=1+(pageNum-1)*PAGE_ROW_COUNT;
		//보여줄 페이지 데이터의 끝 ResultSet row 번호
		int endRowNum=pageNum*PAGE_ROW_COUNT;

		//전체 row 의 갯수를 읽어온다.
		//자세히 보여줄 글의 번호가 ref_group  번호 이다. 
		int totalRow=WithCommentDao.getCount(num);
		//전체 페이지의 갯수 구하기
		int totalPageCount=
			(int)Math.ceil(totalRow/(double)PAGE_ROW_COUNT);

		// WithCommentDto 객체에 위에서 계산된 startRowNum 과 endRowNum 을 담는다.
		WithCommentDto commentDto=new WithCommentDto();
		commentDto.setStartRowNum(startRowNum);
		commentDto.setEndRowNum(endRowNum);
		//ref_group 번호도 담는다.
		commentDto.setRef_group(num);

		//DB 에서 댓글 목록을 얻어온다.
		List<WithCommentDto> commentList=WithCommentDao.getList(commentDto);
		//ModelAndView 객체에 댓글 목록도 담아준다.
		mView.addObject("commentList", commentList);
		mView.addObject("totalPageCount", totalPageCount);
	}
	@Override
	public void updateContent(WithBoardDto dto) {
		WithBoardDao.update(dto);
		
	}
	@Override
	public void deleteContent(int num) {
		WithBoardDao.delete(num);
		
	}
	@Override
	public void saveComment(HttpServletRequest request) {
		//댓글 작성자
		String writer=(String)request.getSession().getAttribute("id");
		int ref_group=Integer.parseInt(request.getParameter("ref_group"));
		String target_id=request.getParameter("target_id");
		String content=request.getParameter("content");
		
		String comment_group=request.getParameter("comment_group");
		int seq=WithCommentDao.getSequence();
		WithCommentDto dto=new WithCommentDto();
		dto.setNum(seq);
		dto.setWriter(writer);
		dto.setTarget_id(target_id);
		dto.setContent(content);
		dto.setRef_group(ref_group);
		if(comment_group==null) {
			dto.setComment_group(seq);
		}else {
			dto.setComment_group(Integer.parseInt(comment_group));				
		}
		WithCommentDao.insert(dto);
	}
	@Override
	public void deleteComment(HttpServletRequest request) {
		int num=Integer.parseInt(request.getParameter("num"));
		String id=(String)request.getSession().getAttribute("id");
		String writer=WithCommentDao.getData(num).getWriter();
//				if(!writer.equals(id)) {
//					throw new DBFailException("남의 댓글을 삭제 할수 없습니다.");
//				}
		WithCommentDao.delete(num);
	}
	@Override
	public void updateComment(WithCommentDto dto) {
		WithCommentDao.update(dto);
		
	}
	@Override
	public void moreCommentList(HttpServletRequest request) {
		//파라미터로 전달된 pageNum 과 ref_group 번호를 읽어온다. 
		int pageNum=Integer.parseInt(request.getParameter("pageNum"));
		int ref_group=Integer.parseInt(request.getParameter("ref_group"));

		WithBoardDto dto=WithBoardDao.getData(ref_group);
		request.setAttribute("dto", dto);

		/* 아래는 댓글 페이징 처리 관련 비즈니스 로직 입니다.*/
		final int PAGE_ROW_COUNT=5;

		//보여줄 페이지 데이터의 시작 ResultSet row 번호
		int startRowNum=1+(pageNum-1)*PAGE_ROW_COUNT;
		//보여줄 페이지 데이터의 끝 ResultSet row 번호
		int endRowNum=pageNum*PAGE_ROW_COUNT;

		//전체 row 의 갯수를 읽어온다.
		//자세히 보여줄 글의 번호가 ref_group  번호 이다. 
		int totalRow=WithCommentDao.getCount(ref_group);
		//전체 페이지의 갯수 구하기
		int totalPageCount=
				(int)Math.ceil(totalRow/(double)PAGE_ROW_COUNT);

		// WithCommentDto 객체에 위에서 계산된 startRowNum 과 endRowNum 을 담는다.
		WithCommentDto commentDto=new WithCommentDto();
		commentDto.setStartRowNum(startRowNum);
		commentDto.setEndRowNum(endRowNum);
		//ref_group 번호도 담는다.
		commentDto.setRef_group(ref_group);

		//DB 에서 댓글 목록을 얻어온다.
		List<WithCommentDto> commentList=WithCommentDao.getList(commentDto);
		//request 에 담아준다.
		request.setAttribute("commentList", commentList);
		request.setAttribute("totalPageCount", totalPageCount);		
		
	}
}

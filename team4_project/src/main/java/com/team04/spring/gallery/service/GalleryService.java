package com.team04.spring.gallery.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.team04.spring.gallery.dto.GalleryDto;

public interface GalleryService {
	public void getList(ModelAndView mView, HttpServletRequest request);	
	public String saveImage(MultipartFile image, HttpServletRequest request);
	public void addContent(GalleryDto dto, HttpSession session);
	public void getDetail(int num, ModelAndView mView);
	public void deleteContent(int num);
}

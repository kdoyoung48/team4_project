package com.team04.spring.gallery.dao;

import java.util.List;

import com.team04.spring.gallery.dto.GalleryDto;

public interface GalleryDao {
	public GalleryDto getData(int num);
	public void insert(GalleryDto dto);
	public List<GalleryDto> getList(GalleryDto dto);
	public int getCount();
	public void delete(int num);
}

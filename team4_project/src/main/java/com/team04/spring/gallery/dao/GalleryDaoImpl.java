package com.team04.spring.gallery.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.team04.spring.gallery.dto.GalleryDto;

@Repository
public class GalleryDaoImpl implements GalleryDao{
	@Autowired
	private SqlSession session;
		
	@Override
	public GalleryDto getData(int num) {
		return session.selectOne("gallery.getData", num);
	}

	@Override
	public void insert(GalleryDto dto) {
		session.insert("gallery.insert", dto);
	}

	@Override
	public List<GalleryDto> getList(GalleryDto dto) {
		return session.selectList("gallery.getList", dto);
	}

	@Override
	public int getCount() {
		return session.selectOne("gallery.getCount");
	}

	@Override
	public void delete(int num) {
		session.delete("gallery.delete",num);
		
	}
	
}

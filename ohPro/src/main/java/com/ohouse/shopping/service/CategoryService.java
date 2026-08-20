package com.ohouse.shopping.service;

import java.sql.Connection;
import java.util.List;

import com.ohouse.shopping.dao.CategoryDAO;
import com.ohouse.shopping.dao.CategoryDAOImple;
import com.ohouse.shopping.dto.CategoryDTO;

public class CategoryService {
	// 나중에 DAO를 통해 카테고리 데이터를 가져온다.
	private CategoryDAO dao = new CategoryDAOImple();

	public List<CategoryDTO> getMainCategories(Connection conn) throws Exception{
		return dao.selectMainCategories(conn);
	}
	
	public List<CategoryDTO> getMiddleCategories(Connection conn, int parentId) throws Exception{
		return dao.selectMiddleCategories(conn,parentId);
	}
	
	public List<CategoryDTO> getSubCategories(Connection conn, int parentId) throws Exception{
		return dao.selectSubCategories(conn,parentId);
	}
	
} // CategoryService

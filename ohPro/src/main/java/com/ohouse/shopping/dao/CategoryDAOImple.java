package com.ohouse.shopping.dao;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

import com.ohouse.shopping.dto.CategoryDTO;

public class CategoryDAOImple implements CategoryDAO{
	
	@Override
	public List<CategoryDTO> selectMainCategories(Connection conn) throws SQLException{
		
		return null;
	}

	@Override
	public List<CategoryDTO> selectMiddleCategories(Connection conn, int parentId) throws SQLException{
		
		return null;
	}
	
	@Override
	public List<CategoryDTO> selectSubCategories(Connection conn, int parentId) throws SQLException{
		
		return null;
	}
	
}

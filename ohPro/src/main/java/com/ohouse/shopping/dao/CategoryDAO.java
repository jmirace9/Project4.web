package com.ohouse.shopping.dao;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

import com.ohouse.shopping.dto.CategoryDTO;

public interface CategoryDAO {
		// 대분류 조회
		List<CategoryDTO> selectMainCategories(Connection conn) throws SQLException;
	
		// 특정 대분류 소속 중분류 조회
		List<CategoryDTO> selectMiddleCategories(Connection conn, int parentId) throws SQLException;
		
		// 특정 중분류 소속 소분류 조회
		List<CategoryDTO> selectSubCategories(Connection conn, int parentId) throws SQLException;
}

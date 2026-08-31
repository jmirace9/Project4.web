package com.ohouse.shopping.service;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

import javax.naming.NamingException;

import com.ohouse.common.jdbc.JdbcUtil;
import com.ohouse.shopping.dao.CategoryDAO;
import com.ohouse.shopping.dao.CategoryDAOImple;
import com.ohouse.shopping.dto.CategoryDTO;
import com.util.ConnectionProvider;

public class CategoryService {
	private final CategoryDAO dao;
	
	public CategoryService(CategoryDAO dao) {
		this.dao = dao;
	}

	public List<CategoryDTO> getMainCategories() throws SQLException, NamingException{
		Connection conn = null;
		
		try {
			conn = ConnectionProvider.getConnection();
			return dao.selectMainCategories(conn);
		} finally {
			JdbcUtil.close(conn);
		}
		
	}
	
	public List<CategoryDTO> getMiddleCategories(int parentId) throws SQLException, NamingException{
		Connection conn = null;
		try {
			conn = ConnectionProvider.getConnection();
			return dao.selectMiddleCategories(conn,parentId);
			
		} finally {
			JdbcUtil.close(conn);
		}
	}
	
	public List<CategoryDTO> getSubCategories(int parentId) throws SQLException, NamingException{
		Connection conn = null;
		
		try {
			conn = ConnectionProvider.getConnection();
			return dao.selectSubCategories(conn,parentId);
			
		} finally {
			JdbcUtil.close(conn);
		}
		
	}
	
} // CategoryService

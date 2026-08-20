package com.ohouse.shopping.command;

import java.sql.Connection;
import java.util.List;

import com.ohouse.common.command.CommandHandler;
import com.ohouse.common.jdbc.JdbcUtil;
import com.ohouse.shopping.dao.CategoryDAO;
import com.ohouse.shopping.dao.CategoryDAOImple;
import com.ohouse.shopping.dto.CategoryDTO;
import com.ohouse.shopping.service.CategoryService;
import com.util.ConnectionProvider;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class CategoryHandler implements CommandHandler {
	
	@Override
	public String process(HttpServletRequest request, HttpServletResponse response) throws Exception{
		// service 호출후 카테고리 데이터 받기
		Connection conn = null;
		
		try {
			conn = ConnectionProvider.getConnection();
			
			CategoryDAO dao = new CategoryDAOImple();
			CategoryService service = new CategoryService();
			
			// DB 준비되면 실제 조회
			// List<CategoryDTO> mainCategories = service.getMainCategories(conn);
			// request.setAttribute("mainCategories", mainCategories);
		} finally {
			JdbcUtil.close(conn);
		} // try-finally
	
		return "/WEB-INF/views/store/category.jsp";
	}
	
} // class

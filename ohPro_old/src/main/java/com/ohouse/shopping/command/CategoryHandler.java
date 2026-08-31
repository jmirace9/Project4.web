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

		System.out.println("===== CategoryHandler.process() 실행 =====");
		
		String categoryId = request.getParameter("category_id");
		String mainCategoryId = "10000000"; // 카테고리 첫화면 기본대분류(가구)
		
		if ( categoryId != null && !categoryId.isEmpty()) {
			 if (categoryId.equals("10000000")) {
			        mainCategoryId = "10000000";

			    } else if (categoryId.equals("16000000")) {
			        mainCategoryId = "16000000";

			    } else if (categoryId.equals("13000000")) {
			        mainCategoryId = "13000000";

			    } else if (categoryId.startsWith("101")) {
			        mainCategoryId = "10000000";

			    } else if (categoryId.startsWith("162")) {
			        mainCategoryId = "16000000";

			    } else if (categoryId.startsWith("13")) {
			        mainCategoryId = "13000000";
			    }
		}// if
		
		System.out.println("categoryId = " + categoryId);
		System.out.println("mainCategoryId = " + mainCategoryId);
		
		request.setAttribute("selectedCategoryId", categoryId);
		request.setAttribute("mainCategoryId", mainCategoryId);
		
		Connection conn = null;
		
		try {
			conn = ConnectionProvider.getConnection();
			
			CategoryDAO dao = new CategoryDAOImple();
			CategoryService service = new CategoryService(dao);
			
			// DB 준비되면 실제 조회
			// List<CategoryDTO> mainCategories = service.getMainCategories(conn);
			// request.setAttribute("mainCategories", mainCategories);
		} finally {
			JdbcUtil.close(conn);
		} // try-finally
	
		return "/WEB-INF/views/store/category.jsp";
	} // process
	
} // class

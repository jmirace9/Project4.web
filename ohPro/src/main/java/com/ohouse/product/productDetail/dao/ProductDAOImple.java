package com.ohouse.product.productDetail.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.ohouse.product.productDetail.dao.ProductImageDAOImple;
import com.ohouse.product.productDetail.dto.ProductDTO;
import com.ohouse.product.productDetail.dto.ProductImageDTO;

public class ProductDAOImple implements ProductDAO {
	
	private ProductImageDAOImple imageDAO = new ProductImageDAOImple();
	
	@Override
	public List<ProductDTO> viewProductByCategories(
	        Connection conn,
	        List<Integer> categoryIds
	) throws SQLException {
		
		 if (categoryIds == null || categoryIds.isEmpty()) {
		        return new ArrayList<>();
		    }

		 String placeholders = String.join(
		            ",",
		            categoryIds.stream()
		                    .map(id -> "?")
		                    .toList()
		    );

		    String sql = """
		            SELECT p.product_id,
		                   p.brand_id,
		                   b.brand_name,
		                   p.product_name,
		                   p.original_price,
		                   p.price,
		                   p.category_id,
		                   p.discount_rate
		            FROM product p
		            JOIN brand b
		              ON p.brand_id = b.brand_id
		            WHERE p.category_id IN (%s)
		            ORDER BY p.product_id
		            """.formatted(placeholders);

		    List<ProductDTO> list = new ArrayList<>();

		    try (PreparedStatement pstmt = conn.prepareStatement(sql)) {

		        for (int i = 0; i < categoryIds.size(); i++) {
		            pstmt.setInt(i + 1, categoryIds.get(i));
		        }

		        try (ResultSet rs = pstmt.executeQuery()) {

		            while (rs.next()) {

		                ProductDTO pdto = new ProductDTO(
		                        rs.getLong("brand_id"),
		                        rs.getString("product_name"),
		                        rs.getLong("original_price"),
		                        rs.getLong("price"),
		                        rs.getLong("category_id"),
		                        rs.getDouble("discount_rate")
		                );

		                pdto.setBrand_name(
		                        rs.getString("brand_name")
		                );

		                pdto.setProduct_id(
		                        rs.getLong("product_id")
		                );

		                List<ProductImageDTO> images =
		                        imageDAO.viewImage(
		                                conn,
		                                rs.getLong("product_id")
		                        );

		                if (images != null && !images.isEmpty()) {
		                    pdto.setImage_url(
		                            images.get(0).getImage_url()
		                    );
		                }

		                list.add(pdto);
		            }
		        }
		    }

		    return list;
		}
	
	@Override
	public ProductDTO viewProduct(
	        Connection conn,
	        long productId
	) throws SQLException {

	    String sql = """
	            SELECT p.product_id,
	                   p.brand_id,
	                   b.brand_name,
	                   p.product_name,
	                   p.original_price,
	                   p.price,
	                   p.category_id,
	                   p.discount_rate
	            FROM product p JOIN brand b ON p.brand_id = b.brand_id
	            WHERE p.product_id = ?
	            """;

	    try (PreparedStatement pstmt = conn.prepareStatement(sql)) {

	        pstmt.setLong(1, productId);

	        try (ResultSet rs = pstmt.executeQuery()) {

	            if (rs.next()) {

	                ProductDTO pdto = new ProductDTO(
	                        rs.getLong("brand_id"),
	                        rs.getString("product_name"),
	                        rs.getLong("original_price"),
	                        rs.getLong("price"),
	                        rs.getLong("category_id"),
	                        rs.getDouble("discount_rate")
	                );

	                pdto.setProduct_id(rs.getLong("product_id"));
	                pdto.setBrand_name(rs.getString("brand_name"));

	                return pdto;
	            }
	        }
	    }

	    return null;
	}

    @Override
    public List<ProductDTO> allviewProduct(
            Connection conn
    ) throws SQLException {

        String sql = """
                SELECT brand_id,
                       product_name,
                       original_price,
                       price,
                       category_id,
                       discount_rate
                FROM product
                ORDER BY product_id
                """;

        List<ProductDTO> list = new ArrayList<>();

        try (
                PreparedStatement pstmt = conn.prepareStatement(sql);
                ResultSet rs = pstmt.executeQuery()
        ) {

            while (rs.next()) {

                ProductDTO pdto = new ProductDTO(
                        rs.getLong("brand_id"),
                        rs.getString("product_name"),
                        rs.getLong("original_price"),
                        rs.getLong("price"),
                        rs.getLong("category_id"),
                        rs.getDouble("discount_rate")
                );

                list.add(pdto);
            }
        }

        return list;
    }

} // class
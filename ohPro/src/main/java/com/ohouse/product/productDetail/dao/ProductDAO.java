package com.ohouse.product.productDetail.dao;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

import com.ohouse.product.productDetail.dto.ProductDTO;

public interface ProductDAO {

    ProductDTO viewProduct(Connection conn,long productId) throws SQLException;

    List<ProductDTO> allviewProduct(Connection conn) throws SQLException;

    List<ProductDTO> viewProductByCategories(
        Connection conn,
        List<Integer> categoryIds
    ) throws SQLException;
}
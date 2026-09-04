package com.ohouse.product.productDetail.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
@Builder
public class ProductDTO {

        private long brand_id;
        private String brand_name;
        private String product_name;
        private long product_id;
        private long original_price;
        private String image_url;
        private long price;
        private long category_id;
        private double discount_rate;

}

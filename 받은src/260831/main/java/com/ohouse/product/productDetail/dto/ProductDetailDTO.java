package com.ohouse.product.productDetail.dto;


import lombok.Getter;
import lombok.Setter;

import java.util.List;

@Getter
@Setter
public class ProductDetailDTO {

    private ProductDTO productDTO;
    private List<ProductImageDTO> imageDTOList;
    private List<OptionDTO> optionDTOList;
    private List<CategoryDTO> categoryDTOList;
}

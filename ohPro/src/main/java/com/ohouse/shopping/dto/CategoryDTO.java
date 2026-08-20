package com.ohouse.shopping.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@Builder

public class CategoryDTO {
	// 칼럼들
    private int categoryId;			// 카테고리 식별번호
    private String categoryName;	// 카테고리 이름
    private int parentId;			// 누구에 속한 카테고리인지 확인
    private int categoryLevel;		// 대, 중, 소 분류 구분

}

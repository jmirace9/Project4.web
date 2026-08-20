# 오늘의집 프로젝트 - 상품 상세/API 및 DB 모델링 검증 메모

내 프로젝트 정보 정리

## 1. 검증 대상

### 상품 상세 페이지
- https://store.ohou.se/goods/329364?affect_type=ProductCategoryIndex

### 상품 옵션 API
- https://store.ohou.se/api/goods/options?id=329364

> 기준 상품: 상품 상세 페이지에서 실제 옵션 선택 및 장바구니 동작을 확인한 상품

---

# 2. 상품 상세 페이지에서 확인한 기능

상품 상세 페이지에서 다음과 같은 정보 및 interaction을 확인했다.

### 상품 기본 정보
- 상품 ID
- 상품명
- 브랜드
- 가격
- 할인율
- 리뷰 정보
- 배송비
- 배송 정보
- 상품 이미지
- 상품 상세 정보

### 상품 옵션
상품마다 옵션의 종류와 개수가 다를 수 있음.

예:
- 사이즈
- 색상
- 구성
- 추가 구매상품 등

따라서 `PRODUCT` 테이블에

```text
size
color
material
configuration 등을 직접 컬럼으로 계속 추가하는 방식은 적절하지 않음.

## 상품 테이블 예시
production
├─ id
├─ name
├─ image
├─ user
├─ brand
├─ delivery
├─ firstDepthName  -> 사이즈 (1차옵션)
├─ secondDepthName -> 색상   (2차옵션)
├─ options[]
└─ extraOptions[]

상품마다 (1차옵션)(2차옵션) 구조가 달라질 수 있음.

옵션 조합마다 자체 고유ID가 존재함
PRODUCT
   │
   └── PRODUCT_OPTION
          ├─ option_id
          ├─ product_id
          ├─ price
          └─ stock

옵션 밑의 추가구매 (별도상품)
extraOptions

CART
----------------------
cart_id       PK
user_id       FK NULL
guest_token   NULL
created_at
updated_at

회원일때
user_id = 회원 ID
guest_token = NULL

비회원일때 
user_id = NULL
guest_token = 비회원 식별값

- 장바구니와 상품 옵션 관계
CART
 │
 │ 1:N
 ▼
CART_ITEM
 │
 ├──────── PRODUCT
 │
 └──────── PRODUCT_OPTION

- 장바구니 예시
 CART
│
└── CART_ITEM
      ├─ cart_id
      ├─ product_id
      ├─ option_id
      └─ quantity

-- DB ERD확장
PRODUCT
   │
   ├──────── PRODUCT_IMAGE
   │
   └──────── PRODUCT_OPTION
                  │
                  ├─ 옵션 조합
                  ├─ 가격
                  └─ 재고


USER
 │
 ▼
CART
 │
 ▼
CART_ITEM
 │
 ├──────── PRODUCT
 │
 └──────── PRODUCT_OPTION

product의 컬럼
product_id       PK
category_id      FK
brand_id         FK
product_name
price
discount_rate
description
...

product_option의 컬럼
option_id        PK
product_id       FK
option_value1
option_value2
price
stock
...
예)
option_id | product_id | option_value1 | option_value2 | price | stock
----------------------------------------------------------------------
5010392   | 329364     | S             | 그레이         | ...   | ...
5010393   | 329364     | S             | 아이보리       | ...   | ...
5010394   | 329364     | SS            | 그레이         | ...   | ...

option_value1, option_value2는 교육 프로젝트에서 단순화한 설계안.
실제 서비스 수준에서는 OPTION_GROUP / OPTION_VALUE / SKU(상품 옵션 조합) 구조로 더 정규화할 수 있음.

CART의 칼럼 (회원/비회원의 장바구니를 관리)
cart_id PK
user_id FK / NULL
guest_token (방문 비회원에게 고유식별값 주고 브라우저에 쿠키로저장)
    ㄴ 예) String guestToken = UUID.randomUUID().toString(); // JAVA 코딩
created_at 장바구니 생성시간
updated_at 장바구니 최종 변경시간

CART_ITEM의 칼럼 (장바구니에 담긴 실제 상품과 선택 옵션)
1. cart_item_id
2. cart_id
3. product_id
4. option_id
5. quantity (수량)

## 추가 검증 해볼만한것
# 장바구니
같은 상품의 다른 옵션을 각각 담았을 때
같은 옵션을 다시 담았을 때
수량 변경
옵션 변경
비회원 → 로그인 전환
로그인 후 기존 장바구니 유지

260820 com.ohouse.shopping 패키지 쪽추가

우리 dispathcerServlet 확인

http://localhost:8080/ohPro/store/category.htm 로 연결
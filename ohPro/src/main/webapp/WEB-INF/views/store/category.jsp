<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<jsp:include page="/WEB-INF/views/layout/header.jsp" />

<style>
    /* --- 스토어 전용 서브 네비게이션 --- */
    .store-sub-nav-area { border-bottom: 1px solid #EAEDEF; background: #fff; margin-bottom: 30px; position: sticky; top: 0; z-index: 90; }
    .store-sub-nav { display: flex; justify-content: space-between; align-items: center; }
    .sub-menu-list { display: flex; gap: 24px; font-size: 15px; font-weight: 700; color: #424242; }
    .sub-menu-list a { padding: 12px 0; position: relative; }
    .sub-menu-list a.active { color: #00A6EA; border-bottom: 2px solid #00A6EA; }

    /* --- 2단 분할 레이아웃 --- */
    .category-layout { display: flex; gap: 40px; margin-bottom: 100px; }

    /* 1. 좌측 사이드바 (카테고리 메뉴) */
    .sidebar { width: 200px; flex-shrink: 0; }
    .sidebar-title { font-size: 20px; font-weight: 700; color: #2F3438; margin-bottom: 20px; padding-bottom: 10px; }
    
    .sidebar-menu { display: flex; flex-direction: column; gap: 4px; }
    .sidebar-item { display: flex; justify-content: space-between; align-items: center; padding: 5px 0; font-size: 15px; color: black; cursor: pointer; font-weight: 500; }
    .sidebar-item:hover, .sidebar-item.active { color: #757575; font-weight: 700; }
    .sidebar-arrow { font-size: 12px; color: #757575; }

    /* 다른 대분류 카테고리들 */
    .sidebar-notselected  {   margin-top: 40px;
    border-top: 1px solid #EAEDEF;
    padding-top: 20px;
    display: flex;
    flex-direction: column;
    gap: 10px;}
    .sidebar-other { cursor: pointer;  font-size: 20px;
    font-weight: 700;
    color: #2F3438;}
    .sidebar-other:hover { color:#757575; }

    /* 2. 우측 메인 컨텐츠 영역 */
    .main-content { flex-grow: 1; min-width: 0; }

    .banner-header { font-size: 14px; font-weight: 700; margin-bottom: 15px; }
    .category-banners { display: grid; grid-template-columns: repeat(3, 1fr); gap: 16px; margin-bottom: 50px; }
    .banner-box { border-radius: 6px; overflow: hidden; background-color: #EAEDEF; aspect-ratio: 1/1; cursor: pointer; }
    .banner-box img { width: 100%; height: 100%; object-fit: cover; }

    .filter-section { margin-bottom: 30px; }
    .filter-row { display: flex; flex-wrap: wrap; gap: 8px; margin-bottom: 10px; }
    .filter-btn { padding: 6px 12px; border: 1px solid #DADCE0; background: #fff; border-radius: 4px; font-size: 13px; font-weight: 500; color: #424242; cursor: pointer; display: flex; align-items: center; gap: 4px; }
    .filter-btn:hover { background: #F7F9FA; }
    .filter-btn.active { border-color: #35C5F0; color: #35C5F0; background: #F4FBFE; font-weight: 700; }

    .list-header { display: flex; justify-content: space-between; align-items: center; font-size: 13px; color: #424242; margin-bottom: 20px; }
    .list-count { font-weight: 500; }
    .sort-select { border: none; font-size: 13px; color: #424242; font-weight: 700; cursor: pointer; outline: none; }

    .product-grid { display: grid; grid-template-columns: repeat(3, 1fr); gap: 30px 20px; }
    
    /* ★ 상품 카드 영역 (Only 뱃지 탈출 방지!) ★ */
    .product-card { cursor: pointer; display: flex; flex-direction: column; }
    .product-img-wrap { width: 100%; aspect-ratio: 1 / 1; border-radius: 8px; overflow: hidden; margin-bottom: 12px; position: relative; background-color: #F7F9FA; }
    .product-img-wrap img { width: 100%; height: 100%; object-fit: cover; transition: transform 0.2s; }
    .product-card:hover .product-img-wrap img { transform: scale(1.05); }
    .only-badge { position: absolute; top: 10px; left: 10px; background: #2F3438; color: white; padding: 4px 6px; border-radius: 4px; font-size: 10px; font-weight: 700; z-index: 10; }
    
    .brand { font-size: 11px; color: #757575; font-weight: 600; margin-bottom: 4px; }
    .title { font-size: 13px; color: #2F3438; line-height: 1.4; margin-bottom: 8px; }
    .price-wrap { display: flex; align-items: center; gap: 6px; font-size: 17px; font-weight: 700; margin-bottom: 6px; }
    .discount { color: #35C5F0; }
    .price { color: #000; }
    .review-wrap { font-size: 12px; font-weight: 700; color: #424242; display: flex; align-items: center; gap: 4px; margin-bottom: 8px; }
    .star { color: #35C5F0; font-size: 14px; }
    
    .badge-wrap { display: flex; flex-wrap: wrap; gap: 4px; }
    .badge { padding: 3px 6px; font-size: 10px; font-weight: 700; border-radius: 3px; }
    .badge-free { background-color: #EAEDEF; color: #757575; }
    .badge-special { background-color: #FF7777; color: white; }
</style>

<!-- 스토어 전용 서브 메뉴 -->
<div class="store-sub-nav-area">
    <div class="container store-sub-nav">
        <div class="sub-menu-list">
            <a href="#">쇼핑홈</a>
            <a href="#" class="active">카테고리</a>
            <a href="#">베스트</a>
            <a href="#">오늘의딜</a>
            <a href="#">단독상품</a>
            <a href="#">오마트</a>
            <a href="#">원하는날도착</a>
        </div>
    </div>
</div>

<!-- 2단 분할 메인 컨텐츠 시작 -->
<main class="container category-layout">
    
    <!-- 좌측 사이드바 -->
    <aside class="sidebar">
     <div class="selected-category-area">
     <!-- 대분류 : 가구 -->
     <c:if test="${mainCategoryId == '10000000'}">
      <div class="category-panel category-furniture">
        <h2 class="sidebar-selected">가구</h2>
        <div class="sidebar-menu">
            <div class="sidebar-item">오늘의집 Only</div>
            <div class="sidebar-item">침대 <span class="sidebar-arrow">∨</span></div>
            	<div class="sidebar-submenu">
	            	<a href="/ohPro/store/category.htm?category_id=10120001" class="subcategory ${selectedCategoryId == '10120001'?'selected':'' }" data-category-id="10120001">침대 프레임</a><br>
				    <a href="/ohPro/store/category.htm?category_id=10120002" class="subcategory" data-category-id="10120002">침대+매트리스</a><br>
				    <a href="/ohPro/store/category.htm?category_id=10120003" class="subcategory" data-category-id="10120003">침대부속가구</a><br>
            	</div>
            <div class="sidebar-item">매트리스·토퍼 <span class="sidebar-arrow">∨</span></div>
            	<div class="sidebar-submenu">
	            	<a href="/ohPro/store/category.htm?category_id=10130001" class="subcategory" data-category-id="10130001">매트리스</a><br>
				    <a href="/ohPro/store/category.htm?category_id=10130002" class="subcategory" data-category-id="10130002">토퍼</a><br>				    
            	</div>
            <div class="sidebar-item">테이블·식탁·책상 <span class="sidebar-arrow">∨</span></div>
            	<div class="sidebar-submenu">
	            	<a href="/ohPro/store/category.htm?category_id=10150001" class="subcategory" data-category-id="10150001">거실/소파테이블</a><br>
				    <a href="/ohPro/store/category.htm?category_id=10150002" class="subcategory" data-category-id="10150002">사이드테이블</a><br>
				    <a href="/ohPro/store/category.htm?category_id=10150003" class="subcategory" data-category-id="10150003">식탁</a><br>
            	</div>
            <div class="sidebar-item">소파 <span class="sidebar-arrow">∨</span></div>
            <div class="sidebar-item">서랍·수납장 <span class="sidebar-arrow">∨</span></div>
            <div class="sidebar-item">거실장·TV장 <span class="sidebar-arrow">∨</span></div>
            <div class="sidebar-item">선반 <span class="sidebar-arrow">∨</span></div>
            <div class="sidebar-item">진열장·책장 <span class="sidebar-arrow">∨</span></div>
            <div class="sidebar-item">의자 <span class="sidebar-arrow">∨</span></div>
            <div class="sidebar-item">행거.옷장 <span class="sidebar-arrow">∨</span></div>
            <div class="sidebar-item">거울 <span class="sidebar-arrow">∨</span></div>
            <div class="sidebar-item">화장대.콘솔 <span class="sidebar-arrow">∨</span></div>
            <div class="sidebar-item">유아동가구 <span class="sidebar-arrow">∨</span></div>
            <div class="sidebar-item">야외가구 <span class="sidebar-arrow">∨</span></div>
            <div class="sidebar-item">가벽.파티션 <span class="sidebar-arrow">∨</span></div>
            <div class="sidebar-item">공간별가구 <span class="sidebar-arrow">∨</span></div>
        </div>
      </div>
     
     </c:if>
     <!-- 대분류 : 주방용품 -->
     <c:if test="${mainCategoryId == '16000000'}">

    <div class="category-panel category-kitchen">

        <h2 class="sidebar-selected">주방용품</h2>

        <div class="sidebar-menu">

            <div class="sidebar-item">오늘의집 Only</div>
            <div class="sidebar-item">O!PLATING</div>
            <div class="sidebar-item">
                그릇/식기
                <span class="sidebar-arrow">∨</span>
            </div>

            <div class="sidebar-submenu">

                <a href="/ohPro/store/category.htm?category_id=16220001" class="subcategory ${selectedCategoryId == '16220001'?'selected':''}" data-category-id="16220001">홈세트</a><br>

                <a href="/ohPro/store/category.htm?category_id=16220002"
                   class="subcategory ${selectedCategoryId == '16220002'?'selected':''}"
                   data-category-id="16220002">
                    공기/대접
                </a><br>

                <a href="/ohPro/store/category.htm?category_id=16220003"
                   class="subcategory ${selectedCategoryId == '16220003'?'selected':''}"
                   data-category-id="16220003">
                    접시/플레이트
                </a><br>

            </div>

            <div class="sidebar-item">
                냄비/프라이팬/솥
                <span class="sidebar-arrow">∨</span>
            </div>

            <div class="sidebar-submenu">

                <a href="/ohPro/store/category.htm?category_id=16230001"
                   class="subcategory ${selectedCategoryId == '16230001'?'selected':''}"
                   data-category-id="16230001">
                    냄비/프라이팬세트
                </a><br>

                <a href="/ohPro/store/category.htm?category_id=16230002"
                   class="subcategory ${selectedCategoryId == '16230002'?'selected':''}"
                   data-category-id="16230002">
                    냄비/뚝배기
                </a><br>

                <a href="/ohPro/store/category.htm?category_id=16230003"
                   class="subcategory ${selectedCategoryId == '16230003'?'selected':''}"
                   data-category-id="16230003">
                    압력솥/찜솥
                </a><br>

            </div>

            <div class="sidebar-item">
                컵/잔/텀블러
                <span class="sidebar-arrow">∨</span>
            </div>

            <div class="sidebar-submenu">

                <a href="/ohPro/store/category.htm?category_id=16240001"
                   class="subcategory ${selectedCategoryId == '16240001'?'selected':''}"
                   data-category-id="16240001">
                    머그컵
                </a><br>

                <a href="/ohPro/store/category.htm?category_id=16240002"
                   class="subcategory ${selectedCategoryId == '16240002'?'selected':''}"
                   data-category-id="16240002">
                    유리컵/물컵
                </a><br>

                <a href="/ohPro/store/category.htm?category_id=16240003"
                   class="subcategory ${selectedCategoryId == '16240003'?'selected':''}"
                   data-category-id="16240003">
                    텀블러/빨대/컵소품
                </a><br>

            </div>
		 <div class="sidebar-item">수저/커트러리</div>
		 <div class="sidebar-item">주방수납/정리</div>
		 <div class="sidebar-item">식기건조대</div>
		 <div class="sidebar-item">보관/용기/도시락</div>
		 <div class="sidebar-item">주방잡화</div>
		 <div class="sidebar-item">조리도구</div>
		 <div class="sidebar-item">칼/도마/커팅기구</div>
		 <div class="sidebar-item">주방패브릭</div>
		 <div class="sidebar-item">주방일회용품</div>
		 <div class="sidebar-item">커피/티용품</div>
		 <div class="sidebar-item">와인/칵테일용품</div>
        </div>

    </div>

</c:if>
     <!-- 대분류 : 수납/정리 -->
 <c:if test="${mainCategoryId == '13000000'}">

    <div class="category-panel category-storage">

        <h2 class="sidebar-selected">수납/정리</h2>

        <div class="sidebar-menu">
        	 <div class="sidebar-item">오늘의집 Only</div>
            <!-- 서랍장/트롤리 -->
            <div class="sidebar-item">
                서랍장/트롤리
                <span class="sidebar-arrow">∨</span>
            </div>

            <div class="sidebar-submenu">

                <a href="/ohPro/store/category.htm?category_id=13050002"
                   class="subcategory ${selectedCategoryId == '13050002'?'selected':''}"
                   data-category-id="13050002">
                    플라스틱서랍장
                </a><br>

                <a href="/ohPro/store/category.htm?category_id=13050003"
                   class="subcategory ${selectedCategoryId == '13050003'?'selected':''}"
                   data-category-id="13050003">
                    트롤리/이동식선반
                </a><br>

                <a href="/ohPro/store/category.htm?category_id=13050004"
                   class="subcategory ${selectedCategoryId == '13050004'?'selected':''}"
                   data-category-id="13050004">
                    공간박스
                </a><br>

            </div>


            <!-- 리빙박스/수납함 -->
            <div class="sidebar-item">
                리빙박스/수납함
                <span class="sidebar-arrow">∨</span>
            </div>

            <div class="sidebar-submenu">

                <a href="/ohPro/store/category.htm?category_id=13140006"
                   class="subcategory ${selectedCategoryId == '13140006'?'selected':''}"
                   data-category-id="13140006">
                    수납박스/리빙박스
                </a><br>

                <a href="/ohPro/store/category.htm?category_id=13140007"
                   class="subcategory ${selectedCategoryId == '13140007'?'selected':''}"
                   data-category-id="13140007">
                    팬트리정리함
                </a><br>

                <a href="/ohPro/store/category.htm?category_id=13140008"
                   class="subcategory ${selectedCategoryId == '13140008'?'selected':''}"
                   data-category-id="13140008">
                    약/구급정리함
                </a><br>

            </div>


            <!-- 행거 -->
            <div class="sidebar-item">
                행거
                <span class="sidebar-arrow">∨</span>
            </div>

            <div class="sidebar-submenu">

                <a href="/ohPro/store/category.htm?category_id=13020002"
                   class="subcategory ${selectedCategoryId == '13020002'?'selected':''}"
                   data-category-id="13020002">
                    스탠드행거
                </a><br>

                <a href="/ohPro/store/category.htm?category_id=13020003"
                   class="subcategory ${selectedCategoryId == '13020003'?'selected':''}"
                   data-category-id="13020003">
                    이동식행거
                </a><br>

                <a href="/ohPro/store/category.htm?category_id=13020004"
                   class="subcategory ${selectedCategoryId == '13020004'?'selected':''}"
                   data-category-id="13020004">
                    고정식행거
                </a><br>

            </div>
			 <div class="sidebar-item">빨래바구니/햄퍼</div>
			 <div class="sidebar-item">선반</div>
			 <div class="sidebar-item">옷걸이</div>
			 <div class="sidebar-item">옷정리/이불정리</div>
			 <div class="sidebar-item">화장대/테이블정리</div>
			 <div class="sidebar-item">현관/신발정리</div>
			 <div class="sidebar-item">후크/수납걸이</div>
			 <div class="sidebar-item">공간별수납정리</div>
        </div>

    </div>

</c:if>

    </div> <!-- <div class="selected-category-area"> -->
     
        <style>
        .sidebar-submenu {
			    display: none;
			    padding: 5px 0 5px 15px;
			    font-size: 15px;
			    color: #757575;
			}
			
		.subcategory.selected {
		    font-weight: bold;
		}
		.sidebar-selected {
		    font-size: 20px;
		    font-weight: 700;
		    color: #2F3438;
		    margin-bottom: 20px;
		    padding-bottom: 10px;
		}
        </style>

    <!-- 좌측 사이드바 접기/열기 -->
    <script>
    $(".category-furniture .sidebar-item").first().next(".sidebar-submenu").show();
    
    	$(".sidebar-item").click( function () {
			$(this).next(".sidebar-submenu").slideToggle();
		});
    </script>
    
        <div class="sidebar-notselected">
        	<!-- 구현 대분류 -->
        	<c:if test="${mainCategoryId != '10000000' }">
        		<div class="sidebar-other category-enabled" data-category-id="10000000">가구</div>
        	</c:if>
        	<c:if test="${mainCategoryId != '16000000' }">
            <div class="sidebar-other category-enabled" data-category-id="16000000">주방용품</div>
            </c:if>
            <c:if test="${mainCategoryId != '13000000' }">
            <div class="sidebar-other category-enabled" data-category-id="13000000">수납·정리</div>
            </c:if>
            <!-- 비구현 대분류 -->
            <div class="sidebar-other">폭염대비</div>
            <div class="sidebar-other">패브릭</div>
            <div class="sidebar-other">가전·디지털</div>
            <div class="sidebar-other">식품</div>
            <div class="sidebar-other">생활용품</div>
            <div class="sidebar-other">생필품</div>
            <div class="sidebar-other">유아.아동</div>
            <div class="sidebar-other">반려동물</div>
            <div class="sidebar-other">캠핑.레저</div>
            <div class="sidebar-other">공구.DIY</div>
            <div class="sidebar-other">인테리어시공</div>
            <div class="sidebar-other">렌탈.구독</div>
            <div class="sidebar-other">장보기</div>
        </div>
    </aside>
    
    <!-- 대분류 클릭 -->
    <script>
    	$(".category-enabled").click(function () {
			const categoryId = $(this).data("category-id");
			location.href = "/ohPro/store/category.htm?category_id="+categoryId;
    	})
		
    </script>
    

    <!-- 우측 메인 컨텐츠 -->
    <div class="main-content">
        
        <div class="banner-header">가구</div>
        <div class="category-banners">
            <div class="banner-box"><img src="https://images.unsplash.com/photo-1554995207-c18c203602cb?w=400" alt="가구배너1"></div>
            <div class="banner-box"><img src="https://images.unsplash.com/photo-1505691938895-1758d7feb511?w=400" alt="가구배너2"></div>
            <div class="banner-box"><img src="https://images.unsplash.com/photo-1583847268964-b28ce8f30321?w=400" alt="가구배너3"></div>
        </div>

        <div class="filter-section">
            <div class="filter-row">
                <button class="filter-btn active" style="color:#00A6EA; border-color:#00A6EA;">% 오세일특가</button>
                <button class="filter-btn" style="color:#00A6EA; font-weight:700;">🚚 원하는날도착</button>
                <button class="filter-btn" style="color:#FF7777;">📦 패키지 할인</button>
                <button class="filter-btn">색상 ∨</button>
                <button class="filter-btn">주요 소재 ∨</button>
                <button class="filter-btn">우드톤 ∨</button>
                <button class="filter-btn">바이너리샵 ∨</button>
                <button class="filter-btn">사용 인원 ∨</button>
            </div>
            <div class="filter-row">
                <button class="filter-btn">리퍼 상품 ∨</button>
                <button class="filter-btn">패키지 할인 ∨</button>
                <button class="filter-btn">상품 유형 ∨</button>
                <button class="filter-btn">브랜드 ∨</button>
                <button class="filter-btn">특가 ∨</button>
                <button class="filter-btn">오늘의집only ∨</button>
                <button class="filter-btn">가격 ∨</button>
                <button class="filter-btn">배송 ∨</button>
            </div>
        </div>

        <div class="list-header">
            <span class="list-count">전체 311,647개</span>
            <select class="sort-select">
                <option>추천순 ∨</option>
                <option>인기순</option>
                <option>최신순</option>
                <option>가격 낮은순</option>
            </select>
        </div>

        <div class="product-grid">
            
            <div class="product-card">
                <div class="product-img-wrap">
                    <span class="only-badge">Only</span>
                    <img src="https://images.unsplash.com/photo-1505693314120-0d443867891c?w=400" alt="침대1">
                </div>
                <div class="brand">휴도</div>
                <div class="title">지정일배송/무료설치 | 편안한 제주 25cm 본넬스프링 침대</div>
                <div class="price-wrap"><span class="discount">30%</span><span class="price">429,000</span></div>
                <div class="review-wrap"><span class="star">★</span> 4.8 <span style="color:#9E9E9E; font-weight:400;">리뷰 310</span></div>
                <div class="badge-wrap">
                    <span class="badge badge-free">무료배송</span><span class="badge badge-special">특가</span>
                </div>
            </div>

            <div class="product-card">
                <div class="product-img-wrap">
                    <span class="only-badge">Only</span>
                    <img src="https://images.unsplash.com/photo-1584622781564-1d987f7333c1?w=400" alt="침대2">
                </div>
                <div class="brand">지누스</div>
                <div class="title">[오늘의집 단독] 컴피 토퍼 분리형 포켓 스프링 매트리스 28cm</div>
                <div class="price-wrap"><span class="discount">50%</span><span class="price">259,000</span></div>
                <div class="review-wrap"><span class="star">★</span> 4.9 <span style="color:#9E9E9E; font-weight:400;">리뷰 94</span></div>
                <div class="badge-wrap">
                    <span class="badge badge-free">무료배송</span><span class="badge badge-special">특가</span>
                </div>
            </div>

            <div class="product-card">
                <div class="product-img-wrap">
                    <img src="https://images.unsplash.com/photo-1522771739844-6a9f6d5f14af?w=400" alt="침대3">
                </div>
                <div class="brand">수면밀도</div>
                <div class="title">허리 디스크 환자가 만든 매트리스 S/SS/Q/K/LK 미디엄하드</div>
                <div class="price-wrap"><span class="discount">37%</span><span class="price">499,000</span></div>
                <div class="review-wrap"><span class="star">★</span> 4.9 <span style="color:#9E9E9E; font-weight:400;">리뷰 114</span></div>
                <div class="badge-wrap">
                    <span class="badge badge-free" style="color:#00A6EA; background:#F4FBFE; border:1px solid #00A6EA;">🚚 원하는날도착</span>
                </div>
            </div>

            <div class="product-card">
                <div class="product-img-wrap">
                    <img src="https://images.unsplash.com/photo-1505691938895-1758d7feb511?w=400" alt="소파">
                </div>
                <div class="brand">데일리리빙</div>
                <div class="title">[쿠폰가 48.4만][오늘의집 단독] 팬텀 4인용 프리미엄 타워 스프링 소파</div>
                <div class="price-wrap"><span class="discount">35%</span><span class="price">189,000</span></div>
                <div class="review-wrap"><span class="star">★</span> 4.8 <span style="color:#9E9E9E; font-weight:400;">리뷰 2,017</span></div>
                <div class="badge-wrap">
                    <span class="badge badge-free">조건부 무료배송</span>
                </div>
            </div>

            <div class="product-card">
                <div class="product-img-wrap">
                    <img src="https://images.unsplash.com/photo-1540574163026-643ea20d25b5?w=400" alt="책상">
                </div>
                <div class="brand">플랫포인트</div>
                <div class="title">[BEST] 플랫포인트 의자/수납/식탁 인기가구 BIG SALE 모음전</div>
                <div class="price-wrap"><span class="discount">42%</span><span class="price">8,300 외</span></div>
                <div class="review-wrap"><span class="star">★</span> 4.9 <span style="color:#9E9E9E; font-weight:400;">리뷰 2,973</span></div>
            </div>

        </div>
    </div>
</main>

<jsp:include page="/WEB-INF/views/layout/footer.jsp" />
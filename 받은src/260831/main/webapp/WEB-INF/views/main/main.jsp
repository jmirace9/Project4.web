<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>오늘의집 - 인테리어 플랫폼</title>
<style>
/* 기본 리셋 및 폰트 */
body {
	margin: 0;
	padding: 0;
	font-family: 'Malgun Gothic', 'Apple SD Gothic Neo', sans-serif;
	background-color: #fff;
	color: #292929;
	box-sizing: border-box;
}

a {
	text-decoration: none;
	color: inherit;
}

ul {
	list-style: none;
	padding: 0;
	margin: 0;
}

.container {
	max-width: 1136px;
	margin: 0 auto;
	padding: 0 20px;
	box-sizing: border-box;
}

/* --- 서브 네비게이션 --- */
.home-sub-nav-area {
	border-bottom: 1px solid #EAEDEF;
	background: #fff;
	margin-bottom: 30px;
}

.home-sub-nav {
	max-width: 1136px;
	margin: 0 auto;
	padding: 0 20px;
	display: flex;
	justify-content: space-between;
	align-items: center;
	box-sizing: border-box;
}

.sub-nav-list {
	display: flex;
	gap: 24px;
	font-size: 15px;
	font-weight: 700;
	color: #424242;
}

.sub-nav-list a {
	padding: 12px 0;
	position: relative;
	transition: color 0.2s;
}

.sub-nav-list a:hover, .sub-nav-list a.active {
	color: #1496f4;
}

.sub-nav-list a.active::after {
	content: "";
	position: absolute;
	bottom: -1px;
	left: 0;
	width: 100%;
	height: 2px;
	background-color: #1496f4;
}

/* --- 상단 더블 배너 --- */
.top-banners {
	display: grid;
	grid-template-columns: 1fr 1fr;
	gap: 20px;
	margin-bottom: 40px;
}

.banner-img {
	width: 100%;
	aspect-ratio: 16/9;
	border-radius: 8px;
	background-color: #EAEDEF;
	object-fit: cover;
	cursor: pointer;
	transition: opacity 0.2s;
}

.banner-img:hover {
	opacity: 0.9;
}

/* --- 카테고리 아이콘 그리드 --- */
.category-section {
	margin-bottom: 50px;
}

.category-title {
	font-size: 20px;
	font-weight: 700;
	margin-bottom: 20px;
	color: #000;
}

.category-grid {
	display: grid;
	grid-template-columns: repeat(10, 1fr);
	gap: 10px 0;
	text-align: center;
}

.category-item {
	display: flex;
	flex-direction: column;
	align-items: center;
	gap: 8px;
	cursor: pointer;
}

.category-icon {
	width: 60px;
	height: 60px;
	border-radius: 24px;
	background-color: #F7F9FA;
	display: flex;
	justify-content: center;
	align-items: center;
	font-size: 28px;
	transition: transform 0.2s;
}

.category-item:hover .category-icon {
	transform: translateY(-3px);
}

.category-name {
	font-size: 13px;
	color: #424242;
	font-weight: 500;
}

/* --- 추천상품 그리드 (DB 연동 영역) --- */
.recommend-section {
	margin-bottom: 60px;
}

.recommend-title {
	font-size: 20px;
	font-weight: 700;
	margin-bottom: 20px;
	color: #000;
}

.grid-4 {
	display: grid;
	grid-template-columns: repeat(4, 1fr);
	gap: 24px 20px;
}

.product-card {
	cursor: pointer;
	display: block;
}

.product-img-wrap {
	width: 100%;
	aspect-ratio: 1/1;
	border-radius: 8px;
	background-color: #F7F9FA;
	margin-bottom: 12px;
	overflow: hidden;
	position: relative;
}

.product-img-wrap img {
	width: 100%;
	height: 100%;
	object-fit: cover;
	transition: transform 0.2s;
}

.product-card:hover .product-img-wrap img {
	transform: scale(1.05);
}

.brand-name {
	font-size: 11px;
	color: #757575;
	font-weight: 600;
	margin-bottom: 4px;
}

.product-name {
	font-size: 13px;
	color: #2F3438;
	line-height: 1.4;
	margin-bottom: 8px;
	font-weight: 400;
	word-break: keep-all;
}

.price-area {
	display: flex;
	align-items: center;
	gap: 6px;
	font-size: 17px;
	font-weight: 700;
}

.discount {
	color: #1496f4;
}

.price {
	color: #000;
}

.review-area {
	font-size: 12px;
	color: #757575;
	margin-top: 6px;
	font-weight: 700;
}

.star {
	color: #1496f4;
	margin-right: 2px;
}
</style>
</head>
<body>

	<!-- 헤더 Include -->
	<jsp:include page="../layout/header.jsp" />

	<!-- 서브 네비게이션 -->
	<div class="home-sub-nav-area">
		<div class="home-sub-nav">
			<nav class="sub-nav-list">
				<a href="/shopping.htm" class="active">쇼핑홈</a> <a href="#">카테고리</a>
				<a href="#">베스트</a> <a href="#">오늘의딜</a> <a href="#">단독상품</a> <a
					href="#">집요한세일</a>
			</nav>
			<div style="padding: 8px 0;">
				<jsp:include page="/WEB-INF/views/layout/popular_keyword.jsp" />
			</div>
		</div>
	</div>

	<main class="container">
		<!-- 상단 더블 배너 (하드코딩 유지) -->
		<section class="top-banners">
			<img
				src="https://images.unsplash.com/photo-1556228453-efd6c1ff04f6?w=800&q=80"
				alt="집요한세일 배너" class="banner-img"> <img
				src="https://images.unsplash.com/photo-1490644658840-3f2e3f8c5625?w=800&q=80"
				alt="특별한 플레이트 배너" class="banner-img">
		</section>

		<!-- 카테고리 영역 (아이콘 하드코딩 유지) -->
		<section class="category-section">
			<h2 class="category-title">카테고리</h2>
			<div class="category-grid">
				<div class="category-item">
					<div class="category-icon">🏷️</div>
					<span class="category-name">집요한세일</span>
				</div>
				<div class="category-item">
					<div class="category-icon">🪑</div>
					<span class="category-name">가구</span>
				</div>
				<div class="category-item">
					<div class="category-icon">🛏️</div>
					<span class="category-name">패브릭</span>
				</div>
				<div class="category-item">
					<div class="category-icon">📺</div>
					<span class="category-name">가전·디지털</span>
				</div>
				<div class="category-item">
					<div class="category-icon">🍳</div>
					<span class="category-name">주방용품</span>
				</div>
				<div class="category-item">
					<div class="category-icon">🍎</div>
					<span class="category-name">식품</span>
				</div>
				<div class="category-item">
					<div class="category-icon">🪴</div>
					<span class="category-name">데코·식물</span>
				</div>
				<div class="category-item">
					<div class="category-icon">💡</div>
					<span class="category-name">조명</span>
				</div>
				<div class="category-item">
					<div class="category-icon">📦</div>
					<span class="category-name">수납·정리</span>
				</div>
				<div class="category-item">
					<div class="category-icon">🧼</div>
					<span class="category-name">생활용품</span>
				</div>
			</div>
		</section>

		<section class="recommend-section">
			<h2 class="recommend-title">추천상품</h2>

			<div class="grid-4">
				<c:forEach var="product" items="${randomProductList}">
					<a href="/productDetail.htm?product_id=${product.productId}"
						class="product-card">
						<div class="product-img-wrap">
							<img src="${product.imageUrl}" alt="${product.productName}">
						</div>
						<div class="brand-name">${product.brandName}</div>
						<div class="product-name">${product.productName}</div>
						<div class="price-area">
							<c:if test="${product.discountRate > 0}">
								<span class="discount">${product.discountRate}%</span>
							</c:if>
							<span class="price"><fmt:formatNumber
									value="${product.price}" pattern="#,###" /></span>
						</div>
						<div class="review-area">
							<span class="star">★</span> 4.8 리뷰 1,200
						</div>
					</a>
				</c:forEach>

				<c:if test="${empty randomProductList}">
					<div
						style="grid-column: span 4; text-align: center; padding: 50px 0; color: #757575;">
						등록된 추천 상품이 없습니다.</div>
				</c:if>
			</div>
		</section>
	</main>

	<jsp:include page="../layout/footer.jsp" />

</body>
</html>
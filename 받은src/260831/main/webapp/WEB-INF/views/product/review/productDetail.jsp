<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<!-- 탭 메뉴 영역 -->
<ul class="nav-tabs">
    <li onclick="loadTab('info')">상품정보</li>
    <li class="active" onclick="loadTab('review')">리뷰 <span id="total-review-count">${product.reviewCount}</span></li>
    <li onclick="loadTab('qna')">문의</li>
</ul>

<!-- 리뷰 탭 내용이 동적으로 로드될 컨테이너 -->
<div id="review-tab-content">
    <!-- 기본적으로 서버사이드 include를 해두거나 AJAX로 로드 -->
    <jsp:include page="reviewList.jsp" />
</div>

<script>
// 정렬, 페이징, 필터링 시 이 함수를 호출해 reviewList.jsp 영역만 갱신
function fetchReviewList(page = 1, sort = 'best', optionId = '') {
    const productId = "${product.productId}";
    
    fetch(`/ohouse/review/list.do?productId=${productId}&page=${page}&sort=${sort}&optionId=${optionId}`)
        .then(response => response.text()) // HTML 조각 수령
        .then(html => {
            document.getElementById("review-tab-content").innerHTML = html;
        });
}
</script>
</body>
</html>
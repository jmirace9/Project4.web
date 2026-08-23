## 디스패쳐 분석
- urlMappingPath=this.getInitParameter("urlMappingPath") -> web.xml의 init-param/param-name(urlMappingPath),param-value(/WEB-INF/commandHandler.properties)
 ㄴ commandHandler.properties 파일을 읽어서 요청url과 handler의 관계를 정의한다.

- realPath = this.getServletContext().getRealPath(urlMappingPath);
 ㄴ properties파일의 컴퓨터에서의 실제 물리 경로 ( C:/.../.../ohPro/src/main/webapp/WEB-INF/views/commandHandler.properties)

- Properties p = new Properties();
try(FileReader reader = new FileReader(realPath) ){
    p.load(reader)      // java.properties의 load함수 
}                       
// realPath(실제 properties파일의 위치)를 담은 FileReader의 reader변수를 Properties 변수 p에 properties함수 load실행할때 매개변수로 담는다 (고로, Reader를 통해 properties 형식의 텍스트를 읽어서 Properties 객체 안에 key-value 형태로 저장한다.)

// Properties p -> commandHandlerMap 저장
		Set<Entry<Object, Object>> set =  p.entrySet();
		Iterator<Entry<Object, Object>> ir = set.iterator();
		
		while (ir.hasNext()) {
         Entry<Object, Object> entry = ir.next();
         String url = (String) entry.getKey();
         String fullName = (String) entry.getValue();

- Class<?> commandHandlerClass = class.forName(fullName);

### 260820 
category.jsp 활용중

com.ohouse.common.jdbc 추가
    ㄴ JdbcUtil.java

com.ohouse.shopping 패키지 쪽추가
com.ohouse.shopping.command -> CategoryHandler
com.ohouse.shopping.dao -> CategoryDAO,CategoryDAOImple
com.ohouse.shopping.dto -> CategoryDTO
com.ohouse.shopping.service -> CategoryService

우리 dispathcerServlet 확인

http://localhost:8080/ohPro/store/category.htm 로 연결

CategoryHandler
       ↓
CategoryService
       ↓
CategoryDAO ← interface
       ↓
CategoryDAOImpl

boardPro 그림으로 요청(한눈에 구조파악)

프로젝트때 맡은 파트를 다른 css등 코딩없는 빈 jsp에서 하고 옮겨보기
    ㄴ 프로젝트의 큰구조와 내가맡은 구조 정확히 먼저 파악하기
    ㄴ 확장성 좋은 코딩,유지보수 용이, 약한 결합 코딩, 하드코딩x  

### 260821

대분류 [가구] 중분류 [침대]
소분류 [침대프레임] = https://ohou.se/store/category?category_id=10120001
소분류 [침대+매트리스] = https://ohou.se/store/category?category_id=10120002
소분류 [침대부속가구] = https://ohou.se/store/category?category_id=10120003

대분류 [가구] 중분류 [매트리스/토퍼]
소분류 [매트리스] = https://ohou.se/store/category?category_id=10130001
소분류 [토퍼] = https://ohou.se/store/category?category_id=10130002

대분류 [가구] 중분류 [테이블/식탁/책상]
소분류 [거실/소파테이블] = https://ohou.se/store/category?category_id=10150001
소분류 [사이드테이블] = https://ohou.se/store/category?category_id=10150002
소분류 [식탁] = https://ohou.se/store/category?category_id=10150003
-------------------------------------------------------------------------------------------
대분류 [주방용품] 중분류 [그릇/식기]
소분류 [홈세트] = https://ohou.se/store/category?category_id=16220001
소분류 [공기/대접] = https://ohou.se/store/category?category_id=16220002
소분류 [접시/플레이트] = https://ohou.se/store/category?category_id=16220003

대분류 [주방용품] 중분류 [냄비/프라이팬/솥]
소분류 [냄비/프라이팬세트] = https://ohou.se/store/category?category_id=16230001
소분류 [냄비/뚝배기] = https://ohou.se/store/category?category_id=16230002
소분류 [압력솥/찜솥] = https://ohou.se/store/category?category_id=16230003

대분류 [주방용품] 중분류 [컵/잔/텀블러]
소분류 [머그컵] = https://ohou.se/store/category?category_id=16240001
소분류 [유리컵/물컵] = https://ohou.se/store/category?category_id=16240002
소분류 [텀블러/빨대/컵소품] = https://ohou.se/store/category?category_id=16240003
-------------------------------------------------------------------------------------------
대분류 [수납/정리] 중분류 [서랍장/트롤리]
소분류 [플라스틱서랍장] = https://ohou.se/store/category?category_id=13050002
소분류 [트롤리/이동식선반] = https://ohou.se/store/category?category_id=13050003
소분류 [공간박스] = https://ohou.se/store/category?category_id=13050004

대분류 [수납/정리] 중분류 [리빙박스/수납함]
소분류 [수납박스/리빙박스] = https://ohou.se/store/category?category_id=13140006
소분류 [팬트정리함] = https://ohou.se/store/category?category_id=13140007
소분류 [약/구급정리함] = https://ohou.se/store/category?category_id=13140008

대분류 [수납/정리] 중분류 [행거]
소분류 [스탠드행거] = https://ohou.se/store/category?category_id=13020002
소분류 [이동식행거] = https://ohou.se/store/category?category_id=13020003
소분류 [고정식행거] = https://ohou.se/store/category?category_id=13020004

- jquery스크립트 header에 추가

### 260824

소분류 클릭 → GET으로 category_id 전달 → category.htm 재요청 → 좌측 사이드바에서 클릭한 소분류만 포커스 표시

오른쪽 상품 영역은 아직 구현하지 않음.


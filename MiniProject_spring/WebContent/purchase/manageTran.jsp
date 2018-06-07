<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>

<html lang="ko">
<head>
<meta charset="EUC-KR">
	
	<!-- 참조 : http://getbootstrap.com/css/   참조 -->
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	
	<!--  ///////////////////////// Bootstrap, jQuery CDN ////////////////////////// -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
	
	
	<!-- Bootstrap Dropdown Hover CSS -->
   <link href="/css/animate.min.css" rel="stylesheet">
   <link href="/css/bootstrap-dropdownhover.min.css" rel="stylesheet">
    <!-- Bootstrap Dropdown Hover JS -->
   <script src="/javascript/bootstrap-dropdownhover.min.js"></script>
   
   <style>
	  body {
            padding-top : 50px;
        }
    </style>
	<script type="text/javascript">
		// 검색 / page 두가지 경우 모두 Form 전송을 위해 JavaScrpt 이용  
		function fncGetList(currentPage) {
			$("#currentPage").val(currentPage);
	   		$("form").attr("method", "POST").attr("action", "/purchase/listManageTran").submit();		
		}
		
		//============= "검색"  Event  처리 =============	
		 $(function() {
			 //==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
			$( "button.btn.btn-default" ).on("click" , function() {
				fncGetList(1);
			});
		 });
		
		//============= 상품소팅 처리부분 =============
		$(function(){
			$( ".sort:contains('최근등록순')" ).on("click" , function() {
				self.location = "/purchase/listPurchase?prodSort=0&menu=manage";
			 });
				
			$( ".sort:contains('낮은가격순')" ).on("click" , function() {
				self.location = "/purchase/listPurchase?prodSort=1&menu=manage";
			 });
				
			$( ".sort:contains('높은가격순')" ).on("click" , function() {
				self.location = "/purchase/listPurchase?prodSort=2&menu=manage";
			 });
		});
	
	$(function(){
		$( ".tranInfo:contains('배송하기')" ).on("click" , function() {
			var prodNo = $(".prodNo").val();
			alert("prodNo" + prodNo);
			self.location = "/purchase/updateTranCodeByProd?prodNo="+prodNo+"&tranCode=2&menu=manage";
		 });
	});
</script>
</head>

<body>

	<!-- ToolBar Start /////////////////////////////////////-->
	<jsp:include page="/layout/toolbar.jsp" />
   	<!-- ToolBar End /////////////////////////////////////-->
   	
   	<div class="container">
   		
   		<div class="page-header text-info">
	       <h3>배송관리</h3>
	    </div>
	    
	    <div class="row">
	    	
	    	<div class="col-md-6 text-left">
		    	<p class="text-primary">
		    		전체  ${resultPage.totalCount } 건수, 현재 ${resultPage.currentPage}  페이지
		    	</p>
		    </div>
		    
		    <div class="col-md-6 text-right">
			    <form class="form-inline" name="detailForm">
			    
				  <div class="form-group">
				    <select class="form-control" name="searchCondition" >
						<option value="0"  ${ ! empty search.searchCondition && search.searchCondition==0 ? "selected" : "" }>상품번호</option>
						<option value="1"  ${ ! empty search.searchCondition && search.searchCondition==1 ? "selected" : "" }>상품명</option>
						<option value="2"  ${ ! empty search.searchCondition && search.searchCondition==2 ? "selected" : "" }>상품가격</option>
					</select>
				  </div>
				  
				  <div class="form-group">
				    <label class="sr-only" for="searchKeyword">검색어</label>
				    <input type="text" class="form-control" id="searchKeyword" name="searchKeyword"  placeholder="검색어"
				    			 value="${! empty search.searchKeyword ? search.searchKeyword : '' }"  >
				  </div>
				  
				  <button type="button" class="btn btn-default">검색</button>
				  
				  <!-- Single button -->
				<div class="btn-group">
					<button type="button" class="btn btn-primary dropdown-toggle"
						data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
						최근등록순 <span class="caret"></span>
					</button>
					<ul class="dropdown-menu sort">
						<li><a href="#">최근등록순</a></li>
						<li><a href="#">낮은가격순</a></li>
						<li><a href="#">높은가격순</a></li>
						<input type="hidden" name="prodSort"  value="${search.prodSort}" class="ct_input_g" style="width:200px; height:19px" />
					</ul>
				</div>
			
				  <!-- PageNavigation 선택 페이지 값을 보내는 부분 -->
				  <input type="hidden" id="currentPage" name="currentPage" value=""/>
				  
			    </form>				  
			</div>
			
			<table class="table table-hover table-striped">

			<thead>
				<tr>
					<th align="center">No</th>					
					<th align="left">배송번호</th>
					<th align="left">상품번호</th>
					<th align="left">구매수량</th>
					<th align="left">회원ID</th>
					<th align="left">회원이름</th>
					<th align="left">배송상태</th>
				</tr>
			</thead>
			
			<tbody>
				<c:set var="i" value="0" />
				<c:forEach var="purchase" items="${list}">
					<c:set var="i" value="${ i+1 }" />
					<tr>
						<td align="center">${ i }</td>
						<td align="left"  class="tranNo" title="Click : 상품정보 확인">${purchase.tranNo}</td>
						<td align="left" >
							${purchase.purchaseProd.prodNo}
							<input type="hidden" value="${purchase.purchaseProd.prodNo}" class="prodNo"/>
						</td>
						<td align="left">${purchase.quantity}</td>
						<td align="left">${purchase.buyer.userId}</td>
						<td align="left">${purchase.receiverName}</td>
						<td align="left"  class="tranInfo">
							<c:choose>
								<c:when test="${purchase.tranCode.trim() == '1' }">
									구매완료
									[배송하기]
								</c:when>
								<c:when test="${purchase.tranCode.trim() == '2' }">
									배송중
								</c:when>
								<c:otherwise>
									배송완료
								</c:otherwise>
							</c:choose>
						</td>
					</tr>
				</c:forEach>
			</tbody>
			
			</table>
			
	    </div>
	    
	    <!-- PageNavigation Start... -->
		<jsp:include page="../common/pageNavigator_new.jsp"/>
		<!-- PageNavigation End... -->
   	
</body>
</html>

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
		   	$("form").attr("method", "POST").attr("action", "/purchase/listPurchase").submit();		
		} 
		
		$(function(){
			//구매번호->구매정보
			$(".tranNo").on("click", function(){
				var tranNo = $(this).text().trim();
				alert("tranNo===="+tranNo);
				self.location = "/purchase/getPurchase?tranNo=" + tranNo;
			});
			
			//유저아이디->유저정보
			$(".userId").on("click", function(){
				var userId = $(this).text().trim();
				alert("userId===="+userId);
				self.location = "/user/getUser?userId=" + userId;
			});
			
			//물건도착시이동
			$( ".tranInfo:contains('물건도착')" ).on("click" , function() {
				var tranNo = $(".tranNo").val();
				alert("tranNo" + tranNo);
				self.location = "/purchase/updateTranCode?tranNo="+ tranNo +"&tranCode=3";
			 });
			
			$(function(){
				
				$( "td:nth-child(2)" ).css("color" , "red");
				
				//==> 아래와 같이 정의한 이유는 ??
				$(".ct_list_pop:nth-child(4n+6)" ).css("background-color" , "whitesmoke");
			
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
	       <h3>구매목록조회</h3>
	    </div>
	    
	     <div class="row">
	    
		    <div class="col-md-6 text-left">
		    	<p class="text-primary">
		    		전체  ${resultPage.totalCount } 건수, 현재 ${resultPage.currentPage}  페이지
		    	</p>
		    </div>
		    
		    <form class="form-inline" name="detailForm">
			    <!-- PageNavigation 선택 페이지 값을 보내는 부분 -->
				<input type="hidden" id="currentPage" name="currentPage" value=""/>
			</form>
			
	     </div>		    
		 
		 <table class="table table-hover table-striped">

			<thead>
				<tr>
					<th align="center">No</th>					
					<th align="left">구매번호</th>
					<th align="left">상품번호</th>
					<th align="left">회원ID</th>
					<th align="left">회원명</th>
					<th align="left">전화번호</th>
					<th align="left">배송현황</th>
					<th align="left"></th>
				</tr>
			</thead>
			
			<tbody>
				<c:set var="i" value="0" />
				<c:forEach var="pur" items="${list}">
					<c:set var="i" value="${ i+1 }" />
					<tr>
						<td align="center">${ i }</td>
						<td align="left" title="Click : 상품정보 확인">
							${pur.tranNo}
							<input type="hidden" name="tranNo" class="tranNo" value="${pur.tranNo}" />
						</td>
						<td align="left" >${pur.purchaseProd.prodNo}</td>
						<td align="left"  class="userId">${pur.buyer.userId}</td>
						<td align="left">${pur.receiverName}</td>
						<td align="left">${pur.receiverPhone}</td>
						<td align="left">
							<c:choose>
								<c:when test="${pur.tranCode.trim() == '1'}">
								현재 구매완료 상태 입니다.
								</c:when>
								<c:when test="${pur.tranCode.trim() == '2'}">
								현재 배송중 상태 입니다.
								</c:when>
								<c:otherwise>
								현재 배송완료 상태 입니다.
								</c:otherwise>
							</c:choose>
						</td>
						<td align="left" class="tranInfo">
							<c:if test="${pur.tranCode.trim() == '2'}">
								[물건도착]
							</c:if>
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
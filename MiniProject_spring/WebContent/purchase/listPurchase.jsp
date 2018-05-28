<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
<title>구매 목록조회</title>

<link rel="stylesheet" href="/css/admin.css" type="text/css">

<!-- CDN(Content Delivery Network) 호스트 사용 -->
<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
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
		$( "td.tranInfo:contains('물건도착')" ).on("click" , function() {
			var tranNo = $(".tranNo").text().trim();
			alert("tranNo" + tranNo);
			self.location = "/purchase/updateTranCode?tranNo="+ tranNo +"&tranCode=3";
		 });
		
		$(function(){
			
			$( ".ct_list_pop td:nth-child(5)" ).css("color" , "red");
			$("h7").css("color" , "red");
			
			//==> 아래와 같이 정의한 이유는 ??
			$(".ct_list_pop:nth-child(4n+6)" ).css("background-color" , "whitesmoke");
		
		});
		
	});
</script>
</head>

<body bgcolor="#ffffff" text="#000000">

<div style="width: 98%; margin-left: 10px;">

<form name="detailForm">

<table width="100%" height="37" border="0" cellpadding="0"	cellspacing="0">
	<tr>
		<td width="15" height="37"><img src="/images/ct_ttl_img01.gif"width="15" height="37"></td>
		<td background="/images/ct_ttl_img02.gif" width="100%" style="padding-left: 10px;">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="93%" class="ct_ttl01">구매 목록조회</td>
				</tr>
			</table>
		</td>
		<td width="12" height="37"><img src="/images/ct_ttl_img03.gif"	width="12" height="37"></td>
	</tr>
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0"	style="margin-top: 10px;">
	<tr>
		<td colspan="11" >
			전체 ${resultPage.totalCount} 건수,	현재 ${resultPage.currentPage} 페이지
		</td>
	</tr>
	<tr>
		<td class="ct_list_b" width="100">No</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">구매번호</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">상품번호</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">회원ID</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">회원명</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">전화번호</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b">배송현황</td>
		<td class="ct_line02"></td>
	</tr>
	<tr>
		<td colspan="11" bgcolor="808285" height="1"></td>
	</tr>

	<c:set var="i" value="0" />
	<c:forEach var="pur" items="${list}">
	<c:set var="i" value="${ i+1 }" />
	<tr class="ct_list_pop">
		<td align="center">
			${ i }
		</td>
		<td></td>
		<td align="left" class="tranNo">
			${pur.tranNo}
		</td>
		<td></td>
		<td align="left">
			${pur.purchaseProd.prodNo}
		</td>
		<td></td>
		<td align="left" class="userId">
			${pur.buyer.userId}
		</td>
		<td></td>
		<td align="left">${pur.receiverName}</td>
		<td></td>
		<td align="left">${pur.receiverPhone}</td>
		<td></td>
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
		<td></td>
		<td align="left" class="tranInfo">
			<c:if test="${pur.tranCode.trim() == '2'}">
				[물건도착]
			</c:if>
		</td>
	</tr>
	<tr>
		<td colspan="11" bgcolor="D6D7D6" height="1"></td>
	</tr>
	</c:forEach>
		
</table>

<!-- PageNavigation Start... -->
<table width="100%" border="0" cellspacing="0" cellpadding="0"	style="margin-top:10px;">
	<tr>
		<td align="center">
		   <input type="hidden" id="currentPage" name="currentPage" value=""/>
		   <jsp:include page="../common/pageNavigator.jsp"/>
    	</td>
	</tr>
</table>

<!-- PageNavigation End... -->
</form>

</div>

</body>
</html>
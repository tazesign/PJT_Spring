<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
<title>배송관리</title>

<link rel="stylesheet" href="/css/admin.css" type="text/css">

<script type="text/javascript">
	// 검색 / page 두가지 경우 모두 Form 전송을 위해 JavaScrpt 이용  
	function fncGetList(currentPage) {
		document.getElementById("currentPage").value = currentPage;
	   	document.detailForm.submit();		
	}
</script>
</head>

<body bgcolor="#ffffff" text="#000000">

<div style="width:98%; margin-left:10px;">

<form name="detailForm" action="/purchase/listManageTran" method="post">

<table width="100%" height="37" border="0" cellpadding="0"	cellspacing="0">
	<tr>
		<td width="15" height="37">
			<img src="/images/ct_ttl_img01.gif" width="15" height="37"/>
		</td>
		<td background="/images/ct_ttl_img02.gif" width="100%" style="padding-left:10px;">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="93%" class="ct_ttl01">	배송관리
					
					</td>
				</tr>
			</table>
		</td>
		<td width="12" height="37">
			<img src="/images/ct_ttl_img03.gif" width="12" height="37"/>
		</td>
	</tr>
</table>


<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
	<tr>
		<c:choose>
			<c:when test="${search.searchCondition != null}">

			<td align="right">
				<select name="searchCondition" class="ct_input_g" style="width:80px">
				
				<c:choose>
					<c:when test="${search.searchCondition == 0 }">
						<option value="0" selected>상품번호</option>
						<option value="1">상품명</option>
						<option value="2">상품가격</option>
					</c:when>
					<c:when test="${search.searchCondition == 1 }">
						<option value="0">상품번호</option>
						<option value="1" selected>상품명</option>
						<option value="2">상품가격</option>
						</c:when>
					<c:otherwise>
						<option value="0">상품번호</option>
						<option value="1">상품명</option>
						<option value="2" selected>상품가격</option>
					</c:otherwise>
				</c:choose>
				
				</select>
				<input type="text" name="searchKeyword" value="${search.searchKeyword}"class="ct_input_g" style="width:200px; height:19px" />
			</td>
			</c:when>
			<c:otherwise>
			<td align="right">
				<select name="searchCondition" class="ct_input_g" style="width:80px">
					<option value="0" selected>상품번호</option>
					<option value="1">상품명</option>
					<option value="2">상품가격</option>
				</select>
				<input type="text" name="searchKeyword"  class="ct_input_g" style="width:200px; height:19px" />
			</td>
			</c:otherwise>	
		</c:choose>
	
		<td align="right" width="70">
			<table border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="17" height="23">
						<img src="/images/ct_btnbg01.gif" width="17" height="23"/>
					</td>
					<td background="/images/ct_btnbg02.gif" class="ct_btn01" style="padding-top:3px;">
						<a href="javascript:fncGetList('1');">검색</a>
					</td>
					<td width="14" height="23">
						<img src="/images/ct_btnbg03.gif" width="14" height="23"/>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>


<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
	<tr>
		<td colspan="11" >
			전체 ${resultPage.totalCount} 건수,	현재 ${resultPage.currentPage} 페이지
			<span align="right">
			<a href="/purchase/listPurchase?prodSort=0&menu=manage">최근등록순</a>
			<a href="/purchase/listPurchase?prodSort=1&menu=manage">낮은가격순</a>
			<a href="/purchase/listPurchase?prodSort=2&menu=manage">높은가격순</a>
			<input type="hidden" name="prodSort"  value="${search.prodSort}" class="ct_input_g" style="width:200px; height:19px" />
			</span>
		</td>
	</tr>
	<tr>
		<td class="ct_list_b" width="100">No</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="100">배송No</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">상품No</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="100">구매수량</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">회원아이디</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b">회원이름</td>	
		<td class="ct_line02"></td>
		<td class="ct_list_b">배송상태</td>	
	</tr>
	<tr>
		<td colspan="11" bgcolor="808285" height="1"></td>
	</tr>
		
	<c:set var="i" value="0" />
	<c:forEach var="purchase" items="${list}">
	<c:set var="i" value="${ i+1 }" />
	<tr class="ct_list_pop">
		<td align="center">${ i }</td>
		<td></td>
		<td align="left">${purchase.tranNo}</td>
		<td></td>
		<td align="left">${purchase.purchaseProd.prodNo}</td>
		<td></td>
		<td align="left">${purchase.quantity}</td>
		<td></td>
		<td align="left">${purchase.buyer.userId}</td>
		<td></td>
		<td align="left">${purchase.receiverName}</td>
		<td></td>
		<td align="left">
			<c:choose>
				<c:when test="${purchase.tranCode.trim() == '1' }">
					구매완료
					<a href="/purchase/updateTranCodeByProd?prodNo=${purchase.purchaseProd.prodNo}&tranCode=2&menu=manage">배송하기</a>
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
	<tr>
		<td colspan="11" bgcolor="D6D7D6" height="1"></td>
	</tr>	
	</c:forEach>
	
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
	<tr>
		<td align="center">
		   <input type="hidden" id="currentPage" name="currentPage" value=""/>
		   <jsp:include page="../common/pageNavigator.jsp"/>
    	</td>
	</tr>
</table>


<!--  페이지 Navigator 끝 -->

</form>

</div>
</body>
</html>

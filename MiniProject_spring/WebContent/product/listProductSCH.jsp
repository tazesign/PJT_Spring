<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<html>
<head>
<title>상품 목록조회</title>

<link rel="stylesheet" href="/css/admin.css" type="text/css">

<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
<script type="text/javascript">
	// 검색 / page 두가지 경우 모두 Form 전송을 위해 JavaScrpt 이용  
	function fncGetList(currentPage) {
		$("#currentPage").val(currentPage);
	   	$("form").attr("method", "POST").attr("action", "/product/listProduct?menu=search").submit();		
	}
	
	$(function(){
		
		$( "td.ct_btn01:contains('검색')" ).on("click" , function() {
			fncGetList(1);
		 });
		
		$( "td.sort span:contains('최근등록순')" ).on("click" , function() {
			self.location = "/product/listProduct?prodSort=0&menu=search";
		 });
		
		$( "td.sort span:contains('낮은가격순')" ).on("click" , function() {
			self.location = "/product/listProduct?prodSort=1&menu=search";
		 });
		
		$( "td.sort span:contains('높은가격순')" ).on("click" , function() {
			self.location = "/product/listProduct?prodSort=2&menu=search";
		 });
		
		//리스트
		$(".prodName").on("click", function(){
			var index = $(".prodName").index(this);
			var prodNo = $($(".prodNo")[index]).val();
			var quantity = $($(".quantity")[index]).val();
			alert("quantity" + quantity)
			if(quantity>=1){
				location.href="/product/getProduct?prodNo=" + prodNo + "&menu=search";				
			}else{
				alert("상품재고가 없습니다.")
			}
		});
		
	});
</script>
</head>

<body bgcolor="#ffffff" text="#000000">

<div style="width:98%; margin-left:10px;">

<form name="detailForm">

<table width="100%" height="37" border="0" cellpadding="0"	cellspacing="0">
	<tr>
		<td width="15" height="37">
			<img src="/images/ct_ttl_img01.gif" width="15" height="37"/>
		</td>
		<td background="/images/ct_ttl_img02.gif" width="100%" style="padding-left:10px;">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="93%" class="ct_ttl01">	상품 목록조회
					
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
						검색
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
		<td colspan="5">
			전체 ${resultPage.totalCount} 건수,	현재 ${resultPage.currentPage} 페이지
		<td>
		<td class="sort" align="right">
			<span>최근등록순</span>
			<span>낮은가격순</span>
			<span>높은가격순</span>
			<input type="hidden" name="prodSort"  value="${search.prodSort}" class="ct_input_g" style="width:200px; height:19px" />
		</td>
	</tr>
	<tr>
		<td class="ct_list_b" width="100">No</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="200">상품명</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b">가격</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b">등록일</td>	
		<td class="ct_line02"></td>
		<td class="ct_list_b">현재상태</td>
		<td class="ct_list_b">상품수량</td>
		<td class="ct_line02"></td>
	</tr>
	<tr>
		<td colspan="11" bgcolor="808285" height="1"></td>
	</tr>
	
	<c:set var="i" value="0" />
	<c:forEach var="pro" items="${list}">
	<c:set var="i" value="${ i+1 }" />
	<tr class="ct_list_pop">
		<td align="center">${ i }</td>
		<td></td>
		<td align="left" class="prodName">
			${pro.prodName}
			<input type="hidden" value="${pro.prodNo}" class="prodNo"/>
		</td>
		<td></td>
		<td align="left">${pro.price}</td>
		<td></td>
		<td align="left">${pro.manuDate}</td>
		<td></td>
		<td align="left">
			<c:choose>
				<c:when test="${pro.quantity >= 1}">
				판매중
				</c:when>
				<c:otherwise>
				재고 없음
				</c:otherwise>
			</c:choose>
		</td>
		<td align="left" >${pro.quantity}</td>
		<input type="hidden" value="${pro.quantity}" class="quantity"/>
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

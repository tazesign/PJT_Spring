<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
<title>���� �����ȸ</title>

<link rel="stylesheet" href="/css/admin.css" type="text/css">

<script type="text/javascript">
	// �˻� / page �ΰ��� ��� ��� Form ������ ���� JavaScrpt �̿�  
	function fncGetList(currentPage) {
		document.getElementById("currentPage").value = currentPage;
	   	document.detailForm.submit();		
	}
</script>
</head>

<body bgcolor="#ffffff" text="#000000">

<div style="width: 98%; margin-left: 10px;">

<form name="detailForm" action="/listPurchase.do" method="post">

<table width="100%" height="37" border="0" cellpadding="0"	cellspacing="0">
	<tr>
		<td width="15" height="37"><img src="/images/ct_ttl_img01.gif"width="15" height="37"></td>
		<td background="/images/ct_ttl_img02.gif" width="100%" style="padding-left: 10px;">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="93%" class="ct_ttl01">���� �����ȸ</td>
				</tr>
			</table>
		</td>
		<td width="12" height="37"><img src="/images/ct_ttl_img03.gif"	width="12" height="37"></td>
	</tr>
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0"	style="margin-top: 10px;">
	<tr>
		<td colspan="11" >
			��ü ${resultPage.totalCount} �Ǽ�,	���� ${resultPage.currentPage} ������
		</td>
	</tr>
	<tr>
		<td class="ct_list_b" width="100">No</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">��ǰ��</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">ȸ��ID</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">ȸ����</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b">��ȭ��ȣ</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b">�����Ȳ</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b">��������</td>
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
		<td align="left">
			<a href="/getPurchase.do?tranNo=${pur.tranNo}">${pur.tranNo}</a>
		</td>
		<td></td>
		<td align="left">
			<a href="/getUser.do?userId=${pur.buyer.userId}">${pur.buyer.userId}</a>
		</td>
		<td></td>
		<td align="left">${pur.receiverName}</td>
		<td></td>
		<td align="left">${pur.receiverPhone}</td>
		<td></td>
		<td align="left">
			<c:choose>
				<c:when test="${pur.tranCode.trim() == '1'}">
				���� ���ſϷ� ���� �Դϴ�.
				</c:when>
				<c:when test="${pur.tranCode.trim() == '2'}">
				���� ����� ���� �Դϴ�.
				</c:when>
				<c:otherwise>
				���� ��ۿϷ� ���� �Դϴ�.
				</c:otherwise>
			</c:choose>
		</td>
		<td></td>
		<td align="left">
			<c:if test="${pur.tranCode.trim() == '2'}">
				<a href="/updateTranCode.do?tranNo=${pur.tranNo}&tranCode=3">���ǵ���</a>
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
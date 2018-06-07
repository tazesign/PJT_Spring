<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>

<html lang="ko">
<head>
<meta charset="EUC-KR">
	
	<!-- ���� : http://getbootstrap.com/css/   ���� -->
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
		// �˻� / page �ΰ��� ��� ��� Form ������ ���� JavaScrpt �̿�  
		function fncGetList(currentPage) {
			$("#currentPage").val(currentPage);
		   	$("form").attr("method", "POST").attr("action", "/purchase/listPurchase").submit();		
		} 
		
		$(function(){
			//���Ź�ȣ->��������
			$(".tranNo").on("click", function(){
				var tranNo = $(this).text().trim();
				alert("tranNo===="+tranNo);
				self.location = "/purchase/getPurchase?tranNo=" + tranNo;
			});
			
			//�������̵�->��������
			$(".userId").on("click", function(){
				var userId = $(this).text().trim();
				alert("userId===="+userId);
				self.location = "/user/getUser?userId=" + userId;
			});
			
			//���ǵ������̵�
			$( ".tranInfo:contains('���ǵ���')" ).on("click" , function() {
				var tranNo = $(".tranNo").val();
				alert("tranNo" + tranNo);
				self.location = "/purchase/updateTranCode?tranNo="+ tranNo +"&tranCode=3";
			 });
			
			$(function(){
				
				$( "td:nth-child(2)" ).css("color" , "red");
				
				//==> �Ʒ��� ���� ������ ������ ??
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
	       <h3>���Ÿ����ȸ</h3>
	    </div>
	    
	     <div class="row">
	    
		    <div class="col-md-6 text-left">
		    	<p class="text-primary">
		    		��ü  ${resultPage.totalCount } �Ǽ�, ���� ${resultPage.currentPage}  ������
		    	</p>
		    </div>
		    
		    <form class="form-inline" name="detailForm">
			    <!-- PageNavigation ���� ������ ���� ������ �κ� -->
				<input type="hidden" id="currentPage" name="currentPage" value=""/>
			</form>
			
	     </div>		    
		 
		 <table class="table table-hover table-striped">

			<thead>
				<tr>
					<th align="center">No</th>					
					<th align="left">���Ź�ȣ</th>
					<th align="left">��ǰ��ȣ</th>
					<th align="left">ȸ��ID</th>
					<th align="left">ȸ����</th>
					<th align="left">��ȭ��ȣ</th>
					<th align="left">�����Ȳ</th>
					<th align="left"></th>
				</tr>
			</thead>
			
			<tbody>
				<c:set var="i" value="0" />
				<c:forEach var="pur" items="${list}">
					<c:set var="i" value="${ i+1 }" />
					<tr>
						<td align="center">${ i }</td>
						<td align="left" title="Click : ��ǰ���� Ȯ��">
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
						<td align="left" class="tranInfo">
							<c:if test="${pur.tranCode.trim() == '2'}">
								[���ǵ���]
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
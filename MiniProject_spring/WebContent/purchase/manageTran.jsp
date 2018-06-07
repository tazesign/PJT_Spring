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
	   		$("form").attr("method", "POST").attr("action", "/purchase/listManageTran").submit();		
		}
		
		//============= "�˻�"  Event  ó�� =============	
		 $(function() {
			 //==> DOM Object GET 3���� ��� ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
			$( "button.btn.btn-default" ).on("click" , function() {
				fncGetList(1);
			});
		 });
		
		//============= ��ǰ���� ó���κ� =============
		$(function(){
			$( ".sort:contains('�ֱٵ�ϼ�')" ).on("click" , function() {
				self.location = "/purchase/listPurchase?prodSort=0&menu=manage";
			 });
				
			$( ".sort:contains('�������ݼ�')" ).on("click" , function() {
				self.location = "/purchase/listPurchase?prodSort=1&menu=manage";
			 });
				
			$( ".sort:contains('�������ݼ�')" ).on("click" , function() {
				self.location = "/purchase/listPurchase?prodSort=2&menu=manage";
			 });
		});
	
	$(function(){
		$( ".tranInfo:contains('����ϱ�')" ).on("click" , function() {
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
	       <h3>��۰���</h3>
	    </div>
	    
	    <div class="row">
	    	
	    	<div class="col-md-6 text-left">
		    	<p class="text-primary">
		    		��ü  ${resultPage.totalCount } �Ǽ�, ���� ${resultPage.currentPage}  ������
		    	</p>
		    </div>
		    
		    <div class="col-md-6 text-right">
			    <form class="form-inline" name="detailForm">
			    
				  <div class="form-group">
				    <select class="form-control" name="searchCondition" >
						<option value="0"  ${ ! empty search.searchCondition && search.searchCondition==0 ? "selected" : "" }>��ǰ��ȣ</option>
						<option value="1"  ${ ! empty search.searchCondition && search.searchCondition==1 ? "selected" : "" }>��ǰ��</option>
						<option value="2"  ${ ! empty search.searchCondition && search.searchCondition==2 ? "selected" : "" }>��ǰ����</option>
					</select>
				  </div>
				  
				  <div class="form-group">
				    <label class="sr-only" for="searchKeyword">�˻���</label>
				    <input type="text" class="form-control" id="searchKeyword" name="searchKeyword"  placeholder="�˻���"
				    			 value="${! empty search.searchKeyword ? search.searchKeyword : '' }"  >
				  </div>
				  
				  <button type="button" class="btn btn-default">�˻�</button>
				  
				  <!-- Single button -->
				<div class="btn-group">
					<button type="button" class="btn btn-primary dropdown-toggle"
						data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
						�ֱٵ�ϼ� <span class="caret"></span>
					</button>
					<ul class="dropdown-menu sort">
						<li><a href="#">�ֱٵ�ϼ�</a></li>
						<li><a href="#">�������ݼ�</a></li>
						<li><a href="#">�������ݼ�</a></li>
						<input type="hidden" name="prodSort"  value="${search.prodSort}" class="ct_input_g" style="width:200px; height:19px" />
					</ul>
				</div>
			
				  <!-- PageNavigation ���� ������ ���� ������ �κ� -->
				  <input type="hidden" id="currentPage" name="currentPage" value=""/>
				  
			    </form>				  
			</div>
			
			<table class="table table-hover table-striped">

			<thead>
				<tr>
					<th align="center">No</th>					
					<th align="left">��۹�ȣ</th>
					<th align="left">��ǰ��ȣ</th>
					<th align="left">���ż���</th>
					<th align="left">ȸ��ID</th>
					<th align="left">ȸ���̸�</th>
					<th align="left">��ۻ���</th>
				</tr>
			</thead>
			
			<tbody>
				<c:set var="i" value="0" />
				<c:forEach var="purchase" items="${list}">
					<c:set var="i" value="${ i+1 }" />
					<tr>
						<td align="center">${ i }</td>
						<td align="left"  class="tranNo" title="Click : ��ǰ���� Ȯ��">${purchase.tranNo}</td>
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
									���ſϷ�
									[����ϱ�]
								</c:when>
								<c:when test="${purchase.tranCode.trim() == '2' }">
									�����
								</c:when>
								<c:otherwise>
									��ۿϷ�
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

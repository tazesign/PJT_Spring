<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<!DOCTYPE html>

<html lang="ko">
<head>

<meta charset="EUC-KR">
	 <style>
	  body {
            padding-top : 50px;
        }
        
    </style>
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
   
   
   <!-- jQuery UI toolTip ��� CSS-->
  <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
  <!-- jQuery UI toolTip ��� JS-->
  <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
  
 
  
	<script type="text/javascript">
		// �˻� / page �ΰ��� ��� ��� Form ������ ���� JavaScrpt �̿�  
		function fncGetList(currentPage) {
			$("#currentPage").val(currentPage);
		   	$("form").attr("method", "POST").attr("action", "/product/listProduct?menu=search").submit();		
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
			$( ".sort a[href='#']:contains('�ֱٵ�ϼ�')" ).on("click" , function() {
				self.location = "/product/listProduct?prodSort=0&menu=search";
			 });
				
			$( ".sort a[href='#']:contains('�������ݼ�')" ).on("click" , function() {
				self.location = "/product/listProduct?prodSort=1&menu=search";
			 });
				
			$( ".sort a[href='#']:contains('�������ݼ�')" ).on("click" , function() {
				self.location = "/product/listProduct?prodSort=2&menu=search";
			 });
		});
		
		//����Ʈ
		$(function(){
			
			$( "td:nth-child(2)" ).css("color" , "red");
			
			$(".prodName").on("click", function(){
				var index = $(".prodName").index(this);
				var prodNo = $($(".prodNo")[index]).val();
				var quantity = $($(".quantity")[index]).val();
				alert("quantity" + quantity)
				if(quantity>=1){
					location.href="/product/getProduct?prodNo=" + prodNo + "&menu=search";				
				}else{
					alert("��ǰ��� �����ϴ�.")
				}
			});
				
				//ajax�����ޱ�
				$( "td:nth-child(8) > i" ).on("click" , function() {
					var prodNo = $(this).next().val();
					alert("���δ�Ʈ�ѹ�" + prodNo);
					$.ajax(
									{
										url : "/product/json/getProduct/" + prodNo,
										method : "GET",
										dataType : "json",
										headers : {
											"Accept" : "application/json",
											"Content-Type" : "application/json"
										},
										success : function(JSONData , status) {
											alert(status);
											var displayValue = "<h6>"
																		+ "��ǰ�� : "+JSONData.prodName+"<br/>"
																		+ "���� : "+JSONData.price+"<br/>"
																		+ "����� : "+JSONData.manuDate+"<br/>"
																		+ "��ǰ���� : "+JSONData.quantity+"<br/>"
																		+ "</h6>";
											$("h6").remove();
											$("#" + prodNo + "").html(displayValue);
									}
								}
							)
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
	       <h3>�ǸŻ�ǰ�˻�</h3>
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
			  
	    </div>

		<!--  table Start /////////////////////////////////////-->
		<table class="table table-hover table-striped">

			<thead>
				<tr>
					<th class="text-center">No</th>					
					<th class="text-center">��ǰ��</th>
					<th class="text-center">��ǰ�̹���</th>
					<th class="text-center">����</th>
					<th class="text-center">�����</th>
					<th class="text-center">�������</th>
					<th class="text-center">��ǰ����</th>
					<th class="text-center">��������</th>
				</tr>
			</thead>
			
			<tbody>
				<c:set var="i" value="0" />
				<c:forEach var="pro" items="${list}">
					<c:set var="i" value="${ i+1 }" />
					<tr>
						<td align="center"  style="vertical-align:middle">${ i }</td>
						<%-- <td align="left">${pro.prodNo}</td> --%>
						<td align="center" title="Click : ��ǰ���� Ȯ��" class="prodName"  style="vertical-align:middle">
							${pro.prodName} <br/>
							<input type="hidden" value="${pro.prodNo}" class="prodNo"/>
						</td>
						<td align="center">
							<img src="/images/uploadFiles/${pro.fileName}" width="150"/>
						</td>
						<td align="center"  style="vertical-align:middle">${pro.price}</td>
						<td align="center"  style="vertical-align:middle">${pro.manuDate}</td>
						<td align="center"  style="vertical-align:middle">
							<c:choose>
								<c:when test="${pro.quantity >= 1}">
								�Ǹ���
								</c:when>
								<c:otherwise>
								��� ����
								</c:otherwise>
							</c:choose>
						</td>
						<td align="center"  style="vertical-align:middle">
							${pro.quantity}
							<input type="hidden" value="${pro.quantity}" class="quantity"/>
						</td>
						<td align="center"   style="vertical-align:middle">
						  	<i class="glyphicon glyphicon-ok" id= "${pro.prodNo}"></i>
						  	<input type="hidden" value="${pro.prodNo}"/>
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

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
   
   
   <!-- jQuery UI toolTip 사용 CSS-->
  <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
  <!-- jQuery UI toolTip 사용 JS-->
  <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
  
 
  
	<script type="text/javascript">
		// 검색 / page 두가지 경우 모두 Form 전송을 위해 JavaScrpt 이용  
		function fncGetList(currentPage) {
			$("#currentPage").val(currentPage);
		   	$("form").attr("method", "POST").attr("action", "/product/listProduct?menu=search").submit();		
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
			$( ".sort a[href='#']:contains('최근등록순')" ).on("click" , function() {
				self.location = "/product/listProduct?prodSort=0&menu=search";
			 });
				
			$( ".sort a[href='#']:contains('낮은가격순')" ).on("click" , function() {
				self.location = "/product/listProduct?prodSort=1&menu=search";
			 });
				
			$( ".sort a[href='#']:contains('높은가격순')" ).on("click" , function() {
				self.location = "/product/listProduct?prodSort=2&menu=search";
			 });
		});
		
		//리스트
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
					alert("상품재고가 없습니다.")
				}
			});
				
				//ajax정보받기
				$( "td:nth-child(8) > i" ).on("click" , function() {
					var prodNo = $(this).next().val();
					alert("프로덕트넘버" + prodNo);
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
																		+ "상품명 : "+JSONData.prodName+"<br/>"
																		+ "가격 : "+JSONData.price+"<br/>"
																		+ "등록일 : "+JSONData.manuDate+"<br/>"
																		+ "상품수량 : "+JSONData.quantity+"<br/>"
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
	       <h3>판매상품검색</h3>
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
			  
	    </div>

		<!--  table Start /////////////////////////////////////-->
		<table class="table table-hover table-striped">

			<thead>
				<tr>
					<th class="text-center">No</th>					
					<th class="text-center">상품명</th>
					<th class="text-center">상품이미지</th>
					<th class="text-center">가격</th>
					<th class="text-center">등록일</th>
					<th class="text-center">현재상태</th>
					<th class="text-center">상품수량</th>
					<th class="text-center">간략정보</th>
				</tr>
			</thead>
			
			<tbody>
				<c:set var="i" value="0" />
				<c:forEach var="pro" items="${list}">
					<c:set var="i" value="${ i+1 }" />
					<tr>
						<td align="center"  style="vertical-align:middle">${ i }</td>
						<%-- <td align="left">${pro.prodNo}</td> --%>
						<td align="center" title="Click : 상품정보 확인" class="prodName"  style="vertical-align:middle">
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
								판매중
								</c:when>
								<c:otherwise>
								재고 없음
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

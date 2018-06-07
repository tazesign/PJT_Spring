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
	
	<style type="text/css">
	 body {
            padding-top : 50px;
        }
	</style>
		
	<script type="text/javascript">
		
		//============= "구매"  Event 연결 =============
		$(function() {
			$( ".btn-primary:contains('구매')" ).on("click" , function() {
				self.location ="/purchase/addPurchase?prod_no=${product.prodNo}";
			});
		});
		
		//============= "취소"  Event 처리 및  연결 =============
		$(function() {
			//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
			$("a[href='#' ]").on("click" , function() {
				history.go(-1);
			});
		});	
		
		$(function() {
			$( ".btn-primary:contains('확인')" ).on("click" , function() {
				self.location ="/product/listProduct?menu=manage";
			});
		});
		
		$(function(){	 
			 $("form").attr("method", "POST");
		});
		
	</script>

</head>

<body>

<form>

	<!-- ToolBar Start /////////////////////////////////////-->
	<jsp:include page="/layout/toolbar.jsp" />
   	<!-- ToolBar End /////////////////////////////////////-->

	<!--  화면구성 div Start /////////////////////////////////////-->
	<div class="container">
	
		<div class="page-header">
	       <h3 class=" text-info">상품상세조회</h3>
	       <h5 class="text-muted"><strong class="text-danger">상품정보를 </strong>확인하세요.</h5>
	    </div>
	    
	    <div class="row">
	  		<div class="col-xs-4 col-md-2"><strong>상품번호</strong></div>
			<div class="col-xs-8 col-md-4">${product.prodNo}</div>
		</div>
	    
	    <hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>상 품 명</strong></div>
			<div class="col-xs-8 col-md-4">${product.prodName}</div>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2"><strong>상품이미지</strong></div>
			<div class="col-xs-8 col-md-4"><img src="/images/uploadFiles/${product.fileName}" width="200"  /></div>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>상품수량</strong></div>
			<div class="col-xs-8 col-md-4">${product.quantity}</div>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>상품상세정보</strong></div>
			<div class="col-xs-8 col-md-4">${product.prodDetail}</div>
		</div>
	    
	    <hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>제조일자</strong></div>
			<div class="col-xs-8 col-md-4">${product.manuDate}</div>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>가격</strong></div>
			<div class="col-xs-8 col-md-4">${product.price}</div>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>등록일자</strong></div>
			<div class="col-xs-8 col-md-4">${product.regDate}	</div>
		</div>
		
		<hr/>
		
	 </div>

		<c:choose>
			<c:when test="${param.menu == 'search'}">
			
			<div class="form-group">
				<div class="col-sm-offset-4  col-sm-4 text-center">
				<button type="button" class="btn btn-primary"  >구매</button>
					<a class="btn btn-primary btn" href="#" role="button">이전</a>
				</div>
			</div>
			
		</c:when>
		
		<c:otherwise> 
		
			<div class="form-group">
				<div class="col-sm-offset-4  col-sm-4 text-center">
				<button type="button" class="btn btn-primary"  >확인</button>
				</div>
			</div>
			
		</c:otherwise>
		</c:choose>

</form>

</body>
</html>
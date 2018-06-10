<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

    
<!DOCTYPE Html>

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
	<script type="text/javascript" src="../javascript/calendar.js"></script>
	
	<style type="text/css">
	 body > div.container{
        	border: 3px solid #D6CDB7;
            margin-top: 100px;
      }
	</style>

	<script type="text/javascript">
	
	function fncAddPurchase() {
		var prodQuantity = $("#prodQuantity").val();
		var quantity = $("#quantity").val();
		if(parseInt(quantity) > parseInt(prodQuantity)){
			alert("재고수량을 초과할 수 없습니다.");
			return;
		}
		$("form").attr("method", "POST").attr("action", "/purchase/addPurchase").submit();
	}
	
	
	$(function(){
		$("#calendar").on("click", function(){
			show_calendar('document.addPurchase.divyDate', $("input[name='divyDate']").val())
		})
	});

	//============= "구매"  Event 연결 =============
	$(function() {
		$( "button.btn.btn-primary" ).on("click" , function() {
			fncAddPurchase();
		});
	});	
	
	//============= "취소"  Event 처리 및  연결 =============
	$(function() {
		$("a[href='#' ]").on("click" , function() {
			history.go(-1);
		});
	});	
	
	</script>
</head>

<body>

	<!-- ToolBar Start /////////////////////////////////////-->
	<jsp:include page="/layout/toolbar.jsp" />
   	<!-- ToolBar End /////////////////////////////////////-->
   	
   	<div class ="container">
   	
   		<h1 class="bg-primary text-center">상품상세조회</h1>
   		
   		<!-- form Start /////////////////////////////////////-->
		<form class="form-horizontal" name="addPurchase">
			
			<div class="form-group">
				<label for="prodNo" class="col-sm-offset-1 col-sm-3 control-label">상품번호</label>
				<div class="col-sm-4">
					<input type="text" class="form-control" id="prodNo" name="prodNo" value="${product.prodNo}" readonly />
				</div>
			</div>
			
			<div class="form-group">
				<label for="prodName" class="col-sm-offset-1 col-sm-3 control-label">상 품 명</label>
				<div class="col-sm-4">
					<input type="text" class="form-control" id="prodName" name="prodName" value="${product.prodName}" readonly />
				</div>
			</div>
			
			<div class="form-group">
				<label for="prodDetail" class="col-sm-offset-1 col-sm-3 control-label">상품상세정보</label>
				<div class="col-sm-4">
					<input type="text" class="form-control" id="prodDetail" name="prodDetail" value="${product.prodDetail}" readonly />
				</div>
			</div>
			
			<div class="form-group">
				<label for="manuDate" class="col-sm-offset-1 col-sm-3 control-label">제조일자</label>
				<div class="col-sm-4">
					<input type="text" class="form-control" id="manuDate" name="manuDate" value="${product.manuDate}" readonly />
				</div>
			</div>
			
			<div class="form-group">
				<label for="price" class="col-sm-offset-1 col-sm-3 control-label">가격</label>
				<div class="col-sm-4">
					<input type="text" class="form-control" id="price" name="price" value="${product.price}" readonly />
				</div>
			</div>
			
			<div class="form-group">
				<label for="regDate" class="col-sm-offset-1 col-sm-3 control-label">등록일자</label>
				<div class="col-sm-4">
					<input type="text" class="form-control" id="regDate" name="regDate" value="${product.regDate}" readonly />
				</div>
			</div>
			
			<div class="form-group">
				<label for="buyerId" class="col-sm-offset-1 col-sm-3 control-label">구매자아이디</label>
				<div class="col-sm-4">
					<input type="text" class="form-control" id="buyerId" value="${user.userId}" readonly />
					<input type="hidden" name="buyerId" value="${user.userId}" />
				</div>
			</div>
			
			<div class="form-group">
				<label for="paymentOption" class="col-sm-offset-1 col-sm-3 control-label">구매방법</label>
				<div class="col-sm-4">
					 <select class="form-control" name="paymentOption" id="paymentOption">
				  		<option value="1" selected="selected">현금구매</option>
						<option value="2" >신용구매</option>
					</select>
				</div>
			</div>
			
			<div class="form-group">
				<label for="receiverName" class="col-sm-offset-1 col-sm-3 control-label">구매자이름</label>
				<div class="col-sm-4">
					<input type="text" class="form-control" id="receiverName" name="receiverName" value="${user.userName}" />
				</div>
			</div>
			
			<div class="form-group">
				<label for="receiverPhone" class="col-sm-offset-1 col-sm-3 control-label">구매자연락처</label>
				<div class="col-sm-4">
					<input type="text" class="form-control" id="receiverPhone" name="receiverPhone" value="${user.phone}" />
				</div>
			</div>
			
			<div class="form-group">
				<label for="divyAddr" class="col-sm-offset-1 col-sm-3 control-label">구매자주소</label>
				<div class="col-sm-4">
					<input type="text" class="form-control" id="divyAddr" name="divyAddr" value="${user.addr}" />
				</div>
			</div>
			
			<div class="form-group">
				<label for="divyRequest" class="col-sm-offset-1 col-sm-3 control-label">구매요청사항</label>
				<div class="col-sm-4">
					<input type="text" class="form-control" id="divyRequest" name="divyRequest"/>
				</div>
			</div>

			<div class="form-group">
				<label for="divyDate" class="col-sm-offset-1 col-sm-3 control-label">배송희망일자</label>
				<div class="col-sm-4">
					<input type="text" class="form-control" id="divyDate" name="divyDate" readonly>
				</div>
				<img src="../images/ct_icon_date.gif" width="30" height="30" id="calendar" />
			</div>
			
			<div class="form-group">
				<label for="quantity" class="col-sm-offset-1 col-sm-3 control-label">구매수량</label>
				<div class="col-sm-4">
					<input type="text" class="form-control" id="quantity" name="quantity" value="1"/>
					재고수량 : ${product.quantity}
					<input type="hidden" id="prodQuantity" name="prodQuantity"value="${product.quantity}" /> 
				</div>
			</div>
			
			 <div class="form-group">
			    <div class="col-sm-offset-4  col-sm-4 text-center">
			      <button type="button" class="btn btn-primary"  >구매</button>
				  <a class="btn btn-primary btn" href="#" role="button">취소</a>
			    </div>
		  </div>
			
		</form>
   	</div>

</body>
</html>
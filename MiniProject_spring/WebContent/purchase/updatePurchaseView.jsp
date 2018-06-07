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
	
	<style type="text/css">
	 body > div.container{
        	border: 3px solid #D6CDB7;
            margin-top: 100px;
        }
	</style>
	
	<!-- Bootstrap Dropdown Hover CSS -->
   <link href="/css/animate.min.css" rel="stylesheet">
   <link href="/css/bootstrap-dropdownhover.min.css" rel="stylesheet">
   
    <!-- Bootstrap Dropdown Hover JS -->
   <script src="/javascript/bootstrap-dropdownhover.min.js"></script>
	
	<script type="text/javascript" src="../javascript/calendar.js"></script>
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
				show_calendar('document.updatePurchase.divyDate', $("input[name='divyDate']").val())
			});
		});
		
		//============= "취소"  Event 처리 및  연결 =============
		$(function() {
			$(".btn-primary:contains('취소')").on("click" , function() {
				history.go(-1);
			});
		});	
		
		$(function(){
			$(".btn-primary:contains('수정')").on("click", function(){			
				$("form").attr("method", "POST").attr("action", "/purchase/updatePurchase?tranNo=${purchase.tranNo}").submit();
			})
		});
	</script>

</head>

<body>

	<!-- ToolBar Start /////////////////////////////////////-->
	<jsp:include page="/layout/toolbar.jsp" />
   	<!-- ToolBar End /////////////////////////////////////-->
   	
   	<div class="container">
   	
   		<h1 class="bg-primary text-center">구매정보수정</h1>
   		
   		<form class="form-horizontal" name="updatePurchase">

			<div class="form-group">
				<label for="buyerId" class="col-sm-offset-1 col-sm-3 control-label">구매자아이디</label>
				<div class="col-sm-4">
					<input type="text" class="form-control" id="buyerId" name="buyerId" value="${purchase.buyer.userId}" readonly>
				</div>
				<input type="hidden" name="buyerId" value="${purchase.buyer.userId}">
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
					<input type="text" class="form-control" id="receiverName" name="receiverName" value="${purchase.receiverName}" />
				</div>
			</div>
			
			<div class="form-group">
				<label for="receiverPhone" class="col-sm-offset-1 col-sm-3 control-label">구매자연락처</label>
				<div class="col-sm-4">
					<input type="text" class="form-control" id="receiverPhone" name="receiverPhone" value="${purchase.receiverPhone}" />
				</div>
			</div>
			
			<div class="form-group">
				<label for="divyAddr" class="col-sm-offset-1 col-sm-3 control-label">구매자주소</label>
				<div class="col-sm-4">
					<input type="text" class="form-control" id="divyAddr" name="divyAddr" value="${purchase.divyAddr}" />
				</div>
			</div>
			
			<div class="form-group">
				<label for="divyRequest" class="col-sm-offset-1 col-sm-3 control-label">구매요청사항</label>
				<div class="col-sm-4">
					<input type="text" class="form-control" id="divyRequest" name="divyRequest" value="${purchase.divyRequest}"/>
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
					재고수량 : ${purchase.quantity}
					<input type="hidden" id="prodQuantity" name="prodQuantity"value="${purchase.quantity}" /> 
				</div>
			</div>
			
			<div class="form-group">
			    <div class="col-sm-offset-4  col-sm-4 text-center">
			      <button type="button" class="btn btn-primary">수정</button>
				  <a class="btn btn-primary btn" href="#" role="button">취소</a>
			    </div>
		 	</div>
			
		</form>
   	</div>


</body>
</html>
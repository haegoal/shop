<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<style>
	span{
		width: 150px;
		justify-content: center;
	}
	#image {
		border-radius:50%;
		cursor:pointer
	}
</style>

<div class="row" id="page_order" style="display:none;">
        <div class="col">
            <h1 class="text-center">주문하기</h1>
            <div id="div_order"></div>
            <h1 class="text-center">주문자정보</h1>
            <form name="frm" class="card p-3">
            	<div class="input-group mb-3">
            		<span class="input-group-text">주문자명</span>
            		<input class="form-control" value="${user.uname}">
            	</div>
            	<div class="input-group mb-3">
            		<span class="input-group-text">연락처</span>
            		<input class="form-control"  name="phone" value="${user.phone}">
            	</div>
            	<div class="input-group mb-3">
            		<span class="input-group-text">주문자주소</span>
            		<input class="form-control" name="address1" value="${user.address1}">
            		<a class="btn btn-primary" id="btn-search">주소검색</a>
            	</div>
            	<div class="input-group mb-3">
            		<span class="input-group-text">상세주소</span>
            		<input class="form-control" name="address2" value="${user.address2}">
            	</div>
            	<input name="sum" type="hidden">
            	<div class="text-center my-3">
            		<button class="btn btn-primary px-5">주문하기</button>
            	</div>
            </form>
        </div>
</div>
<script id="temp_order" type="text/x-handlebars-template">
<table class="table">
	{{#each .}}
		<tr class="tr" price="{{price}}" qnt="{{qnt}}" gid="{{gid}}">
			<td>{{title}}</td>
			<td>{{gid}}</td>
			<td><img src="{{image}}" width="60px"></td>
			<td>{{sum 1 price}}</td>
			<td>{{qnt}}</td>
			<td>{{sum qnt price}}</td>
		<tr>
	{{/each}}
				<tr>
					<td colspan="6" class="text-end pe-5">
				<h5>총합계: <span id="sum">0원</span></h5>
					</td>
				</tr>
<table>
</script>
<script>


	$(frm).on("submit", function(e){
		e.preventDefault();
		if(confirm("상품을 주문하시겠습니까?")){
			$.ajax({
				type:"post",
				url:"/purchase/insert",
				data:{phone:$(frm.phone).val(), 
					uid:"${user.uid}", 
					address1:$(frm.address1).val(), 
					address2:$(frm.address2).val(),
					sum:$(frm.sum).val()},
				success:function(data){
					alert(data)
					const pid=data;
					$("#div_order .tr").each(function(){
						const gid=$(this).attr("gid");
						const price=$(this).attr("price");
						const qnt=$(this).attr("qnt");
						$.ajax({
							type:"post",
							url:"/order/insert",
							data:{gid:gid, price:price, qnt:qnt, pid:pid},
							success:function(){
								$.ajax({
									type:"get",
									url:"/cart/delete",
									data:{gid:gid},
									success:function(){
										
									}
								})
							}
						})
					});
					alert("주문이 완료되었습니다.");
					location.href="/";
				}
			})
		}
	})
	
	
	function getOrder(data){
		const temp = Handlebars.compile($("#temp_order").html());
		$("#div_order").html(temp(data));
		getOrderSum()
	}
	
	function getOrderSum(){
		let sum=0;
		$("#div_order .tr").each(function(){
			const price = $(this).attr("price");
			const qnt= $(this).attr("qnt");
			sum+=price*qnt;
		})
		$(frm.sum).val(sum);
		$("#sum").html(sum.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") + "원");
	}

	$("#btn-search").on("click", function(){
		new daum.Postcode({
			oncomplete : function(data){
				//console.log(data);
				if(data.buildingName!=""){
					$(frm.address1).val(data.address + " " + data.buildingName);
				}
				$(frm.address1).val(data.address);
			}
		}).open();
	});
</script>


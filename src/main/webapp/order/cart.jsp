<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div class="row" id="page_cart">
        <div class="col">
            <h1 class="text-center">장바구니</h1>
           	<div id="div_cart"></div>
        </div>
    </div>
    <jsp:include page="order.jsp"/>
 <script id="temp_cart" type="text/x-handlebars-template">
	<table class="table">
		<tr>
			<th><input type="checkbox" id="all"></th>
			<th>상품코드</th><th>상품이미지</th><th>상품이름</th><th>상품가격</th><th>제조사</th><th>상품수량</th><th>상품금액</th>
		</tr>
		{{#each .}}
			<tr class="tr" price="{{price}}">
				<td><input type="checkbox" class="chk" goods="{{toString @this}}"></td>
				<td class="gid">{{gid}}</td>
				<td><img src="{{image}}" width="50px"></td>
				<td>{{title}}</td>
				<td>{{sum 1 price}}</td>
				<td>{{maker}}</td>
				
				<td><input class="qnt" value="{{qnt}}" size="5" oninput="isNumber(this)">
				<button class="btn btn-primary btn-sm">변경</button></td>
				<td>{{sum qnt price}}</td>
				<td><button class="btn btn-danger btn-sm" gid="{{gid}}">삭제</button></td>
			</tr>
		{{/each}}
				<tr>
					<td colspan="8" class="text-end pe-5">
				<h5>총합계: <span id="sum1">0원</span></h5>
					</td>
				</tr>
	</table>
	<div class="text-center">
		<button class="btn btn-warning px-4" id="btn-order">주문하기</button>
	</div>
</script>
<script>

Handlebars.registerHelper("toString", function(goods){
	return JSON.stringify(goods);
})

Handlebars.registerHelper("sum", function(qnt, price){
	const sum=qnt*price
	return sum.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") + "원";
})

	//숫자인 경우에만 입력
	function isNumber(item){
	    item.value=item.value.replace(/[^0-9]/g,'');
	}
</script>
<script>
getList();
const uid = "${user.uid}";

$("#div_cart").on("click", "#btn-order", function(){
	const chk= $("#div_cart .chk:checked").length;
		if(chk==0){
			alert("상품을 선택해주세요!")
		}else if(uid==""){
			location.href="/user/login?target=/cart/list";
		}else{
			let data=[];
			$("#div_cart .chk:checked").each(function(){
				const goods= $(this).attr("goods");
				data.push(JSON.parse(goods));
			});
			
			console.log(data);
			
			getOrder(data);
			$("#page_order").show();
			$("#page_cart").hide();
		}
	})
	
	

	$("#div_cart").on("click", ".chk", function(){
		const all= $("#div_cart .chk").length;
		const chk= $("#div_cart .chk:checked").length;
		if(all==chk){
			$("#div_cart #all").prop("checked", true);
		}else{
			$("#div_cart #all").prop("checked", false);
		}
	});

	$("#div_cart").on("click", "#all", function(){
		if($(this).is(":checked")){
			$("#div_cart .chk").each(function(){
				$("#div_cart .chk").prop("checked", true);
			})
		}else{
			$("#div_cart .chk").each(function(){
				$("#div_cart .chk").prop("checked", false);
			})
		}
	})
	
	$("#div_cart").on("click", ".btn-primary", function(){
		const row=$(this).parent().parent();
		const gid=row.find(".gid").text();
		const qnt=row.find(".qnt").val();
		if(confirm(gid + "상품의 수량을" + qnt+ "로 변경하시겠습니까?")){
			$.ajax({
				type:"get",
				url:"/cart/update",
				data:{gid:gid, qnt:qnt},
				success:function(){
					getList();
					alert("수정완료!")
				}
			})
		}
	})
	
	$("#div_cart").on("click", ".btn-danger", function(){
		const gid= $(this).attr("gid");
		if(confirm(gid + "삭제하시겠습니까?")){
			$.ajax({
				data:{gid:gid},
				type:"get",
				url:"/cart/delete",
				success:function(){
					alert("삭제완료")
					getList();
				}
			})
		}
	})
	
	
	
	
	function getList(){
		$.ajax({
			type:"get",
			url:"/cart/list.json",
			dataType:"json",
			success:function(data){
				if(data.length==0){
					$("#div_cart").html("<h3 class='text-center'> 장바구니가 비어있습니다.</h3>");
				}else{
				const temp = Handlebars.compile($("#temp_cart").html());
				$("#div_cart").html(temp(data));
				getSum();
				}
			}
		})
	}
	
	function getSum(){
		let sum=0;
		$("#div_cart .tr").each(function(){
			const price = $(this).attr("price");
			const qnt= $(this).find(".qnt").val();
			sum+=price*qnt;
		})
		$("#sum1").html(sum.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") + "원");
	}
</script>
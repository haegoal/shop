<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div class="row my-5">
	<div class="col">
		 <h1 class="text-center">상품목록</h1>
		 <div class="row justify-content-end">
		 <div class="col">
		 	<a href="/goods/insert">
		 	<button class="btn btn-primary">상품등록</button>
		 	</a>
		 </div>
		<form name="frm" class="col-3">
			<div class="input-group">
				<input class="form-control" name="query" value="">
				<button class="btn btn-primary">검색</button>
			</div>
		</form>
		</div>
		<hr>
		 <div id="div_goods"></div>
		 <div id="pagination" class="pagination justify-content-center"></div>
	</div>
</div>
<script id="temp_goods" type="text/x-handlebars-template">	
<table class="table">
		{{#each .}}
			<tr>
					<td class="gid"><a href="/goods/update?gid={{gid}}">{{gid}}</a></td>
					<td class="img"><img src="{{image}}" width="50px"></td>
					<td class="ellipsis">{{{title}}}</td>
					<td>{{fp price}}</td>
					<td>{{maker}}</td>
					<td class="text-end"><button class="btn btn-danger btn-sm" gid="{{gid}}" image="{{image}}">삭제</button></td>
			</tr>
		{{/each}}
</table>
</script>
<script>
	Handlebars.registerHelper("fp", function(lprice){
		return lprice.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") + "원";;
	})
	
</script>
<script>
	let page=1;
	let query="";
	getTotal();
	
	$('#div_goods').on("click", ".btn-danger",function(){
		const image = $(this).attr("image");
		const gid = $(this).attr("gid");
		if(confirm(gid +"삭제하시겠습니가?")){
			$.ajax({
				type:"post",
				url:"/goods/delete",
				data:{image:image, gid:gid},
				success:function(){
					alert("삭제완료.")
					getTotal();
				}
			})
		}
	})
	
	$(frm).on("submit", function(e){
		e.preventDefault();
		query=$(frm.query).val();
		page=1;
		getTotal();
	})
	
	function getList(){
		$.ajax({
			type:"get",
			url:"/goods/list.json",
			data:{query:query, page:page},
			dataType:"json",
			success:function(data){
				console.log(data);
				const temp= Handlebars.compile($("#temp_goods").html());
				$("#div_goods").html(temp(data));
			}
		})
	}
	
	function getTotal(){
		$.ajax({
			type:"get",
			url:"/goods/total",
			data:{query:query},
			success:function(data){
				const totalPages = Math.ceil(data/6);
				if(totalPages==0){
					alert("검색내용이없음");
					$(frm.query).val("");
					query="";
					getTotal();
				}else{
					$("#pagination").twbsPagination("changeTotalPages", totalPages, 1) // 토탈값 함수 // 1은 시작값
				}
			}
		})
	}
	
	$('#pagination').twbsPagination({
	    totalPages:21,	// 총 페이지 번호 수
	    visiblePages: 10,	// 하단에서 한번에 보여지는 페이지 번호 수
	    startPage : 1, // 시작시 표시되는 현재 페이지
	    initiateStartPageClick: false,	// 플러그인이 시작시 페이지 버튼 클릭 여부 (default : true)
	    first : '<<',	// 페이지네이션 버튼중 처음으로 돌아가는 버튼에 쓰여 있는 텍스트
	    prev : '<',	// 이전 페이지 버튼에 쓰여있는 텍스트
	    next : '>',	// 다음 페이지 버튼에 쓰여있는 텍스트
	    last : '>>',	// 페이지네이션 버튼중 마지막으로 가는 버튼에 쓰여있는 텍스트
	    onPageClick: function (event, curPage) {
	    	//getList(page); // 페이지클릭시 이벤트
				page=curPage;
		    	getList();
	    
	    }
	});
</script>
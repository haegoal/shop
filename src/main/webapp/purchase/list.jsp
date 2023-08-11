<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <div class="row">
        <div class="col my-3">
            <h1 class="text-center">주문목록</h1>
            <div class="row">
            	<form class="col-md-4" name="frm">
            	<div class="input-group">
            		<select class="form-select" name="key">
	            		<option value="uid">아이디</option>
	            		<option selected value="uname">이름</option>
	            		<option value="raddress1">주소</option>
	            		<option value="rphone">핸드폰</option>
            		</select>&nbsp;
            		<input class="form-control" name="query" placeholder="검색어">
            		<input class="btn btn-primary" value="검색" type="submit">
            		</div>
            	</form>
            	<div class="col-md-4"></div>
            	<div class="col-md-4">
            		<select class="form-select" id="sel-status">
						<option value="0">결제대기중</option>
						<option value="1">결제완료</option>
						<option value="2" >배송준비</option>
						<option value="3">배송중</option>
						<option value="4">배송완료</option>
						<option value="">전체</option>
					</select>
            	</div>
            </div>
             <div id="div_pur"></div>
             <div id="pagination" class="pagination justify-content-center"></div>
        </div>
</div>
<script id="temp_pur" type="text/x-handlebars-template">
<table class="table">
        {{#each .}}
			<tr>
				<td class="pid"><a href="/purchase/read?pid={{pid}}">{{pid}}</a></td>
				<td>{{uid}}</td>
				<td>{{uname}}</td>
				<td>{{address1}} {{address2}}</td>
				<td>{{phone}}</td>
				<td>{{purDate}}</td>
				<td>
					<select class="form-select status">
						<option value="0" {{select status 0}}>결제대기중</option>
						<option value="1" {{select status 1}}>결제완료</option>
						<option value="2" {{select status 2}}>배송준비</option>
						<option value="3" {{select status 3}}>배송중</option>
						<option value="4" {{select status 4}}>배송완료</option>
					</select>
				</td>
				<td>
					<button class="btn btn-secondary btm-sm btn-update">수정</button>
				</td>
			</tr>
		{{/each}}
</table>
</script>
<script>
	Handlebars.registerHelper("select", function(status, value){
		if(status==value){
			return "selected";
		}
	})

</script>

<script>
    let page=1;
    let query="";
    let key=$(frm.key).val();
    //getList(1);
    
    $("#sel-status").on("change", function(){
    	key="status";
    	query=$(this).val();
    	getTotal();
    });
    
    $("#div_pur").on("click", ".btn-update", function(){
    	const row=$(this).parent().parent();
    	const pid = row.find(".pid").text();
    	const status = row.find(".status").val();
    	//alert(pid + status)
    	if(confirm("변경하시겠습니까?")){
    		$.ajax({
    			type:"post",
    			data:{pid:pid, status:status},
    			url:"/purchase/update",
    			success:function(){
    				alert("상태가 변경되었습니다.")
    				getTotal();
    			}
    		})
    	}
    })

    $(frm).on("submit", function(e){
    	e.preventDefault();
    	query=$(frm.query).val();
    	key=$(frm.key).val();
    	page=1;
    	getTotal();
    })
 
    function getList(){
        $.ajax({
            type:"get",
            url:"/purchase/list.json",
            data:{"page":page, "query":query, "key":key},
            dataType:"json",
            success:function(data){
            	console.log(data);
                let temp=Handlebars.compile($("#temp_pur").html());
                $("#div_pur").html(temp(data));
            }
        })
    }
    
    getTotal();
    function getTotal(){
    	$.ajax({
    		type:"get",
            url:"/purchase/total",
            data:{"query":query, "key":key},
            success:function(data){
            	if(data==0){
            		$("#div_pur").html("<h3 class='text-center mt-5'>검색결과가없습니다.</h3>")
            	}else{
            		const totalPages = Math.ceil(data/5);
                	$("#pagination").twbsPagination("changeTotalPages", totalPages, 1) // 토탈값 함수 // 1은 시작값
            	}
            	if(data>5){
            		$('#pagination').show(); 
            	}else{
            		$('#pagination').hide();
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
    
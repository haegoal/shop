<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <div class="row">
        <div class="col my-3">
            <h1 class="text-center">유저목록</h1>
            <div class="row">
            	<form class="col-6" name="frm">
            	<div class="input-group">
            		<select class="form-select" name="key">
	            		<option value="uid">아이디</option>
	            		<option selected value="uname">이름</option>
	            		<option value="address1">주소</option>
	            		<option value="phone">회원번호</option>
            		</select>&nbsp;
            		<input class="form-control" name="query" placeholder="검색어">
            		<input class="btn btn-primary" value="검색" type="submit">
            		</div>
            	</form>
            </div>
             <div id="div_user"></div>
             <div id="pagination" class="pagination justify-content-center"></div>
        </div>
</div>

<script id="temp_user" type="text/x-handlebars-template">
        {{#each .}}
		<div class="row card p-3">
			<div class="row">
			<div class="col-md-2 col-2">
				<img src={{photo}} width="90%">
			</div>
			<div class="col">
				<div>{{uid}} {{uname}}</div>
				<div>{{address1}} {{address2}}</div>
				<div>{{phone}}</div>
			</div>
			</div>	
		</div>
		{{/each}}
</script>
<script>
    let page=1;
    let query="";
    let key=$(frm.key).val();
    //getList(1);
    getList();

    $(frm).on("submit", function(e){
    	e.preventDefault();
    	query=$(frm.query).val();
    	key=$(frm.key).val();
    	getList();
    })
 
    function getList(){
        $.ajax({
            type:"get",
            url:"/user/list.json",
            data:{"page":page, "query":query, "key":key},
            dataType:"json",
            success:function(data){
            	console.log(data);
                let temp=Handlebars.compile($("#temp_user").html());
                $("#div_user").html(temp(data));
            }
        })
    }

    
</script>
    
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
    
<div class="row">
	<div class="col">
		<h1 class="text-center">고객리뷰</h1>
		<c:if test="${user==null}">
			<div class="text-center">
			<button class="btn btn-primary mt-1" id="btn-review">리뷰작성</button>
			</div>
		</c:if>
		
		<c:if test="${user!=null}">
		<form name="frm">
			<textarea rows="5" class="form-control" name="content"></textarea>
			<div class="text-end mt-1">
				<button class="btn btn-primary mt-1">글쓰기</button>
			</div>
			<div id="div_review"></div>
		</form>
		</c:if>
		
	</div>
</div>
<script id="temp_review" type="text/x-handlebars-template">
		{{#each .}}
			<div class="row my-3 card p-3">
				<div class="col-1">
				<img src="{{fimage photo}}" width="50px">
					<div class="text-center">{{uid}}</div>
				</div>

				<div class="col">
					{{revDate}}
					{{content}}
				</div>
			</div>
		{{/each}}
</script>
<script>
	Handlebars.registerHelper("fimage", function(image){
		if(image==null){
			return "http://via.placeholder.com/120x174";
		}else{
			return image;
		}
	})

</script>




<script>
const uid="${user.uid}";

const gid="${vo.gid}";
getList()

$("#btn-review").on("click", function(){
	location.href="/user/login?target=/goods/read?gid=" + gid;
})

$(frm).on("submit", function(e){
	e.preventDefault();
	const content=$(frm.content).val();
	if(content==""){
		alert("리뷰를 작성해주세요");
		$(frm.content).focus();
	}else if(confirm("리뷰등록하시겠습니까?")){
		$.ajax({
			type:"post",
			url:"/review/insert",
			data:{uid,gid,content},
			success:function(){
				alert("작성완료");
			}
		})
	} 
});

function getList(){
	$.ajax({
		type:"get",
		url:"/review/list.json",
		data:{gid},
		dataType:"json",
		success:function(data){
			console.log(data);
			const temp= Handlebars.compile($("#temp_review").html());
			$("#div_review").html(temp(data));
		}
	})
}
</script>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div class="row">
	<div class="col">
		<h1 class="my-5 text-center">상품수정</h1>
		<div class="row justify-content-center">
			<form class="col-6 card p-3" name="frm1" method="post" enctype="multipart/form-data">
				<div class="input-group mb-3">
					<span class="input-group-text">상품코드</span>
					<input class="form-control" name="gid" value="${vo.gid}" readonly>
				</div>
				<div class="input-group mb-3">
					<span class="input-group-text">상품이름</span>
					<input class="form-control" name="title" value="${vo.title}">
				</div>
				<div class="input-group mb-3">
					<span class="input-group-text">상품가격</span>
					<input class="form-control" name="price" oninput="isNumber(this)" value="${vo.price}">
				</div>
				<div class="input-group mb-3">
					<span class="input-group-text">제조사</span>
					<input class="form-control" name="maker" value="${vo.maker}">
				</div>
				<div class="input-group mb-3">
					<input class="form-control" name="image" type="file" accept="image/*">
					<input name="oldImage" value="${vo.image}" type="hidden">
				</div>
				<div>
					<img src = "${vo.image}" width="40%" id="image">
				</div>
				<div class="text-center">
					<input type="submit" value="수정" class="btn btn-primary">
					<input type="reset" value="취소" class="btn btn-secondary">
				</div>
			</form>
		</div>
	</div>
</div>
<script>
	const oldImage = "${vo.image}";		
		
		
	$(frm1.image).on("change", function(e){
		$("#image").attr("src", URL.createObjectURL(e.target.files[0]));	
	})
	
	$(frm1).on("reset", function(){
		$("#image").attr("src", oldImage);
	});
	
	$(frm1).on("submit", function(e){
		e.preventDefault();
		const title=$(frm1.title).val();
		const price=$(frm1.price).val();
		
		if(title=="" || price==""){
			alert("상품이름, 가격를 입력해주세요.")
			$(frml.title).focus();
		}else{
			if(confirm("수정하시겠습니까?")){
				frm1.submit();
			}else{
				alert("수정이 취소되었습니다.")
			}
		}
	})
	
	//숫자인 경우에만 입력
	function isNumber(item){
	    item.value=item.value.replace(/[^0-9]/g,'');
	}
</script>
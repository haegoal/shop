<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
<div class="row">
	<div class="col">
		<h1 class="text-center">회원정보</h1>
				<form name="frm" class="card p-3" method="post" action="/user/update" enctype="multipart/form-data">
					<div class="col-md-3 mb-3 text-center">
					<c:if test="${vo.photo==null || vo.photo==''}">
						<img src="http://via.placeholder.com/100x100" width="80%" id="image">
					</c:if>
					<c:if test="${vo.photo!=null}">
						<img src="${vo.photo}" width="80%" id="image">
					</c:if>
					<input type="file" name="photo" style="display:none" accept="image/*">
					<input type="hidden" name="oldPhoto" value="${vo.photo}">
				</div>
				<div class="col">
					<div class="input-group mb-3">
						<span class="input-group-text">아 이 디</span>
						<input name="uid" class="form-control" readonly value="${vo.uid}">
					</div>
					<div class="input-group mb-3">
						<span class="input-group-text">비밀번호</span>
						<input name="upass" type="password" class="form-control" value="${vo.upass}" readonly>
					</div>
					<div class="input-group mb-3">
						<span class="input-group-text">회 원 명</span>
						<input name="uname" class="form-control" value="${vo.uname}">
					</div>
				</div>
			</div>
			<div class="input-group mb-3">
				<span class="input-group-text">전화번호</span>
				<input name="phone" class="form-control" value="${vo.phone}">
			</div>
			<div class="input-group mb-3">
				<span class="input-group-text">주소1</span>
				<input name="address1" class="form-control" value="${vo.address1}">
				<a class="btn btn-primary" id="btn-search">주소검색</a>
			</div>
			<div class="input-group mb-3">
				<span class="input-group-text">주소2</span>
				<input name="address2" class="form-control" value="${vo.address2}">
			</div>
				<div class="text-center">
					<button class="btn btn-primary">정보수정</button>
				</div>
				</form>

	</div>
</div>

<script>
//이미지

$(frm.photo).on("change", function(e){
	$("#image").attr("src", URL.createObjectURL(e.target.files[0]));
})

$("#image").on("click", function(){
	$(frm.photo).click();
})

	
	$(frm).on("submit", function(e){
		e.preventDefault();
		const uid=$(frm.uid).val();
		const uname=$(frm.uname).val();
		if(uid==""){
			alert("아이디를 입력하세요!");
			$(frm.uid).focus();
		}else if(uname==""){
			alert("이름을 입력하세요!");
			$(frm.uname).focus();
		}else{
			if(confirm("회원수정하시겠습니까?")){
				frm.submit();
			}
		}
	});	
	
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


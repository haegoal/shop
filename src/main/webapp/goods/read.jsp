<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<div class="row">
	<div class="col">
		<h1 class="text-center mb-5">상품정보</h1>
		<div class="row">
			<div class="col-md-5 card-me-2">
				<img src="${vo.image}" width="90%">
			</div>
			<div class="col card">
				<h5>${vo.gid}</h5>
				<h5>${vo.title}</h5>
				<hr>
				<div class="my-2">상품가격:<fmt:formatNumber value="${vo.price}" pattern="#,###원"/></div>
				<div class="my-2">제조사:${vo.maker}</div>
				<div class="my-2">상품등록일:${vo.regDate}</div>
				<hr>
				<div>
					<button class="btn btn-primary" id="btn-cart" gid="${vo.gid}">장바구니</button>
					<button class="btn btn-warning">바로구매</button>
				</div>
			</div>
		</div>
	</div>
</div>
<ul class="nav nav-tabs" id="myTab" role="tablist">
  <li class="nav-item" role="presentation">
    <button class="nav-link active" id="detail-tab" data-bs-toggle="tab" data-bs-target="#detail-tab-pane" type="button" role="tab" aria-controls="home-tab-pane" aria-selected="true">상세설명</button>
  </li>
  <li class="nav-item" role="presentation">
    <button class="nav-link" id="review-tab" data-bs-toggle="tab" data-bs-target="#review-tab-pane" type="button" role="tab" aria-controls="profile-tab-pane" aria-selected="false">고객리뷰</button>
  </li>
</ul>
<div class="tab-content" id="myTabContent">
  <div class="tab-pane fade show active" id="detail-tab-pane" role="tabpanel" aria-labelledby="home-tab" tabindex="0">
  상세설명...</div>
  <div class="tab-pane fade" id="review-tab-pane" role="tabpanel" aria-labelledby="profile-tab" tabindex="0">
 <jsp:include page="review.jsp"/>
 	</div>
</div>
<script>
$("#btn-cart").on("click", function(){
	const gid=$(this).attr("gid");
	$.ajax({
		type:"get",
		data:{gid:gid},
		url:"/cart/insert",
		success:function(){
			if(confirm("계속 쇼핑하실래요?")){
				location.href="/";
		}else{
			location.href="/cart/list";
		}
		}
	})
})
</script>


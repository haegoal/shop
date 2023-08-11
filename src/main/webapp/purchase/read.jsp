<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div class="row">
	<div class="col">
		<h1 class="text-center">구매정보</h1>
		<div class="card p-3">
			<div class="row">
				<div class="col">주문번호: ${vo.pid}</div>
				<div class="col">주문자: ${vo.uid} ${vo.uname}</div>
				<div class="col">연락처: ${vo.phone}</div>
				<div class="col">주문일: ${vo.purDate}</div>
				<div class="col">주문상태: 
					<c:out value="${vo.status==0 ? '결제대기중' : ''}"/>
					<c:out value="${vo.status==1 ? '결제완료' : ''}"/>
					<c:out value="${vo.status==2 ? '배송준비' : ''}"/>
					<c:out value="${vo.status==3 ? '배송중' : ''}"/>
					<c:out value="${vo.status==4 ? '배송완료' : ''}"/>
				</div>
			</div>
			<div class="row">
				<div class="col">주소: ${vo.address1} ${vo.address2}</div>
					<div class="col">금액: <fmt:formatNumber value="${vo.purSum}" pattern="#,###원"/></div>
			</div>
		</div>
		<h1 class="text-center my-5">주문상품</h1>
		<table class="table">
			<c:forEach items="${array}" var="gvo">
				<tr>
					<td><a href="/goods/read?gid=${gvo.gid}">${gvo.gid}</a></td>
					<td><img src="${gvo.image}" width="50px"></td>
					<td>${gvo.title}</td>
					<td><fmt:formatNumber value="${gvo.price}" pattern="#,###원"/></td>
					<td>${gvo.qnt}</td>
					<td><fmt:formatNumber value="${gvo.price * gvo.qnt}" pattern="#,###원"/></td>
				</tr>
			</c:forEach>
		</table>
	</div>
</div>
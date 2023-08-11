<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div class="row justify-content-center">
	<div class="col-md-6">
		<h1 class="text-center">로그인</h1>
		<form name="frm" class="card p-5">
			<input class="form-control mb-3" placeholder="아아디" name="uid">
			<input type="password" class="form-control mb-3" placeholder="비밀번호" name="upass">
			<button class="btn btn-primary w-100">로그인</button>
			<div class="text-end">
				<a href="/user/insert">회원가입</a>
			</div>
		</form>
	</div>
</div>
<script>
	const target = "${target}";
	$(frm).on("submit", function(e){
		e.preventDefault();
		const uid = $(frm.uid).val();
		const upass = $(frm.upass).val();
		if(uid == "" || upass==""){
			alert("아이디 또는 비번입력바람")
		}else{
			$.ajax({
				type:"post",
				data:{uid:uid, upass:upass},
				url:"/user/login",
				success:function(data){
					if(data==0){
						alert("없는 아이디입니다.")
					}else if(data==2){
						alert("비밀번호 틀렸습니다.");
					}else{
						alert("로그인성공!");
						if(target==""){
							location.href="/";
						}else{
							location.href=target;
						}
						
					}
				}
			})
		}
	})
</script>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String CtxPath=request.getContextPath();
%>
<jsp:include page="../header.jsp"/> 
   
<script type="text/javascript">

	$(document).ready(function(){
	
		$("#pwd").focus();
		
		$("#pwd").keydown(function(event){
			
			if(event.keyCode == 13) {
				goEdit();
			}
			
		});
		
	});

function goEdit() {
	
	var frm = document.mainFrm;
	frm.method = "POST";
	frm.action = "memberInfoMain.do";
	frm.submit();
}

</script>    

<aside id="colorlib-hero" class="breadcrumbs">
	<div class="flexslider">
		<ul class="slides">
	   	<li style="background-image: url(<%=CtxPath %>/store/images/cover-img-1.jpg);">
	   		<div class="overlay"></div>
	   		<div class="container-fluid">
	   			<div class="row">
		   			<div class="col-md-6 col-md-offset-3 col-sm-12 col-xs-12 slider-text">
		   				<div class="slider-text-inner text-center">
		   					<h1>MyPage</h1>
		   					<h2 class="bread">
			   					<span style="font-size: 13pt;"><a href="<%=CtxPath%>/memberModify.do">회원정보수정</a></span>
			   					<span style="font-size: 13pt;"><a href="<%=CtxPath%>/refundChange.do">환불 및 교환내역</a></span>
			   					<span style="font-size: 13pt;"><a href="<%=CtxPath%>/myPickList.do">찜 목록 보기</a></span>
			   					<span style="font-size: 13pt;"><a href="<%=CtxPath%>/orderList.do">주문내역보기</a></span>
			   					<span style="font-size: 13pt;"><a href="<%=CtxPath%>/couponList.do">보유쿠폰 보기</a></span>
			   					<span style="font-size: 13pt;"><a href="<%=CtxPath%>/myReview.do">리뷰보기</a></span>
		   					</h2>
		   				</div>
		   			</div>
		   		</div>
	   		</div>
	   	</li>
	  	</ul>
  	</div>
</aside>


<div class="container">      
   <div class="col-md-12">
	<h2>비밀번호 재확인</h2>
	<hr style="border: 1px solid gray;">
		<div>
			<form class="colorlib-form" name="mainFrm">
				<div class="form-group" style="margin-top: 3%; margin-left:20%;">
				<h3>회원님의 정보보호를 위해 비밀번호를 다시 입력해주세요.</h3>
					<div class="col-md-2" style="margin-top: 3%;">
                		<label for="userid" style="position: relative; top: -20px;"><span style="font-size: 15pt;">아이디</span></label>
             		</div>
             		<div class="col-md-3">
               			<input type="text" id="userid" name="userid" class="form-control" value="${sessionScope.loginuser.userid}" placeholder="ID" readonly/>
             		</div>
          		</div>
          			<div class="col-md-2" style="margin-top: 3%; margin-left:20%;">
                		<label for="pwd" style="position: relative; top: -20px;"><span style="font-size: 15pt;">비밀번호</span></label>
             		</div>
             		<div class="col-md-3">
               			<input type="password" id="pwd" name="pwd" class="form-control" placeholder="password"/>
             		</div>
					<div>
						<button type="button" id="btnSubmit" class="btn btn-primary" onClick="goEdit();" style="position: relative; top:5px; margin-left: 9%;"><span>확인</span></button>
					</div>				
			</form>
		</div>	
	</div>
</div>

				
<jsp:include page="../footer.jsp"/>
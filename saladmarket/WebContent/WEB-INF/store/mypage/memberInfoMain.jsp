<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String ctxPath=request.getContextPath();
%>
    
    
<jsp:include page="../header.jsp"/>
<aside id="colorlib-hero" class="breadcrumbs">
	<div class="flexslider">
		<ul class="slides">
	   	<li style="background-image: url(<%=ctxPath %>/store/images/cover-img-1.jpg);">
	   		<div class="overlay"></div>
	   		<div class="container-fluid">
	   			<div class="row">
		   			<div class="col-md-6 col-md-offset-3 col-sm-12 col-xs-12 slider-text">
		   				<div class="slider-text-inner text-center">
		   					<h1>MyPage</h1>
		   					<h2 class="bread">
			   					<span style="font-size: 13pt;"><a href="#">회원정보수정</a></span>
			   					<span style="font-size: 13pt;"><a href="#">환불 및 교환내역</a></span>
			   					<span style="font-size: 13pt;"><a href="#">찜 목록 보기</a></span>
			   					<span style="font-size: 13pt;"><a href="#">주문내역보기</a></span>
			   					<span style="font-size: 13pt;"><a href="#">보유쿠폰 보기</a></span>
			   					<span style="font-size: 13pt;"><a href="#">리뷰보기</a></span>
		   					</h2>
		   				</div>
		   			</div>
		   		</div>
	   		</div>
	   	</li>
	  	</ul>
  	</div>
</aside>


<div style="width: 60%; margin-left:20%;" >
	<div align="center">
	<h2 >로그인</h2>
	<hr style="border: 1px solid gray;" >
	<table >
		<tr>
			<th style="font-size: 18pt; ">비밀번호 재확인</th>
		</tr>
		
		<tr>
			<th style="font-size: 15pt;">회원님의 정보를 안전하게 하게 위해 비밀번호를 다시 입력해주세요.</th>
		</tr>
		<tr>
			<td><span style="font-size: 13pt;">아이디</span><td>
		</tr>
		<tr>
			<td><span id="userid" class="userid" style="font-size: 13pt;">rkgus3575</span><td>
		</tr>
		<tr>
			<td><span style="font-size: 13pt;">비밀번호</span><td>
		</tr>
		<tr>
			<td><input type="password" style="height: 15%;"/>&nbsp;&nbsp;<button type="button">확인</button><td>
		</tr>
	</table>
	</div>
</div>

				
<jsp:include page="../footer.jsp"/>
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
<div style="margin: 3%; border: 0px solid red;" align="center">
	<div style="width: 80%;margin: 0 auto;" align="center">
		<table style="width: 80%; border: 1px solid gray;">
			<tr height="100px;" style="">
				<td width="15%" style="font-size: 20pt; text-align: center; border: 1px solid gray;">
					<span id="name" class="name">전가현</span>
					<span style="font-size: 12pt">님</span><br>
					<span id="level" class="level" style="font-size: 12pt; font-weight: bold;" >골드</span>
				</td>
				<td width="25%" style="padding: 0 10pt;" align="center">
					<span style="font-weight: bold; font-size: 15pt;">배송현황</span>
					<br>
					<span style="font-size: 17pt">0</span><span style="font-size: 13pt">개</span>
				</td>
				<td width="25%" style="padding: 0 10pt;" align="center">
					<span style="font-weight: bold; font-size: 15pt;">보유쿠폰</span>
					<br>
					<span style="font-size: 17pt">0</span><span style="font-size: 13pt">개</span>
				</td>
				<td width="25%" style="padding: 0 10pt;" align="center">
					<span style="font-weight: bold; font-size: 15pt;">보유포인트</span>
					<br>
					<span style="font-size: 17pt">0</span><span style="font-size: 13pt">개</span>
				</td>
			</tr>
		</table>
	</div>
</div>
<div style="margin-top: 3%; margin-bottom: 1%;" align="center">
		<span style="font-weight: bold; font-size: 18pt; ">회원정보 수정</span>
		&nbsp;&nbsp;
	</div>	
<div class="container" style="margin-left: 25%;">      
   <div class="col-md-10">
      <form method="post" class="colorlib-form">
             <!--  <div class="form-group">
                  <div class="col-md-6">
                  <label for="userid">아이디</label>
                  <input type="text" id="userid" class="form-control" placeholder="ID">
               </div>
               <div class="col-md-3" style="margin-top: 8.5%">
                  <button class="btn" style="width: 80px; height: 20px; padding: 0px;"><span style="font-size: 2pt;">아이디 확인</span></button>
               </div>
            </div> -->
            <div class="form-group">
               <div class="col-md-6">
                  <label for="password">비밀번호</label>
                  <input type="password" id="password" class="form-control" placeholder="Password">
               </div>
            </div>
            <div class="form-group">
               <div class="col-md-6">
                  <label for="pwdcheck">비밀번호확인</label>
                  <input type="password" id="pwdcheck" class="form-control" placeholder="Pwdcheck">
               </div>
            </div>
            <div class="form-group">
               <div class="col-md-6" >
                  <label for="email">이메일</label>
                  <input type="text" id="email" class="form-control" placeholder="State Province">
               </div>
            </div>
            <div class="form-group">   
               <div class="col-md-6">
                  <label for="phone ">연락처</label>
                  <input type="text" id="phone " class="form-control" placeholder="Phone Number">
               </div>   
            </div>
            <div class="form-group">
               <div class="col-md-3">
                  <label for="postnum">우편번호</label>
                  <input type="text" id="postnum" class="form-control" placeholder="PostNum">
               </div>
               <div class="col-md-3" style="margin-top: 4%">
                  <input type="text" id="zippostalcode" class="form-control" placeholder="PostNum">
               </div>
               <div class="col-md-3" style="margin-top: 8.5%">
                  <button class="btn" style="width: 80px; height: 20px; padding: 0px;"><span style="font-size: 2pt;">우편번호찾기</span></button>
               </div>
            </div>
            <div class="col-md-6">
               <div class="form-group">
                  <label for="fname">주소</label>
                      <input type="text" id="address" class="form-control" placeholder="Enter Your Address">
                   </div>
                  <div class="form-group">
                         <input type="text" id="address2" class="form-control" placeholder="Second Address">
                  </div>
               </div>
         <div class="row">
            <div class="col-md-12" style="margin-left: 35%; margin-top: 5%;" >
               <p><a href="#" class="btn btn-primary">수정하기</a></p>
            </div>
         </div>

       </form>
   </div>
</div>

<div class="gototop js-top">
   <a href="#" class="js-gotop"><i class="icon-arrow-up2"></i></a>
</div>

<jsp:include page="../footer.jsp" />
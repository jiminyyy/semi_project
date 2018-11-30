<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% String CtxPath = request.getContextPath(); %>
<jsp:include page="../header.jsp" />
<aside id="colorlib-hero" class="breadcrumbs">
   <div class="flexslider">
      <ul class="slides">
         <li style="background-image: url(<%=CtxPath %>/store/images/cover-img-1.jpg);">
            <div class="overlay"></div>
            <div class="container-fluid">
               <div class="row">
                  <div class="col-md-6 col-md-offset-3 col-sm-12 col-xs-12 slider-text">
                     <div class="slider-text-inner text-center">
                        <h1>Password Change</h1>
                        <h2 class="bread"><span><a href="index.jsp">Home</a></span> <span><a href="login.jsp">Login</a></span></h2>
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
   	<div>
	    <form method="post" class="colorlib-form">    
	       <div class="form-group" style="margin-top: 3%;">
	         <div class="col-md-4" style="margin-top: 3%;"></div> <%-- 이부분은 칸 조정할려고 넣어놨어요ㅠㅠ --%>
	       	 <div class="col-md-1" style="margin-top: 3%;">
	             <label for="password">비밀번호</label>
	          </div>
	          <div class="col-md-3">
	             <input type="password" id="password" class="form-control" placeholder="Password">
	          </div>
	       </div>

	       <div class="form-group" style="margin-bottom: 3%;">
		       <div class="col-md-3" style="margin-top: 3%;"></div> <%-- 이부분은 칸 조정할려고 넣어놨어요ㅠㅠ --%>
		       <div class="col-md-2" style="margin-top: 3%;" align="right">
		           <label for="password">비밀번호 확인</label>
		       </div>
		       <div class="col-md-3">
		           <input type="password" id="pwdcheck" class="form-control" placeholder=Password>
		       </div>
	       </div>
	       
	       <div class="row" style="margin-bottom: 2%">
	          <div class="col-md-12" style="margin-top: 1%; margin-left: 43%;" >
	          	<button class="btn"><span style="font-size: 9pt;">비밀번호 변경</span></button>
	          </div>
	       </div>
	       
	       
	    </form>
     </div>
   </div>
</div>

<div class="gototop js-top">
   <a href="#" class="js-gotop"><i class="icon-arrow-up2"></i></a>
</div>

<jsp:include page="../footer.jsp" />
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% String CtxPath = request.getContextPath(); %>

<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="" />
<meta name="keywords" content="" />
<meta name="author" content="" />

<link href="https://fonts.googleapis.com/css?family=Roboto:100,300,400,500,700" rel="stylesheet">
<!-- jQuery -->
<script src="<%=CtxPath %>/store/js/jquery.min.js"></script>

<!-- Animate.css -->
<link rel="stylesheet" href="<%=CtxPath %>/store/css/animate.css">
<!-- Icomoon Icon Fonts-->
<link rel="stylesheet" href="<%=CtxPath %>/store/css/icomoon.css">
<!-- Bootstrap  -->
<link rel="stylesheet" href="<%=CtxPath %>/store/css/bootstrap.css">

<!-- Magnific Popup -->
<link rel="stylesheet" href="<%=CtxPath %>/store/css/magnific-popup.css">

<!-- Flexslider  -->
<link rel="stylesheet" href="<%=CtxPath %>/store/css/flexslider.css">

<!-- Owl Carousel -->
<link rel="stylesheet" href="<%=CtxPath %>/store/css/owl.carousel.min.css">
<link rel="stylesheet" href="<%=CtxPath %>/store/css/owl.theme.default.min.css">

<!-- Date Picker -->
<link rel="stylesheet" href="<%=CtxPath %>/store/css/bootstrap-datepicker.css">
<!-- Flaticons  -->
<link rel="stylesheet" href="<%=CtxPath %>/store/fonts/flaticon/font/flaticon.css">

<!-- Theme style  -->
<link rel="stylesheet" href="<%=CtxPath %>/store/css/style.css">

<!-- Modernizr JS -->
<script src="<%=CtxPath %>/store/js/modernizr-2.6.2.min.js"></script>
<!-- FOR IE9 below -->
<!--[if lt IE 9]>
<script src="js/respond.min.js"></script>
<![endif]-->

<script type="text/javascript">
	
	$(document).ready(function(){
		
		$("#btnUpdate").click(function(event){
			
			var pwd = $("#pwd").val();
			var pwd2 = $("#pwd2").val();
			
			var regexp_passwd = new RegExp(/^.*(?=^.{8,15}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[^a-zA-Z0-9]).*$/g); 
			/* 암호는 숫자,영문자,특수문자가 포함된 형태의 8~15글자 이하만 허락해주는 정규표현식 객체 생성 */
			
			var bool = regexp_passwd.test(pwd);
			/* 암호 정규표현식 검사를 하는 것 
			      정규표현식에 만족하면 리턴값은 true,
			      정규표현식에 틀리면 리턴값은 false */
			      
			if(!bool) {
				alert("암호는 8글자 이상 15글자 이하에 영문자, 숫자, 특수기호가 혼합되어야 합니다."); 
				$("#pwd").val("");
				$("#pwd2").val("");
				event.preventDefault();
				return;
			}   
			else if(pwd != pwd2) {
				alert("암호가 일치하지 않습니다.");
				$("#pwd").val("");
				$("#pwd2").val("");
				event.preventDefault();
				return;
			}
			else {
				var frm = document.pwdConfirmFrm;
				frm.method = "POST";
				frm.action = "<%= CtxPath %>/pwdConfirm.do";
				frm.submit();	
			}
		});
				
	});
	
</script>
<title></title>
</head>
<body>

<div class="container">      
   <div class="col-md-12"> 
   	<div>
	    <form method="post" class="colorlib-form" name="pwdConfirmFrm">
	       <c:if test="${n != 1}">
	       <div class="form-group" style="margin-top: 3%;">
	         <div class="col-md-4" style="margin-top: 3%;"></div> <%-- 이부분은 칸 조정할려고 넣어놨어요ㅠㅠ --%>
	       	 <div class="col-md-1" style="margin-top: 3%;">
	             <label for="pwd">비밀번호</label>
	          </div>
	          <div class="col-md-3">
	             <input type="password" name="pwd" id="pwd" class="form-control" placeholder="Password" required/>
	          </div>
	       </div>

	       <div class="form-group" style="margin-bottom: 3%;">
		       <div class="col-md-3" style="margin-top: 3%;"></div> <%-- 이부분은 칸 조정할려고 넣어놨어요ㅠㅠ --%>
		       <div class="col-md-2" style="margin-top: 3%;" align="right">
		           <label for="pwd2">비밀번호 확인</label>
		       </div>
		       <div class="col-md-3">
		           <input type="password" name="pwd2" id="pwd2" class="form-control" placeholder=Password required/>
		       </div>
	       </div>
	       </c:if>
	       <input type="hidden" name="userid" id="userid" value="${userid}" />
   
			   <c:if test="${method.equals('POST') && n==1 }">
			   		<div id="div_confirmResult" align="center">
			   			ID : ${userid}님의 암호가 새로이 변경되었습니다.<br/>
			   		</div>
			   </c:if>
	       	   <c:if test="${method.equals('GET')}">
			   		<div class="row" style="margin-bottom: 2%">
	          			<div class="col-md-12" style="margin-top: 1%; margin-left: 38%;" >
	          				<button type="button" class="btn" id="btnUpdate"><span style="font-size: 9pt;">비밀번호 변경</span></button>
	          			</div>
	       			</div>
	       	   </c:if>
	    </form>
     </div>
   </div>
</div>

<div class="gototop js-top">
   <a href="#" class="js-gotop"><i class="icon-arrow-up2"></i></a>
</div>

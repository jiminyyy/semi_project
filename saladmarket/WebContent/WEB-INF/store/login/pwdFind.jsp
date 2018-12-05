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
			
		$("#btnFind").click(function(){
			var frm = document.pwdFindFrm;
			frm.method = "POST";
			frm.action = "<%=CtxPath%>/pwdFind.do";
			frm.submit();
		});
		
		var method = "${method}";
		var userid = "${userid}";
		var email = "${email}";
		var n = "${n}";
		
		if(method=="POST" && userid != "" && email != "") {
			$("#userid").val(userid);
			$("#email").val(email);
		}
		
		if(method=="POST" && n==1) {
			$("#div_btnFind").hide();
		}
		else if(method=="POST" && (n == -1 || n == 0)) {
			$("#div_btnFind").show();
		}		
		
		$("#btnConfirmCode").click(function(){
			
			var frm = document.pwdFindFrm;
		 
			var n1 = frm.input_confirmCode.value;
			var n2 = frm.certificationCode.value;
		
			if( n1 == n2 ) { // 올바른 인증키를 넣었는지..
				alert("인증성공 되었습니다.");
				
				frm.method = "GET"; // 새암호와 새암호확인을 입력받기 위한 폼만을 띄워주기 때문에 GET 방식으로 한다.
				frm.action = "<%= CtxPath %>/pwdConfirm.do";
				frm.submit();
			}
			else {
				alert("인증코드를 다시 입력하세요!!");
				$("#input_confirmCode").val("");
				$("#input_confirmCode").focus();
			}
			
		});
			
	}); //  $(document).ready(function(){
	
</script>
<title></title>
</head>
<body>

<div class="container">      
   <div class="col-md-12">
   	<div>
	    <form method="post" class="colorlib-form" name="pwdFindFrm">    
	       <div class="form-group" style="margin-top: 3%;">
	         <div class="col-md-4" style="margin-top: 3%;"></div> <%-- 이부분은 칸 조정할려고 넣어놨어요ㅠㅠ --%>
	       	 <div class="col-md-1" style="margin-top: 3%;">
	             <label for="userid">아이디</label>
	          </div>
	          <div class="col-md-3">
	             <input type="text" id="userid" name="userid" class="form-control" placeholder="ID">
	          </div>
	       </div>
	       <div class="form-group" style="margin-bottom: 3%;">
		       <div class="col-md-4" style="margin-top: 3%;"></div> <%-- 이부분은 칸 조정할려고 넣어놨어요ㅠㅠ --%>
		       <div class="col-md-1" style="margin-top: 3%;">
		           <label for="email">이메일</label>
		       </div>
		       <div class="col-md-3">
		           <input type="text" id="email" name="email" class="form-control" placeholder="abc@gmail.com">
		       </div>
	       </div>
	       <div id="div_findResult" align="center">
				<c:if test="${n == 1}">
   	      			<div id="pwdConfirmCodeDiv">
			   	      	  인증코드가 ${email}로 발송되었습니다.<br/>
			   	      	  인증코드를 입력해주세요<br/><br/>
   	      	 				<input type="text" name="input_confirmCode" id="input_confirmCode" required />
   	      	 				<input type="hidden" name="certificationCode" id="input_confirmCode" value="${certification}" required />
   	      					<br/><br/>
   	      	 				<button type="button" class="btn btn-info" id="btnConfirmCode">인증하기</button>    
   	      			</div>
   	   			</c:if>
   	   
		   	    <c:if test="${n == 0}">
		   	    	  <span style="color: red;">사용자 정보가 없습니다.</span>
		   	    </c:if>
   	   
		   	    <c:if test="${n == -1}">
		   	   	   <span style="color: red;">${sendFailmsg}</span>
		   	    </c:if>
   	   
   			</div>
   			<c:if test="${n != 1}">
	       <div class="row" style="margin-bottom: 2%">
	          <div class="col-md-12" style="margin-top: 1%; margin-left: 38%;" >
	          	<button type="button" class="btn" id="btnFind"><span style="font-size: 9pt;">비밀번호 찾기</span></button>
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
</body>
</html>
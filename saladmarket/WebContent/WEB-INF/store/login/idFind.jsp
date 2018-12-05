<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
		
		var method = "${method}";
		if(method == "GET") {
			$("#div_findResult").hide();
		}
		else if(method == "POST") {
			$("#name").val("${name}");
			$("#mobile").val("${mobile}");
			$("#div_findResult").show();
		}
		
		$("#btnFind").click(function(){
			
			var frm = document.idFindFrm;
			frm.action = "/saladmarket/idFind.do";
			frm.method = "POST";
			frm.submit();
			
		});
	});
	
</script>
   
<title></title>
</head>
<body>
<div class="container">      
	<div class="col-md-12">
		<div>
			<form method="post" class="colorlib-form" name="idFindFrm">    
				<div class="form-group" style="margin-top: 3%;">
					<div class="col-md-4" style="margin-top: 3%;"></div> <%-- 이부분은 칸 조정할려고 넣어놨어요ㅠㅠ --%>
					<div class="col-md-1" style="margin-top: 3%;">
						<label for="name">성명</label>
					</div>
					<div class="col-md-3">
						<input type="text" id="name" name="name" class="form-control" placeholder="Name" />
					</div>
				</div>
				<div class="form-group" style="margin-bottom: 10%;">
					<div class="col-md-4" style="margin-top: 3%;"></div> <%-- 이부분은 칸 조정할려고 넣어놨어요ㅠㅠ --%>
					<div class="col-md-1" style="margin-top: 3%;">
          				<label for="mobile">연락처</label>
      				</div>
      				<div class="col-md-3">
          				<input type="text" id="mobile" name="mobile" class="form-control" placeholder="가입시 입력하신 핸드폰번호" />
     				</div>
     			</div>
     			
				<div id="div_findResult" align="center">
					ID : <span style="color: red; font-size: 25pt; font-weight: bold;">${userid}</span> 
				</div> 		               
				<div class="row" style="margin-bottom: 1%">
					<div class="col-md-12" style="margin-left: 38%;" >
						<button type="button" id="btnFind" class="btn"><span style="font-size: 9pt;">아이디 찾기</span></button>
      				</div>
   				</div>
			</form>
		</div>
	</div>
</div>

<div class="gototop js-top">
   <a href="#" class="js-gotop"><i class="icon-arrow-up2"></i></a>
</div>
</body>
</html>
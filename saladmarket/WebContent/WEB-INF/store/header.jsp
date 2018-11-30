<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% String CtxPath = request.getContextPath(); %>
<!DOCTYPE HTML>
<html>
	<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<title>Market Sue</title>
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<meta name="description" content="" />
	<meta name="keywords" content="" />
	<meta name="author" content="" />

  <!-- Facebook and Twitter integration -->
	<meta property="og:title" content=""/>
	<meta property="og:image" content=""/>
	<meta property="og:url" content=""/>
	<meta property="og:site_name" content=""/>
	<meta property="og:description" content=""/>
	<meta name="twitter:title" content="" />
	<meta name="twitter:image" content="" />
	<meta name="twitter:url" content="" />
	<meta name="twitter:card" content="" />

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

	</head>
	<body>
		
	<div class="colorlib-loader"></div>

	<div id="page">
		<nav class="colorlib-nav" role="navigation">
			<div class="top-menu">
				<div class="container">
					<div class="row">
						<div class="col-xs-2">
							<div id="colorlib-logo"><a href="index.html"><img src="<%=CtxPath %>/store/images/index/logo.png" width="110%" height="110%"></a></div>
						</div>
						<div class="col-xs-10 text-right menu-1">
							<ul>
								<li class="active"><a href="index.html">Home</a></li>
								<li><a href="<%= CtxPath %>/login.do">로그인</a></li>
								<li><a href="">로그아웃</a></li>
								
								<%-- 181130 회원가입 만드는 중... --%>
								<li><a href="<%= CtxPath %>/memberRegister.do">회원가입</a></li>
								<li><a href=""></a></li>
								<li class="has-dropdown">
									<a href="">마이페이지</a>
									<ul class="dropdown">
										<li><a href="">회원정보</a></li>
										<li><a href="">할인쿠폰</a></li>
										<li><a href="">환불교환</a></li>
										<li><a href="">주문내역</a></li>
										<li><a href="">장바구니</a></li>
										<li><a href="">찜</a></li>
									</ul>
								</li>
								<li class="has-dropdown">
									<a href="">샐러드</a>
									<ul class="dropdown">
										<li><a href="">시리얼</a></li>
										<li><a href="">샐러드</a></li>
										<li><a href="">죽/스프</a></li>
									</ul>
								</li>
								<li class="has-dropdown">
									<a href="">디톡스</a>
									<ul class="dropdown">
										<li><a href="">물/주스</a></li>
										<li><a href="">건강즙</a></li>
										<li><a href="">건강차</a></li>
									</ul>
								</li>
								<li class="has-dropdown">
									<a href="">DIY</a>
									<ul class="dropdown">
										<li><a href="">야채/곡류</a></li>
										<li><a href="">과일</a></li>
										<li><a href="">고기/달걀</a></li>
										<li><a href="">생선</a></li>
										<li><a href="">소스</a></li>
										<li><a href="">유제품</a></li>
									</ul>
								</li>
								<li><a href="">EVENT</a></li>
								<li><a href=""><i class="icon-shopping-cart"></i> Cart [0]</a></li>
							</ul>
						</div>
					</div>
				</div>
			</div>
		</nav>
	<div class="contatin">
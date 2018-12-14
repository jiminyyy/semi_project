<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% String CtxPath = request.getContextPath(); %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
	
	
	<script type="text/javascript">
	
	$(document).ready(function(){
		
		$("#totalSearchWord").keydown(function(event){
			
			if(event.keyCode == 13) {

				goTotalSearch();
				
				return false;
			}
			
		}); // end of $("#searchWord").keydown(function(event){
			
		$("#totalSearchWord").val("${totalSearchWord}");
	
	});
		
		
	function goSearch(){
		
		var searchWord = $("#searchWord").val().trim();
		
		if(searchWord == "") {
			alert("검색어를 입력하세요!!");
			return;
		}
		else {
			var frm = document.memberFrm;
			frm.method = "GET";
			frm.action = "memberList.do";
			frm.submit();				
		}
		
	} // end of goSearch
		
	function goTotalSearch(){
		
		var totalSearchWord = $("#totalSearchWord").val().trim();
		
		if(totalSearchWord == "") {
			alert("검색어를 입력하세요!!");
			return;
		}
		else {
			var frm = document.totalSearchFrm;
			frm.method = "GET";
			frm.action = "totalSearchProductList.do";
			frm.submit();				
		}
	
	
	} // end of function goTotalSearch(){
	
	</script>

	</head>
	<body>
	
	<div class="colorlib-loader"></div>
		
   <div id="page">
      <nav class="colorlib-nav" role="navigation">
         <div class="top-menu">
            <div class="container">
               <div class="row">
                  <div class="col-xs-2">
                     <%-- <div id="colorlib-logo">
                        <a href="<%=CtxPath %>/index.do">
                           <img src="<%=CtxPath %>/store/images/index/logo.png" width="110%" height="110%">
                        </a>
                     </div> --%>
                  </div>
                  <div class="col-xs-10 text-right menu-1">
                     <ul>
                        <li class="active"><a href="<%=CtxPath %>/index.do">Home</a></li>
                        <c:if test="${sessionScope.loginuser == null }">
                           <li><a href="<%= CtxPath %>/login.do">로그인</a></li>
                           <li><a href="<%= CtxPath %>/memberRegister.do">회원가입</a></li>
                        </c:if>
                        
                        <c:if test="${sessionScope.loginuser != null }">
                           <li>[${sessionScope.loginuser.name }]님</li>
                           <li><a href="<%= CtxPath %>/logout.do">로그아웃</a></li>
                           <li class="has-dropdown">
                              <a href="<%= CtxPath %>/memberInfoMain.do">마이페이지</a>
                              <ul class="dropdown">
                                 <li><a href="<%= CtxPath %>/memberInfoMain.do">회원정보</a></li><!-- memberModify.jsp 비번 확인후 이곳으로 이동 -->
                                 <li><a href="<%= CtxPath %>/cuponList.do">할인쿠폰</a></li>
                                 <li><a href="<%= CtxPath %>/refundChange.do">환불교환</a></li>
                                 <li><a href="<%= CtxPath %>/orderList.do">주문내역</a></li>
                                 <li><a href="<%= CtxPath %>/cart.do">장바구니</a></li>
                                 <li><a href="<%= CtxPath %>/myPickList.do">찜</a></li>
                              </ul>
                           </li>
                        </c:if>
                       	<li class="has-dropdown">
                         	<a href="<%= CtxPath %>/productList.do?ldcode=1">샐러드</a>
                           <ul class="dropdown">
                              <li><a href="<%= CtxPath %>/productList.do?ldname=샐러드&sdcode=1">시리얼</a></li>
                              <li><a href="<%= CtxPath %>/productList.do?ldname=샐러드&sdcode=2">샐러드</a></li>
                              <li><a href="<%= CtxPath %>/productList.do?ldname=샐러드&sdcode=3">죽/스프</a></li>
                           </ul>
                        </li>
                        <li class="has-dropdown">
                           <a href="<%= CtxPath %>/productList.do?ldcode=2">디톡스</a>
                           <ul class="dropdown">
                              <li><a href="<%= CtxPath %>/productList.do?ldname=디톡스&sdcode=4">물/주스</a></li>
                              <li><a href="<%= CtxPath %>/productList.do?ldname=디톡스&sdcode=5">건강즙</a></li>
                              <li><a href="<%= CtxPath %>/productList.do?ldname=디톡스&sdcode=6">건강차</a></li>
                           </ul>
                        </li>
                        <li class="has-dropdown">
                           <a href="<%= CtxPath %>/productList.do?ldcode=3">DIY</a>
                           <ul class="dropdown">
                              <li><a href="<%= CtxPath %>/productList.do?ldname=DIY&sdcode=7">야채/곡류</a></li>
                              <li><a href="<%= CtxPath %>/productList.do?ldname=DIY&sdcode=8">과일</a></li>
                              <li><a href="<%= CtxPath %>/productList.do?ldname=DIY&sdcode=9">고기/달걀</a></li>
                              <li><a href="<%= CtxPath %>/productList.do?ldname=DIY&sdcode=10">생선</a></li>
                              <li><a href="<%= CtxPath %>/productList.do?ldname=DIY&sdcode=11">소스</a></li>
                              <li><a href="<%= CtxPath %>/productList.do?ldname=DIY&sdcode=12">유제품</a></li>
                           </ul>
                        </li>
                        <li><a href="">EVENT</a></li>
                        <li><a href=""><i class="icon-shopping-cart"></i> Cart [0]</a></li>
                     </ul>
                  </div><!-- menu -->
                  
                  <div style="margin-top: 5%;">
                     <div class="classynav">
                        <div class="col-xs-2">
                           <div id="colorlib-logo">
                              <a href="<%=CtxPath %>/index.do">
                                 <img src="<%=CtxPath %>/store/images/index/logo.png" width="110%" height="110%">
                              </a>
                           </div>
                        </div>
                        <div class="search-form">
                           <form name="totalSearchFrm">
                              <ul style="margin: 0 auto; float: right;">
                                 <li style="float: left;">
                                    <input type="text" id="totalSearchWord" name="totalSearchWord" placeholder="검색할 상품명을 입력하세요" style="border: 2px solid #b7b7b7; border-radius: 0; width: 300px; height: 50px; font-size: 15px; position: relative; top: 30%;" />
                                 	<input type="hidden" name="sizePerPage" value="8" />
                                 </li>
                                 
                                 <li style="float: left;">
                                    <button type="button" value="Submit" onClick="goTotalSearch();" style="height: 50px; border: none;">
                                       <img src="<%=CtxPath%>/store/images/search.png" style="width:20px; height:20px;"alt="">
                                    </button>
                                 </li>
                                 
                              </ul>
                           </form>
                        </div>
                     </div>
                  </div><!-- 여기까지 -->
               </div>
            </div>
         </div>
      </nav>
   <div class="contatin">
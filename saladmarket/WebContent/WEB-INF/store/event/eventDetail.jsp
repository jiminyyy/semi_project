<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% String CtxPath = request.getContextPath(); %>
<jsp:include page="../header.jsp" />


<%-- header End--%>	

		<aside id="colorlib-hero" class="breadcrumbs">
			<div class="flexslider">
				<ul class="slides">
			   	<li style="background-image: url(<%= CtxPath %>/store/images/cover-img-1.jpg);">
			   		<div class="overlay"></div>
			   		<div class="container-fluid">
			   			<div class="row">
				   			<div class="col-md-6 col-md-offset-3 col-sm-12 col-xs-12 slider-text">
				   				<div class="slider-text-inner text-center">
				   					<h1>Event Detail</h1>
				   					<h2 class="bread"><span><a href="index.jsp">Home</a></span></h2>
				   				</div>
				   			</div>
				   		</div>
			   		</div>
			   	</li>
			  	</ul>
		  	</div>
		</aside>
<div class="colorlib-shop" style="margin-bottom: 50px;">
			<div class="container" >
				<div class="row" align="center">
					<h3>이벤트명</h3>
					<hr style="border: 1px solid gray;">
				</div>
				<div class="row" >
				       	
					<div class="col-md-12">	
						<div class="row row-pb-lg">
						<%-- 제품 1 --%>
							<div class="col-md-3 text-center">
								<div class="product-entry">
									
									<div class="product-img">
									    <%-- 제품 이미지 넣기  --%>
										<img src="<%= CtxPath %>/store/images/index/NewYearSale.png" width="100%" height="100%"/>
										<%-- 태그명 넣기  --%>
										<p class="tag"><span class="new">BEST</span></p>
									
									    <%-- 이미지 하단 태그 --%>
										<div class="cart">
											<p>
											<%-- 장바구니 상세페이지 --%>
												<span class="addtocart"><a href="cart.html"><i class="icon-shopping-cart"></i></a></span> 
												<%-- 제품 상세페이지 --%>
												<span><a href="product-detail.html"><i class="icon-eye"></i></a></span> 
												<%-- 찜하기 --%>
												<span><a href="#"><i class="icon-heart3"></i></a></span>
												<%-- 찜하기 목록 상세페이지 --%>
												<span><a href="add-to-wishlist.html"><i class="icon-bar-chart"></i></a></span>
											</p>
										</div> 
										 <%-- 이미지 하단 태그 끝  --%>
									</div>
									<div class="desc">
										<h3><a href="product-detail.html">제품명</a></h3>
										<p class="price"><span>판매가</span>
										<br/><span class="sale">원가</span>
										<br/><span >포인트 </span>
										</p>
									</div>
								</div>
							</div>
							<%-- 제품 1끝 --%>
							<%-- 제품 2 --%>
							<div class="col-md-3 text-center">
								<div class="product-entry">
								<div class="product-img">
										<img src="<%= CtxPath %>/store/images/index/NewYearSale.png" width="100%" height="100%"/>
										<p class="tag"><span class="sale">HIT</span></p>
										    <%-- 이미지 하단 태그 --%>
										<div class="cart">
											<p>
												<%-- 장바구니 상세페이지--%>
												<span class="addtocart"><a href="cart.html"><i class="icon-shopping-cart"></i></a></span> 
												<%-- 제품 상세페이지--%>
												<span><a href="product-detail.html"><i class="icon-eye"></i></a></span> 
												<%-- 찜하기--%>
												<span><a href="#"><i class="icon-heart3"></i></a></span>
												<%-- 찜하기 목록 상세페이지--%>
												<span><a href="add-to-wishlist.html"><i class="icon-bar-chart"></i></a></span>
											</p>
										</div>
										 <%-- 이미지 하단 태그 끝  --%>
									</div>
									<div class="desc">
										<%-- 제품 상세 페이지 --%>
										<h3><a href="product-detail.html">제품명</a></h3>
										<p class="price"><span>판매가</span>
										<br/><span class="sale">원가</span>
										<br/><span >포인트 </span>
										</p>
									</div>
								</div>
							</div>
							<%-- 제품 2끝 --%>
							<%--제품 3 --%>
							<div class="col-md-3 text-center">
								<div class="product-entry">
								<div class="product-img">
										<img src="<%= CtxPath %>/store/images/index/NewYearSale.png" width="100%" height="100%"/>
										<p class="tag"><span class="new">New</span></p>
										<%-- 이미지 하단 태그 --%>
										<div class="cart">
											<p>
												<%-- 장바구니 상세페이지--%>
												<span class="addtocart"><a href="cart.html"><i class="icon-shopping-cart"></i></a></span> 
												<%-- 제품 상세페이지--%>
												<span><a href="product-detail.html"><i class="icon-eye"></i></a></span> 
												<%-- 찜하기--%>
												<span><a href="#"><i class="icon-heart3"></i></a></span>
												<%-- 찜하기 목록 상세페이지--%>
												<span><a href="add-to-wishlist.html"><i class="icon-bar-chart"></i></a></span>
											</p>
										</div>
										 <%-- 이미지 하단 태그 끝  --%>
									</div>
									<div class="desc">
										<h3><a href="product-detail.html">Floral Dress</a></h3>
										<p class="price"><span>판매가</span>
										<br/><span class="sale">원가</span>
										<br/><span >포인트 </span>
										</p>
									</div>
								</div>
							</div>
						<%--제품 3끝 --%>
						<%--제품 4 --%>
							<div class="col-md-3 text-center">
								<div class="product-entry">
								<div class="product-img">
										<img src="<%= CtxPath %>/store/images/index/NewYearSale.png" width="100%" height="100%"/>
										<p class="tag"><span class="new">New</span></p>
										<%-- 이미지 하단 태그 --%>
										<div class="cart">
											<p>
												<%-- 장바구니 상세페이지--%>
												<span class="addtocart"><a href="cart.html"><i class="icon-shopping-cart"></i></a></span> 
												<%-- 제품 상세페이지--%>
												<span><a href="product-detail.html"><i class="icon-eye"></i></a></span> 
												<%-- 찜하기--%>
												<span><a href="#"><i class="icon-heart3"></i></a></span>
												<%-- 찜하기 목록 상세페이지--%>
												<span><a href="add-to-wishlist.html"><i class="icon-bar-chart"></i></a></span>
											</p>
										</div> 
										 <%-- 이미지 하단 태그 끝  --%>
									</div>
									<div class="desc">
										<h3><a href="product-detail.html">Floral Dress</a></h3>
										<p class="price"><span>판매가</span>
										<br/><span class="sale">원가</span>
										<br/><span >포인트 </span>
										</p>
									</div>
								</div>
							</div>
						<%--제품 4 끝 --%>
				</div>
			</div>
		</div>
	</div>
</div>

		
<jsp:include page="../footer.jsp" />
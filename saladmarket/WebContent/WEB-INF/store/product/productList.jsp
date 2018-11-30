<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% String CtxPath = request.getContextPath(); %>

<jsp:include page="../header.jsp"/>

<style>
.tab button {
	    background-color: inherit;
	    float: center;
	    border: none;
	    outline: none;
	    cursor: pointer;
	    padding: 14px 16px;
	    transition: 0.3s;
	    font-size: 17px;
	}
	
	/* Change background color of buttons on hover */
	.tab button:hover {
	    /*background-color: #ddd;*/
	    border-bottom: 5px solid #FFC300;
	}
	
	/* Create an active/current tablink class */
	.tab button.active {
	     border-bottom: 5px solid #FFC300;
	}
	
	/* Style the tab content */
	.tabcontent {
	    display: none;
	    padding: 6px 12px;
	    border: 0px solid #ccc;
	    border-top: none;
	}


</style>

<script>
   function openCity(evt, cityName) {
       var i, tabcontent, tablinks;
       tabcontent = document.getElementsByClassName("tabcontent");
       for (i = 0; i < tabcontent.length; i++) {
           tabcontent[i].style.display = "none";
       }
       tablinks = document.getElementsByClassName("tablinks");
       for (i = 0; i < tablinks.length; i++) {
           tablinks[i].className = tablinks[i].className.replace(" active", "");
       }
       document.getElementById(cityName).style.display = "block";
       evt.currentTarget.className += " active";
   }
   
   window.innerWidth
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
		   					<h1>Shop</h1>
		   					<h2 class="bread">
			   					<span style="font-size: 13pt;"><a href="#">Home</a></span>
			   					<span style="font-size: 13pt;">ProductList</span>
		   					</h2>
		   				</div>
		   			</div>
		   		</div>
	   		</div>
	   	</li>
	  	</ul>
  	</div>
</aside>

<div style="overflow: hidden; width: 100%; border-bottom: 0px solid #b7b7b7; padding-bottom: 50px;">

<%-- 스펙태그 시작 --%>
   <div align="center" style=" margin-top: 50px;">
      <div style="width: 70%;">
			<div class="tab" style="margin-bottom: 50px;"><!-- 각 태그별 상품 이미지는 8개씩!!!! -->
		        <button class="tablinks active" onclick="openCity(event, 'BEST')">BEST</button>
		        <button class="tablinks" onclick="openCity(event, 'HIT')">HIT</button>
		        <button class="tablinks" onclick="openCity(event, 'NEW')">NEW</button>
			</div>
      
			<div id="BEST" class="tabcontent" style="display: block;">
				<div id="page">
					<div class="colorlib-shop">
						<div class="row">
							<div class="col-md-3 text-center">
								<div class="product-entry">
									<div class="product-img" style="background-image: url(<%=CtxPath%>/store/images/item-9.jpg);">
										<p class="tag"><span class="sale">Best</span></p><!-- sale이라는 클래스가 디자인이 걸려 있어서 그냥 클래스는 sale로 할께요 -->
				                        <div class="cart">
				                           <p>
				                              <span class="addtocart"><a href="cart.html"><i class="icon-shopping-cart"></i></a></span> 
				                              <span><a href="product-detail.html"><i class="icon-eye"></i></a></span> 
				                              <span><a href="#"><i class="icon-heart3"></i></a></span>
				                              <span><a href="add-to-wishlist.html"><i class="icon-bar-chart"></i></a></span>
				                           </p>
				                        </div>
                    				</div>
				                    <div class="desc">
				                       <h3><a href="shop.html">Floral Dress</a></h3>
				                       <p class="price"><span>$199.00</span> <span class="sale">$300.00</span> </p>
				                    </div>
                  				</div>
               				</div>
               
               				<div class="col-md-3 text-center">
                  				<div class="product-entry">
                     				<div class="product-img" style="background-image: url(<%=CtxPath%>/store/images/item-10.jpg);">
                        				<p class="tag"><span class="sale">Best</span></p>
                        				<div class="cart">
				                           <p>
				                              <span class="addtocart"><a href="cart.html"><i class="icon-shopping-cart"></i></a></span> 
				                              <span><a href="product-detail.html"><i class="icon-eye"></i></a></span> 
				                              <span><a href="#"><i class="icon-heart3"></i></a></span>
				                              <span><a href="add-to-wishlist.html"><i class="icon-bar-chart"></i></a></span>
				                           </p>
				                        </div>
                     				</div>
				                     <div class="desc">
				                        <h3><a href="shop.html">Floral Dress</a></h3>
				                        <p class="price"><span>$300.00</span></p>
				                     </div>
                  				</div>
               				</div>
               
			               <div class="col-md-3 text-center">
			                  <div class="product-entry">
			                     <div class="product-img" style="background-image: url(<%=CtxPath%>/store/images/item-11.jpg);">
			                        <p class="tag"><span class="sale">Best</span></p>
			                        <div class="cart">
			                           <p>
			                              <span class="addtocart"><a href="cart.html"><i class="icon-shopping-cart"></i></a></span> 
			                              <span><a href="product-detail.html"><i class="icon-eye"></i></a></span> 
			                              <span><a href="#"><i class="icon-heart3"></i></a></span>
			                              <span><a href="add-to-wishlist.html"><i class="icon-bar-chart"></i></a></span>
			                           </p>
			                        </div>
			                     </div>
			                     <div class="desc">
			                        <h3><a href="shop.html">Floral Dress</a></h3>
			                        <p class="price"><span>$300.00</span></p>
			                     </div>
			                  </div>
			               </div>
               
			               <div class="col-md-3 text-center">
			                  <div class="product-entry">
			                     <div class="product-img" style="background-image: url(<%=CtxPath%>/store/images/item-12.jpg);">
			                        <p class="tag"><span class="new">New</span></p>
			                        <div class="cart">
			                           <p>
			                              <span class="addtocart"><a href="cart.html"><i class="icon-shopping-cart"></i></a></span> 
			                              <span><a href="product-detail.html"><i class="icon-eye"></i></a></span> 
			                              <span><a href="#"><i class="icon-heart3"></i></a></span>
			                              <span><a href="add-to-wishlist.html"><i class="icon-bar-chart"></i></a></span>
			                           </p>
			                        </div>
			                     </div>
			                     <div class="desc">
			                        <h3><a href="shop.html">Floral Dress</a></h3>
			                        <p class="price"><span>$300.00</span></p>
			                     </div>
			                  </div>
			               </div>
               
			               <div class="col-md-3 text-center">
			                  <div class="product-entry">
			                     <div class="product-img" style="background-image: url(<%=CtxPath%>/store/images/item-13.jpg);">
			                        <p class="tag"><span class="sale">Best</span></p>
			                        <div class="cart">
			                           <p>
			                              <span class="addtocart"><a href="cart.html"><i class="icon-shopping-cart"></i></a></span> 
			                              <span><a href="product-detail.html"><i class="icon-eye"></i></a></span> 
			                              <span><a href="#"><i class="icon-heart3"></i></a></span>
			                              <span><a href="add-to-wishlist.html"><i class="icon-bar-chart"></i></a></span>
			                           </p>
			                        </div>
			                     </div>
			                     <div class="desc">
			                        <h3><a href="shop.html">Floral Dress</a></h3>
			                        <p class="price"><span>$300.00</span></p>
			                     </div>
			                  </div>
			               </div>
               
			               <div class="col-md-3 text-center">
			                  <div class="product-entry">
			                     <div class="product-img" style="background-image: url(<%=CtxPath%>/store/images/item-14.jpg);">
			                        <p class="tag"><span class="sale">Best</span></p>
			                        <div class="cart">
			                           <p>
			                              <span class="addtocart"><a href="cart.html"><i class="icon-shopping-cart"></i></a></span> 
			                              <span><a href="product-detail.html"><i class="icon-eye"></i></a></span> 
			                              <span><a href="#"><i class="icon-heart3"></i></a></span>
			                              <span><a href="add-to-wishlist.html"><i class="icon-bar-chart"></i></a></span>
			                           </p>
			                        </div>
			                     </div>
			                     <div class="desc">
			                        <h3><a href="shop.html">Floral Dress</a></h3>
			                        <p class="price"><span>$300.00</span></p>
			                     </div>
			                  </div>
			               </div>
               
			               <div class="col-md-3 text-center">
			                  <div class="product-entry">
			                     <div class="product-img" style="background-image: url(<%=CtxPath%>/store/images/item-15.jpg);">
			                        <p class="tag"><span class="sale">Best</span></p>
			                        <div class="cart">
			                           <p>
			                              <span class="addtocart"><a href="cart.html"><i class="icon-shopping-cart"></i></a></span> 
			                              <span><a href="product-detail.html"><i class="icon-eye"></i></a></span> 
			                              <span><a href="#"><i class="icon-heart3"></i></a></span>
			                              <span><a href="add-to-wishlist.html"><i class="icon-bar-chart"></i></a></span>
			                           </p>
			                        </div>
			                     </div>
			                     <div class="desc">
			                        <h3><a href="shop.html">Floral Dress</a></h3>
			                        <p class="price"><span>$300.00</span></p>
			                     </div>
			                  </div>
			               </div>
               
			               <div class="col-md-3 text-center">
			                  <div class="product-entry">
			                     <div class="product-img" style="background-image: url(<%=CtxPath%>/store/images/item-16.jpg);">
			                        <p class="tag"><span class="sale">Best</span></p>
			                        <div class="cart">
			                           <p>
			                              <span class="addtocart"><a href="cart.html"><i class="icon-shopping-cart"></i></a></span> 
			                              <span><a href="product-detail.html"><i class="icon-eye"></i></a></span> 
			                              <span><a href="#"><i class="icon-heart3"></i></a></span>
			                              <span><a href="add-to-wishlist.html"><i class="icon-bar-chart"></i></a></span>
			                           </p>
			                        </div>
			                     </div>
			                     <div class="desc">
			                        <h3><a href="shop.html">Floral Dress</a></h3>
			                        <p class="price"><span>$300.00</span></p>
			                     </div>
			                  </div>
			               </div>
            			</div>
         			</div>
      			</div>
   			</div><!-- Best Product -->
		</div>
	</div> <%-- 스펙태그  끝 --%>
</div> <!-- horizontal -->
<!-- Navbar Area-->

<div class="classy-nav-container breakpoint-off">
	<div class="container">
		<!-- Menu -->
		<nav class="classy-navbar" id="foodeNav">
			<!-- Navbar Toggler -->
			<div class="classy-navbar-toggler">
				<span class="navbarToggler"><span></span><span></span><span></span></span>
			</div>
		
			<!-- Nav Start -->
			<div class="classynav">
				<div class="search-form" >
					<form action="#" method="get">
						<ul style="margin: 0 auto;">
							<li style="float: left;">
								<input type="search" placeholder="검색할 상품명을 입력하세요" style="border: 2px solid #b7b7b7; border-radius: 0; width: 600px; height: 50px; font-size: 15px; position: relative; top: 30%;" >
							</li>
							
							<li style="float: left;">
								<button type="submit" value="Submit" style="height: 50px; border: none;">
									<img src="<%=CtxPath%>/store/images/search.png" style="width:20px; height:20px;"alt="">
								</button>
							</li>
							
							<li style="float: right;">
								<div class="dropdown">
									<button class="btn dropdown-toggle" type="button" data-toggle="dropdown" style="border-radius: 0; height: 50px; background-color: #FFC300;">정렬<span class="caret"></span></button>
									<ul class="dropdown-menu">
										<li><a href="#">이름순</a></li>
										<li><a href="#">인기순</a></li>
										<li><a href="#">신상품순</a></li>
										<li><a href="#">가격순</a></li>
									</ul>
								</div>
							</li>
						</ul>
					</form>
				</div>
			</div>
		</nav>
	</div>
</div><!-- 검색창 -->

<!-- 상품 List  -->
<div align="center" class=" col-md-offset-2 col-md-8" style="margin-top: 50px; display: block;">
    <div id="page">
         <div class="colorlib-shop">
            <div class="row">
               <div class="col-md-3 text-center">
                  <div class="product-entry">
                     <div class="product-img" style="background-image: url(<%=CtxPath%>/store/images/item-9.jpg);">
                        <p class="tag"><span class="sale">Best</span></p><!-- sale이라는 클래스가 디자인이 걸려 있어서 그냥 클래스는 sale로 할께요 -->
                        <div class="cart">
                           <p>
                              <span class="addtocart"><a href="cart.html"><i class="icon-shopping-cart"></i></a></span> 
                              <span><a href="product-detail.html"><i class="icon-eye"></i></a></span> 
                              <span><a href="#"><i class="icon-heart3"></i></a></span>
                              <span><a href="add-to-wishlist.html"><i class="icon-bar-chart"></i></a></span>
                           </p>
                        </div>
                     </div>
                     <div class="desc">
                        <h3><a href="shop.html">Floral Dress</a></h3>
                        <p class="price"><span>$199.00</span> <span class="sale">$300.00</span> </p>
                     </div>
                  </div>
               </div>
               
               <div class="col-md-3 text-center">
                  <div class="product-entry">
                     <div class="product-img" style="background-image: url(<%=CtxPath%>/store/images/item-10.jpg);">
                        <p class="tag"><span class="sale">Best</span></p>
                        <div class="cart">
                           <p>
                              <span class="addtocart"><a href="cart.html"><i class="icon-shopping-cart"></i></a></span> 
                              <span><a href="product-detail.html"><i class="icon-eye"></i></a></span> 
                              <span><a href="#"><i class="icon-heart3"></i></a></span>
                              <span><a href="add-to-wishlist.html"><i class="icon-bar-chart"></i></a></span>
                           </p>
                        </div>
                     </div>
                     <div class="desc">
                        <h3><a href="shop.html">Floral Dress</a></h3>
                        <p class="price"><span>$300.00</span></p>
                     </div>
                  </div>
               </div>
               
               <div class="col-md-3 text-center">
                  <div class="product-entry">
                     <div class="product-img" style="background-image: url(<%=CtxPath%>/store/images/item-11.jpg);">
                        <p class="tag"><span class="sale">Best</span></p>
                        <div class="cart">
                           <p>
                              <span class="addtocart"><a href="cart.html"><i class="icon-shopping-cart"></i></a></span> 
                              <span><a href="product-detail.html"><i class="icon-eye"></i></a></span> 
                              <span><a href="#"><i class="icon-heart3"></i></a></span>
                              <span><a href="add-to-wishlist.html"><i class="icon-bar-chart"></i></a></span>
                           </p>
                        </div>
                     </div>
                     <div class="desc">
                        <h3><a href="shop.html">Floral Dress</a></h3>
                        <p class="price"><span>$300.00</span></p>
                     </div>
                  </div>
               </div>
               
               <div class="col-md-3 text-center">
                  <div class="product-entry">
                     <div class="product-img" style="background-image: url(<%=CtxPath%>/store/images/item-12.jpg);">
                        <p class="tag"><span class="new">New</span></p>
                        <div class="cart">
                           <p>
                              <span class="addtocart"><a href="cart.html"><i class="icon-shopping-cart"></i></a></span> 
                              <span><a href="product-detail.html"><i class="icon-eye"></i></a></span> 
                              <span><a href="#"><i class="icon-heart3"></i></a></span>
                              <span><a href="add-to-wishlist.html"><i class="icon-bar-chart"></i></a></span>
                           </p>
                        </div>
                     </div>
                     <div class="desc">
                        <h3><a href="shop.html">Floral Dress</a></h3>
                        <p class="price"><span>$300.00</span></p>
                     </div>
                  </div>
               </div>
               
               <div class="col-md-3 text-center">
                  <div class="product-entry">
                     <div class="product-img" style="background-image: url(<%=CtxPath%>/store/images/item-13.jpg);">
                        <p class="tag"><span class="sale">Best</span></p>
                        <div class="cart">
                           <p>
                              <span class="addtocart"><a href="cart.html"><i class="icon-shopping-cart"></i></a></span> 
                              <span><a href="product-detail.html"><i class="icon-eye"></i></a></span> 
                              <span><a href="#"><i class="icon-heart3"></i></a></span>
                              <span><a href="add-to-wishlist.html"><i class="icon-bar-chart"></i></a></span>
                           </p>
                        </div>
                     </div>
                     <div class="desc">
                        <h3><a href="shop.html">Floral Dress</a></h3>
                        <p class="price"><span>$300.00</span></p>
                     </div>
                  </div>
               </div>
               
               <div class="col-md-3 text-center">
                  <div class="product-entry">
                     <div class="product-img" style="background-image: url(<%=CtxPath%>/store/images/item-14.jpg);">
                        <p class="tag"><span class="sale">Best</span></p>
                        <div class="cart">
                           <p>
                              <span class="addtocart"><a href="cart.html"><i class="icon-shopping-cart"></i></a></span> 
                              <span><a href="product-detail.html"><i class="icon-eye"></i></a></span> 
                              <span><a href="#"><i class="icon-heart3"></i></a></span>
                              <span><a href="add-to-wishlist.html"><i class="icon-bar-chart"></i></a></span>
                           </p>
                        </div>
                     </div>
                     <div class="desc">
                        <h3><a href="shop.html">Floral Dress</a></h3>
                        <p class="price"><span>$300.00</span></p>
                     </div>
                  </div>
               </div>
               
               <div class="col-md-3 text-center">
                  <div class="product-entry">
                     <div class="product-img" style="background-image: url(<%=CtxPath%>/store/images/item-15.jpg);">
                        <p class="tag"><span class="sale">Best</span></p>
                        <div class="cart">
                           <p>
                              <span class="addtocart"><a href="cart.html"><i class="icon-shopping-cart"></i></a></span> 
                              <span><a href="product-detail.html"><i class="icon-eye"></i></a></span> 
                              <span><a href="#"><i class="icon-heart3"></i></a></span>
                              <span><a href="add-to-wishlist.html"><i class="icon-bar-chart"></i></a></span>
                           </p>
                        </div>
                     </div>
                     <div class="desc">
                        <h3><a href="shop.html">Floral Dress</a></h3>
                        <p class="price"><span>$300.00</span></p>
                     </div>
                  </div>
               </div>
               
               <div class="col-md-3 text-center">
                  <div class="product-entry">
                     <div class="product-img" style="background-image: url(<%=CtxPath%>/store/images/item-16.jpg);">
                        <p class="tag"><span class="sale">Best</span></p>
                        <div class="cart">
                           <p>
                              <span class="addtocart"><a href="cart.html"><i class="icon-shopping-cart"></i></a></span> 
                              <span><a href="product-detail.html"><i class="icon-eye"></i></a></span> 
                              <span><a href="#"><i class="icon-heart3"></i></a></span>
                              <span><a href="add-to-wishlist.html"><i class="icon-bar-chart"></i></a></span>
                           </p>
                        </div>
                     </div>
                     <div class="desc">
                        <h3><a href="shop.html">Floral Dress</a></h3>
                        <p class="price"><span>$300.00</span></p>
                     </div>
                  </div>
               </div>
            </div>
         </div>
      </div>
</div>
<!--   -->
   
<jsp:include page="../footer.jsp"/>
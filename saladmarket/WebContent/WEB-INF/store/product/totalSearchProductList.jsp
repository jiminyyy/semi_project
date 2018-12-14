<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% String CtxPath = request.getContextPath(); %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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

$(document).ready(function(){
	
	var code = "";
	var ldname = "0";
	if(${ldcode == '0'}){
		code = "${sdcode}";
		ldname = "${ldname}";
		
		goSearch(code, ldname, "", "1");
	}
	if(${ldcode != '0'}) {
		code = "${ldcode}";
		
		goSearch(code, ldname, "", "1");
	}
	
	openSpec("${spec}");
	
	$("#searchWord").keydown(function(event){
		
		if(event.keyCode == 13) {

			var code = "";
			var ldname = "0";
			if(${ldcode == '0'}){
				code = "${sdcode}";
				ldname = "${ldname}";
				
				goSearch(code, ldname, $('#searchWord').val(), '1');
			}
			if(${ldcode != '0'}) {
				code = "${ldcode}";
				
				goSearch(code, ldname, $('#searchWord').val(), '1');
			}
			
			return false;
		}
		
	}); // end of $("#loginPwd").keydown(function(event){
	
});

							
							   resultHTML += "<div class='col-md-3 text-center'>" +
								   			 "<div class='product-entry'>" +
				      		                 "<div class='product-img' style='background-image: url(img/"+entry.pacimage+");'>" +
				      		                 "<p class='tag'><span class='sale'>"+entry.stname+"</span></p>" +
				      		                 "<div class='cart'>" +
				      		                 "<p>" +
					      		             "<span class='addtocart'><a href='cart.html'><i class='icon-shopping-cart'></i></a></span>" +
				      		                 "<span><a href='product-detail.html'><i class='icon-eye'></i></a></span>" +
				      		                 "<span><a href='#'><i class='icon-heart3'></i></a></span>" +
				      	                     "<span><a href='add-to-wishlist.html'><i class='icon-bar-chart'></i></a></span>" +
				      	                     "</p>" + 
				      	                     "</div>" +
				      	                     "</div>" +
				      	                     "<div class='desc'>" + 
				      	                     "<h3><a href='<%=CtxPath%>/productDetail.do'>"+entry.prodname+"</a></h3>" +
				      	                     "<p class='price' style='font-weight: bold;'><span>"+entry.saleprice+"원</span>&nbsp;<span class='sale'>"+entry.price+"원</span></p>" +
				      	                   	 "</div>" +
				      	                     "</div>" +
				      	                   	 "</div>";
				      	        /* 
				      	        if( (entryIndex+1)%4 == 0 ) {
												html += "<br/>";
											}
				      	         */
				      	        if ( (entryIndex+1)%4 == 0){
									
									resultHTML += "<tr>" +
												  "<td colspan='4'>&nbsp;&nbsp;</td>"+
				                        		  "</tr>";
								}				      	                 
				      	            
						 });// end of $.each(data, function(entryIndex, entry){ })-------------------
							 	
						 $("#result").empty().html(resultHTML);
							 
						 makePageBar(code, name, word, pageNo);
					}
					else { // 검색된 데이터가 없는 경우
						 $("#result").empty();
					}

				},// end of success: function()------
				error: function(request, status, error){
					alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
				}
			});// end of $.ajax()------------------------
			
	}// end of goSearch(pageNo)-----------------------------

   
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
                           <span style="font-size: 13pt;"><a href="<%=CtxPath %>/index.do">Home</a></span>
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

<div class="classy-nav-container breakpoint-off" >
   <div class="container">
      <!-- Menu -->
      <nav class="classy-navbar" id="foodeNav">
         <!-- Navbar Toggler -->
         <div class="classy-navbar-toggler">
            <span class="navbarToggler"><span></span><span></span><span></span></span>
         </div>
      
         <!-- Nav Start -->
         <div class="classynav">
            <ul>
               <li style="float: right;">
                  <div class="dropdown">
                     <button type="button" class="btn dropdown-toggle" type="button" data-toggle="dropdown" style="border-radius: 0; height: 50px; background-color: #FFC300;">정렬<span class="caret"></span></button>
                     <ul class="dropdown-menu">
                        <li><a href="#">이름순</a></li>
                        <li><a href="#">인기순</a></li>
                        <li><a href="#">신상품순</a></li>
                        <li><a href="#">가격순</a></li>
                     </ul>
                  </div>
               </li>
            </ul>
         </div>
      </nav>
   </div>
</div><!-- 검색창 -->

<!-- 상품 List  -->
<div align="center" class=" col-md-offset-2 col-md-8" style="margin-top: 50px; display: block;">
    <div id="page">
         <div class="colorlib-shop">
            <div class="row">
               <div class = "row" align="center"></div>
					<div class="col-md-3 text-center">
						<c:forEach var="map" items="${productList}">
						<div class="product-entry">
				      		<div class="product-img" style="background-image: url(img/${map.pacimage});">
				      			<p class="tag">
				      				<span class="sale">${map.stname}</span>
				      			</p>
				      		    <div class="cart">
				      		    <p>
					      			<span class="addtocart"><a href="cart.html"><i class='icon-shopping-cart'></i></a></span>
				      		        <span><a href="product-detail.html"><i class="icon-eye"></i></a></span>
				      		        <span><a href="#"><i class="icon-heart3"></i></a></span>
				      	            <span><a href="add-to-wishlist.html"><i class="icon-bar-chart"></i></a></span>
				      	            </p>
				      	        </div>
				      	    </div>
				      	    <div class="desc"> 
				      	    	<h3><a href="<%=CtxPath%>/productDetail.do">${map.prodname}</a></h3>
				      	        <p class="price" style="font-weight: bold;"><span>${map.saleprice}원</span>&nbsp;<span class="sale">${map.price}원</span></p>
				      	    </div>
				      	 </div>
				      	 </c:forEach>
				     </div>
               <div id="pageBar" class="col-md-12 text-center">
               ${pageBar}
               </div>
            </div>
         </div>
      </div>
	</div>
</div>
<!--   -->
   
<jsp:include page="../footer.jsp"/>
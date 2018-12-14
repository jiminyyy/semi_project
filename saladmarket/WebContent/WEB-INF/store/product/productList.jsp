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
		
	}); // end of $("#searchWord").keydown(function(event){
	
});

   
	function openSpec(spec) {
		
		var code = "";
		var ldname = "0";
		var form_data = "";
		
		if(${ldcode == '0'}){
			
			console.log("${sdcode}");
			form_data = {spec:spec, sdcode:"${sdcode}", ldname:"${ldname}"};
		}
		if(${ldcode != '0'}) {
			form_data = {spec:spec, ldcode:"${ldcode}", ldname:"${ldname}"};
		}
		
		$.ajax({
				url: "specResultJSON.do",
				type: "GET",
				data: form_data,  // 위의 URL 페이지로 사용자가 보내는 ajax 요청 데이터.
				dataType: "JSON", // ajax 요청에 의해 URL 페이지 서버로 부터 리턴받는 데이터 타입. xml, json, html, script, text 이 있음.
				success: function(data){
											
					if(data.length > 0) { // 검색된 데이터가 있는 경우임. 만약에 조회된 데이터가 없을 경우 if(data == null) 이 아니고 if(data.length == 0) 이라고 써야 한다. 
						                  // 왜냐하면  넘겨준 값이 new JSONArray() 이므로 null 이 아니기 때문이다..
					     var resultHTML = "";
					
						 $.each(data, function(entryIndex, entry){
							
							 resultHTML += 
							   			   "<div class='col-md-3 text-center'>" +
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
			      	                       "</div>" +
			      	                       "</div>" +
			      	                	   "</div>" +
			      	                       "</div>" +
			      	                   	   "</div>";

			      	        if ( (entryIndex+1)%4 == 0){
								
								resultHTML += "<tr>" +
											  "<td colspan='4'>&nbsp;&nbsp;</td>"+
			                        		  "</tr>";
							}				      	                 
      	            
		 				});// end of $.each(data, function(entryIndex, entry){ })-------------------
			 	
						 $("#specResult").empty().html(resultHTML);
						
					}
					else { // 검색된 데이터가 없는 경우
						 $("#specResult").empty();
					}
				
				},// end of success: function()------
				error: function(request, status, error){
					alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
				}
			});// end of $.ajax()------------------------
			
	}// end of goSearch(pageNo)-----------------------------
   
	function goSearch(code, name, word, pageNo) {
		
		var form_data = { code:code, ldname:name, searchword:word, currentShowPageNo:pageNo };
			
		$.ajax({
				url: "searchResultJSON.do",
				type: "GET",
				data: form_data,  // 위의 URL 페이지로 사용자가 보내는 ajax 요청 데이터.
				dataType: "JSON", // ajax 요청에 의해 URL 페이지 서버로 부터 리턴받는 데이터 타입. xml, json, html, script, text 이 있음.
				success: function(data){
											
					if(data.length > 0) { // 검색된 데이터가 있는 경우임. 만약에 조회된 데이터가 없을 경우 if(data == null) 이 아니고 if(data.length == 0) 이라고 써야 한다. 
						                  // 왜냐하면  넘겨준 값이 new JSONArray() 이므로 null 이 아니기 때문이다..
					     var resultHTML = "";
					
						 $.each(data, function(entryIndex, entry){
							
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
	
	function makePageBar(code, name, word, currentShowPageNo) {
		
		var form_data = {code:code,  
						 ldname:name,      // 키:밸류
				         searchword:word,   // 키:밸류
				         sizePerPage:"8"};  // 키:밸류
		
		$.ajax({
				url: "searchPageBarJSON.do",
				type: "GET",
				data: form_data,  // 위의 URL 페이지로 사용자가 보내는 ajax 요청 데이터.
				dataType: "JSON", // ajax 요청에 의해 URL 페이지 서버로 부터 리턴받는 데이터 타입. xml, json, html, script, text 이 있음.
				success: function(data){
										
					if(data.totalPage != 0) { 
						
					     var totalPage = data.totalPage;
					     var pageBarHTML = "";
						 
					     /////////////////////////
					     
					     var blockSize = 3;
					     var loop = 1;
	                     
	                     var pageNo = Math.floor((currentShowPageNo - 1)/blockSize) * blockSize + 1; 
				 
						 // *** [이전] 만들기 *** //
					      if(pageNo != 1) {
					    	  pageBarHTML += "<a href='javascript:goSearch(\""+code+"\" , \""+name+"\" , \""+word+"\" , \""+(pageNo-1)+"\")'>[이전]</a>";
					      }
					     
	                     /////////////////////////////////////////////////
					      while( !(loop > blockSize || pageNo > totalPage) ) {
					       	 
					    	  if(pageNo == currentShowPageNo) {
					    		  pageBarHTML += "&nbsp;<span style=\"color: red; font-size: 12pt; font-weight: bold; text-decoration: underline; \">"+pageNo+"</span>&nbsp;";
					    	  }
					    	  else {
					    	  	  pageBarHTML += "&nbsp;<a href='javascript:goSearch(\""+code+"\" , \""+name+"\" , \""+word+"\" , \""+pageNo+"\")'>"+pageNo+"</a>&nbsp;";
					     	  }
	                     
					       	 loop++;
					    	 pageNo++;
					      } // end of while-----------------------------------
                         /////////////////////////////////////////////////

					  	  // *** [다음] 만들기 *** //
					     if( !(pageNo > totalPage) ) {
					    	 pageBarHTML += "&nbsp;<a href='javascript:goSearch(\""+code+"\" , \""+name+"\" , \""+word+"\" , \""+pageNo+"\")'>[다음]</a>";
					     }
						 	
					     $("#pageBar").empty().html(pageBarHTML);
					     
					     pageBarHTML = "";
					}
					
					else { // 검색된 데이터가 없는 경우
						 $("#pageBar").empty();
					}

				},// end of success: function()------
				error: function(request, status, error){
					alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
				}
			});// end of $.ajax()-------------------
		
	}// end of makePageBar(startPageNo)--------------------------
   
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

<div style="overflow: hidden; width: 100%; border-bottom: 0px solid #b7b7b7;">

<%-- 스펙태그 시작 --%>
	<div align="center" style=" margin-top: 50px;">
			<div style="width: 70%;">
			<div class="tab" style="margin-bottom: 50px;"><!-- 각 태그별 상품 이미지는 8개씩!!!! -->
		        <button type="button" class="tablinks best" onclick="openSpec('BEST');">BEST</button>
		        <button type="button" class="tablinks hit" onclick="openSpec('HIT');">HIT</button>
		        <button type="button" class="tablinks new" onclick="openSpec('NEW');">NEW</button>
			</div>
			<div class='tabcontent' style="display: block;">
			   <div id="page">
				<div class="colorlib-shop">
					<div class="row">
						<div id="specResult">
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	</div> <%-- 스펙태그  끝 --%>
			


<%-- <div align="center" style=" margin-top: 50px; ">
      <div style="width: 70%;">
      <div class="tab" style="margin-left: 4% " align="left"><!-- 각 태그별 상품 이미지는 8개씩!!!! -->
         <c:forEach  var="smproduct" items="${smallList}">
              <button class="tablinks active" onclick="openCity(event, 'BEST')">${smproduct.sdname}</button>&nbsp;&nbsp;&nbsp;
         </c:forEach>
      </div>
   </div> 
</div> --%>
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
            <div class="col-md-offset-3 col-md-6 search-form">
               <form action="#" method="get">
                  <ul style="border: 0px solid gray;">
                     <li style="float: center; ">
                        <input type="text" id="searchWord" placeholder="검색할 상품명을 입력하세요" style="border: 2px solid #b7b7b7; border-radius: 0; width: 80%; height: 50px; font-size: 15px; position: relative; top: 30%;" />
                        <c:if test="${!(ldcode =='0')}">
	                        <button type="button" value="Submit" style="height: 50px; border: none;" onClick="goSearch('${ldcode}','${ldname}', $('#searchWord').val(), '1');">
	                        	<img src="<%=CtxPath%>/store/images/search.png" style="width:20px; height:20px;"alt=""/>
	                        </button>
                        </c:if>
                        <c:if test="${(ldcode == '0')}">
	                        <button type="button" value="Submit" style="height: 50px; border: none;" onClick="goSearch('${sdcode}','${ldname}', $('#searchWord').val(), '1');">
	                        	<img src="<%=CtxPath%>/store/images/search.png" style="width:20px; height:20px;"alt=""/>
	                        </button>
                        </c:if>
                     </li>
                  </ul>
               </form>
               
            </div>
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
					<span id="result"></span>
               <div id="pageBar" class="col-md-12 text-center"></div>
            </div>
         </div>
      </div>
	</div>
</div>
<!--   -->
   
<jsp:include page="../footer.jsp"/>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<% String CtxPath = request.getContextPath(); %>
<jsp:include page="../header.jsp" />

<aside id="colorlib-hero" class="breadcrumbs">
	<div class="flexslider">
		<ul class="slides">
			<li
				style="background-image: url(<%= CtxPath %>/store/images/cover-img-1.jpg);">
				<div class="overlay"></div>
				<div class="container-fluid">
					<div class="row">
						<div
							class="col-md-6 col-md-offset-3 col-sm-12 col-xs-12 slider-text">
							<div class="slider-text-inner text-center">
								<h1>Event List</h1>
								<h2 class="bread">
									<span><a href="index.jsp">Home</a></span>
								</h2>
							</div>
						</div>
					</div>
				</div>
			</li>
		</ul>
	</div>
</aside>

<div class="container">
	<h2>이벤트 목록</h2>

	<div class="table-responsive">
		<table class="table">
			<thead>
				<tr>
					<th>이벤트명</th>
				</tr>
			</thead>
		</table>
	</div>
	<%-- 이벤트 리스트  --%>
	<div align="center">
		<%-- 이벤트 1 --%>
		<div style="margin-bottom: 10px;">
			<span> <%-- 이벤트 넘어가는 주소 넣는 곳 --%> <a href="eventDetail.jsp"><img
					src="<%= CtxPath %>/store/images/index/MerryChristmas.PNG"
					width="70%" height="20%" /></a>
			</span>
		</div>
		<%-- 이벤트 2 --%>
		<div style="margin-bottom: 10px;">
			<%-- 이벤트 넘어가는 주소 넣는 곳 --%>
			<a href=""> <img
				src="<%= CtxPath %>/store/images/index/LastSale.png" width="70%"
				height="20%" /></a>
		</div>
		<%-- 이벤트 3 --%>
		<div>
			<%-- 이벤트 넘어가는 주소 넣는 곳 --%>
			<a href=""><img
				src="<%= CtxPath %>/store/images/index/NewYearSale.png" width="70%"
				height="20%" /></a>
		</div>
	</div>
	<%-- 이벤트 리스트 끝  --%>
</div>

<jsp:include page="../footer.jsp" />
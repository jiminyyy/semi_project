<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String ctxPath=request.getContextPath();
%>
    
<jsp:include page="../header.jsp"/>
<aside id="colorlib-hero" class="breadcrumbs">
	<div class="flexslider">
		<ul class="slides">
	   	<li style="background-image: url(<%=ctxPath %>/store/images/cover-img-1.jpg);">
	   		<div class="overlay"></div>
	   		<div class="container-fluid">
	   			<div class="row">
		   			<div class="col-md-6 col-md-offset-3 col-sm-12 col-xs-12 slider-text">
		   				<div class="slider-text-inner text-center">
		   					<h1>MyPage</h1>
		   					<h2 class="bread">
			   					<span style="font-size: 13pt;"><a href="#">회원정보수정</a></span>
			   					<span style="font-size: 13pt;"><a href="#">환불 및 교환내역</a></span>
			   					<span style="font-size: 13pt;"><a href="#">찜 목록 보기</a></span>
			   					<span style="font-size: 13pt;"><a href="#">주문내역보기</a></span>
			   					<span style="font-size: 13pt;"><a href="#">보유쿠폰 보기</a></span>
			   					<span style="font-size: 13pt;"><a href="#">리뷰보기</a></span>
		   					</h2>
		   				</div>
		   			</div>
		   		</div>
	   		</div>
	   	</li>
	  	</ul>
  	</div>
</aside>
<div style="margin: 3%; border: 0px solid red;" align="center">
	<div style="width: 80%;margin: 0 auto;" align="center">
		<table style="width: 80%; border: 1px solid gray;">
			<tr height="100px;" style="">
				<td width="15%" style="font-size: 20pt; text-align: center; border: 1px solid gray;">
					<span id="name" class="name">전가현</span>
					<span style="font-size: 12pt">님</span><br>
					<span id="level" class="level" style="font-size: 12pt; font-weight: bold;" >골드</span>
				</td>
				<td width="25%" style="padding: 0 10pt;" align="center">
					<span style="font-weight: bold; font-size: 15pt;">배송현황</span>
					<br>
					<span style="font-size: 17pt">0</span><span style="font-size: 13pt">개</span>
				</td>
				<td width="25%" style="padding: 0 10pt;" align="center">
					<span style="font-weight: bold; font-size: 15pt;">보유쿠폰</span>
					<br>
					<span style="font-size: 17pt">0</span><span style="font-size: 13pt">개</span>
				</td>
				<td width="25%" style="padding: 0 10pt;" align="center">
					<span style="font-weight: bold; font-size: 15pt;">보유포인트</span>
					<br>
					<span style="font-size: 17pt">0</span><span style="font-size: 13pt">개</span>
				</td>
			</tr>
		</table>
	</div>
</div>
<div style="" align="center">
	<div style="margin-top: 3%; margin-bottom: 1%;" align="center">
		<span style="font-weight: bold; font-size: 18pt; ">할인쿠폰</span>
		&nbsp;&nbsp;할인쿠폰은 구매조건에 따라 상품 결제 시 적용할 수 있습니다.
	</div>	
	<div class="colorlib-shop">
		<div class="container">
			<div class="row row-pb-md">
				<div class="col-md-10 col-md-offset-1">
					<div class="product-name">
						<div class="one-forth text-center">
						<span>쿠폰명</span>
						</div>
						<div class="one-eight text-center">
							<span>할인율</span>
						</div>
						<div class="one-eight text-center">
							<span>사용조건</span>
						</div>
						<div class="one-eight text-center">
							<span>유효기간</span>
						</div>
						<div class="one-eight text-center">
							<span>사용유무</span>
						</div>
					</div>
					<div class="product-cart">
						<div class="one-forth">
							<div class="display-tc">
								<strong style="font-size: 15pt; "><span>베지테리언인 당신을 위한 혜택!</span></strong><br>
								<a href="#">상세보기</a>
							</div>
						</div>
						<div class="one-eight text-center">
							<div class="display-tc">
								<span class="percent" style="font-size: 12pt; color:red;" >30%</span>
							</div>
						</div>
						<div class="one-eight text-center">
							<div class="display-tc" ">
								<strong><span class="useCondition">1,000원이상 구매고객</span></strong>
							</div>
						</div>
						<div class="one-eight text-center">
							<div class="display-tc">
								<span class="useDate">2019-05-10까지</span>
							</div>
						</div>
						<div class="one-eight text-center">
							<div class="display-tc">
								<span class="couponUse">사용가능</span>
							</div>
						</div>
					</div>
					<div class="product-cart">
						<div class="one-forth">
							<div class="display-tc">
								<strong style="font-size: 15pt; "><span>베지테리언인 당신을 위한 혜택!</span></strong><br>
								<a href="#">상세보기</a>
							</div>
						</div>
						<div class="one-eight text-center">
							<div class="display-tc">
								<span class="percent" style="font-size: 12pt; color: red;">30%</span>
							</div>
						</div>
						<div class="one-eight text-center">
							<div class="display-tc">
								<strong><span class="useCondition">1,000원이상 구매고객</span></strong>
							</div>
						</div>
						<div class="one-eight text-center">
							<div class="display-tc">
								<span class="useDate">2019-05-10까지</span>
							</div>
						</div>
						<div class="one-eight text-center">
							<div class="display-tc">
								<span class="couponUse">사용가능</span>
							</div>
						</div>
					</div>
					<div class="product-cart">
						<div class="one-forth">
							<div class="display-tc">
								<strong style="font-size: 15pt; "><span>베지테리언인 당신을 위한 혜택!</span></strong><br>
								<a href="#">상세보기</a>
							</div>
						</div>
						<div class="one-eight text-center">
							<div class="display-tc">
								<span class="percent" style="font-size: 12pt; color: red;">30%</span>
							</div>
						</div>
						<div class="one-eight text-center">
							<div class="display-tc">
								<strong><span class="useCondition">1,000원이상 구매고객</span></strong>
							</div>
						</div>
						<div class="one-eight text-center">
							<div class="display-tc">
								<span class="useDate">2019-05-10까지</span>
							</div>
						</div>
						<div class="one-eight text-center">
							<div class="display-tc">
								<span class="couponUse">사용가능</span>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

<jsp:include page="../footer.jsp"/>
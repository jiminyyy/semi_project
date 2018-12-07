<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String CtxPath=request.getContextPath();
%>
<jsp:include page="../header.jsp"/>

<style>

#error_passwd	{color : red;
				 font-size: 9pt;
				}

.error			{color : red;
				 font-size: 9pt;
				}

.bgcol			{background-color: LightGray;
				}

</style>

<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>

<script>
$(document).ready(function(){
	
	var now = new Date();
	
	$(".error").hide();
	$("#error_passwd").hide();
	$("#pwd").focus();
	
	$(".requiredInfo").keydown(function(event){
		
		if(event.keyCode == 13) {
			return false;
		}
		
	});
	
	$(".requiredInfo").each(function(){
		
		$(this).blur(function(){ //blur -> 포커스를 잃을 때
			var data = $(this).val().trim();
			if(data == "") {
				$(this).parent().find(".error").show();
				$(":input").attr("disabled", true).addClass("bgcol");
				$(".btn").attr("disabled", false).removeClass("bgcol");
				$(this).attr("disabled", false).removeClass("bgcol").focus();
				
			}
			else {
				$(this).parent().find(".error").hide();
				$(":input").attr("disabled", false).removeClass("bgcol");
			}
			});
			
	});
		
	$("#pwd").blur(function(){
		var passwd = $(this).val();
		//var regExp_PW = /^.*(?=^.{8,15}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[^a-zA-Z0-9]).*$/g; 아래처럼 쓸 수 있다.
		var regExp_PW = new RegExp(/^.*(?=^.{8,15}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[^a-zA-Z0-9]).*$/g);
		
		var bool = regExp_PW.test(passwd);
		
		if(!bool) {
			$("#error_passwd").show();
			$(":input").attr("disabled", true).addClass("bgcol");
			$(this).attr("disabled", false).removeClass("bgcol");
			$(this).focus();
		}
		else {
			$("#error_passwd").hide();
			$(":input").attr("disabled", false).removeClass("bgcol");
			// $("#pwdcheck").focus(); 안먹어...
		}
		
	}); //end of $("#pwd").blur(function(){
		
	$("#pwdcheck").blur(function(){
	
		var passwd = $("#pwd").val();
		var passwdCheck = $(this).val();
		
		if(passwd != passwdCheck) {
			$(this).parent().find(".error").show();
			$(":input").attr("disabled", true).addClass("bgcol");
			$(this).attr("disabled", false).removeClass("bgcol");
			$("#pwd").attr("disabled", false).removeClass("bgcol");
			$("#pwd").focus();
		}
		else {
			$(this).parent().find(".error").hide();
			$(":input").attr("disabled", false).removeClass("bgcol");
		}
	
	}); // end of $("#pwdcheck").blur(function(){
	
	$("#email").blur(function(){
		
		var email = $(this).val();
		var regExp_EMAIL = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i; 
		var bool = regExp_EMAIL.test(email);
		
		if( !bool ) {
			$(this).parent().find(".error").show();
			$(":input").attr("disabled", true).addClass("bgcol");
			$(this).attr("disabled", false).removeClass("bgcol");
			$(this).focus();
		}
		else {
			$(this).parent().find(".error").hide();
			$(":input").attr("disabled", false).removeClass("bgcol");
		}
		
	}); //end of $("#email").blur(function(){
		
	$("#phone").blur(function(){
		
		var phone = $(this).val();
		
		var bool1 = false;
		var regExp_phone =  /^[0-9]+$/g;
		var bool1 = (phone.length == 10) && regExp_phone.test(phone); 
		
		var bool2 = false;
		var regExp_phone =  /^[0-9]+$/g;
		var bool2 = (phone.length == 11) && regExp_phone.test(phone);
		
		
		if( !(bool1 || bool2) ) {
			$(this).parent().find(".error").show();
			$(":input").attr("disabled", true).addClass("bgcol");
			$(this).attr("disabled", false).removeClass("bgcol").focus();
		}
		else {
			$(this).parent().find(".error").hide();
			$(":input").attr("disabled", false).removeClass("bgcol");
			
		}
		
	}); //end of $("#phone").blur(function(){
		
	
	 
	$("#zipcodeSearch").click(function(){
		new daum.Postcode({
				oncomplete: function(data) {
				    $("#postnum").val(data.zonecode);
				    $("#addr1").val(data.address); 
				    $("#addr2").focus();
				}
		}).open();
				
	});
	
	$(".address").blur(function(){
		var address = $(this).val().trim();
		if(address == ""){
			$(this).parent().find(".error").show();
			$(":input").attr("disabled", true).addClass("bgcol");
			$(this).attr("disabled", false).removeClass("bgcol").focus();
		}
		else {
			$(this).parent().find(".error").hide();
			$(":input").attr("disabled", false).removeClass("bgcol");
		}
	});
	
}); //end of $(document).ready(function(){
	
function goEditEnd(event) {	
	var frm = document.EditFrm;
	frm.method = "POST";
	frm.action = "memberModifyEnd.do";
	frm.submit();
	// 유효성 검사 통과하면 memberInsert.jsp로 보내준다.
	
} // end of function goRegister(event) {

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
		   					<h1>MyPage</h1>
		   					<h2 class="bread">
			   					<span style="font-size: 13pt;"><a href="<%=CtxPath%>/memberModify.do">회원정보수정</a></span>
			   					<span style="font-size: 13pt;"><a href="<%=CtxPath%>/refundChange.do">환불 및 교환내역</a></span>
			   					<span style="font-size: 13pt;"><a href="<%=CtxPath%>/myPickList.do">찜 목록 보기</a></span>
			   					<span style="font-size: 13pt;"><a href="<%=CtxPath%>/orderList.do">주문내역보기</a></span>
			   					<span style="font-size: 13pt;"><a href="<%=CtxPath%>/couponList.do">보유쿠폰 보기</a></span>
			   					<span style="font-size: 13pt;"><a href="<%=CtxPath%>/myReview.do">리뷰보기</a></span>
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
					<span id="name" class="name">${loginuser.name}</span>
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
					<span style="font-size: 17pt">00000</span><span style="font-size: 13pt">개</span>
				</td>
				<td width="25%" style="padding: 0 10pt;" align="center">
					<span style="font-weight: bold; font-size: 15pt;">보유포인트</span>
					<br>
					<span style="font-size: 17pt">${loginuser.point}</span><span style="font-size: 13pt">point</span>
				</td>
			</tr>
		</table>
	</div>
</div>


<div style="margin-top: 3%; margin-bottom: 1%;" align="center">
	<span style="font-weight: bold; font-size: 18pt; ">회원정보 수정</span>
	&nbsp;&nbsp;
</div>	
	
<div class="container" style="margin-left: 27%; width:70%;">      
	<div class="col-md-8">
		<form method="post" name ="EditFrm" class="colorlib-form">
			
			<div class="form-group">
            	<div class="col-md-6">
            		<input type="hidden" name="userid" value="${loginuser.userid}">
					<label for="pwd">비밀번호</label>
					<input type="password" id="pwd" name="pwd" class="form-control requiredInfo" placeholder="Password" required/>
					<span id="error_passwd">암호는 영문자,숫자,특수기호를 혼합하여 8-15글자로<br/>입력가능합니다.</span>
				</div>
            </div>
            
            <div class="form-group">
				<div class="col-md-6">
					<label for="pwdcheck">비밀번호확인</label>
					<input type="password" id="pwdcheck" class="form-control requiredInfo" placeholder="Password" required/>
					<span class="error">암호가 일치하지 않습니다.</span>
               </div>
            </div>
            
            <div class="form-group">
				<div class="col-md-6" >
					<label for="email">이메일</label>
					<input type="text" id="email" name="email" class="form-control requiredInfo" value="${loginuser.email}" placeholder="abc@gmail.com" required/>
					<span class="error">이메일 형식에 맞지 않습니다.</span>
				</div>
			</div>
			
            <div class="form-group">   
            	<div class="col-md-6">
					<label for="phone">연락처</label>
					<input type="text" id="phone" name="phone" class="form-control requiredInfo" value="${loginuser.phone}" placeholder="Phone Number" required/>
					<span class="error error_hp">휴대폰 형식이 아닙니다.</span>
               	</div>   
            </div>
            
            <div class="form-group">
				<div class="col-md-4">
					<label for="postnum">우편번호</label>
					<input type="text" id="postnum" name="postnum" class="form-control requiredInfo" value="${loginuser.postnum}" placeholder="PostNum" required/>
					<span class="error error_post">우편번호 형식이 아닙니다.</span>
				</div>
				<%-- 우편번호찾기 버튼 --%>
				<div class="col-md-3" style="margin-top: 7%; margin-left: 3%;">
					<button  type="button" id="zipcodeSearch" class="btn" style="width: 120px; height: 30px; padding: 0%;">
					<span style="font-size: 10pt;">우편번호찾기</span></button>
				</div>
			</div>
            
            <div class="col-md-6">
				<div class="form-group">
					<label for="fname">주소</label>
					<input type="text" id="addr1" name="addr1" class="form-control requiredInfo address" value="${loginuser.addr1}" placeholder="Enter Your Address" required/>
				</div>
				<div class="form-group">
					<input type="text" id="addr2" name="addr2" class="form-control requiredInfo address" value="${loginuser.addr2}" placeholder="Second Address" required/>
					<span class="error">주소를 입력하세요.</span>
				</div>
			</div>
			<div class="row">
	           <div class="col-md-12" style="margin-left: 40%; margin-top: 5%;" >
	              <p>
	              	<button type="button" id="btnRegister" class="btn btn-primary" onClick="goEditEnd(event);">수정하기</button>
	              </p>
	           </div>
	        </div>
		</form>
   </div>
</div>

<div class="gototop js-top">
   <a href="#" class="js-gotop"><i class="icon-arrow-up2"></i></a>
</div>

<jsp:include page="../footer.jsp" />
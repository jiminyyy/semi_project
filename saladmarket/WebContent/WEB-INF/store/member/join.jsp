<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% String CtxPath = request.getContextPath(); %>
<jsp:include page="../header.jsp" />

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
	$("#error_id").hide();
	$("#error_passwd").hide();
	$("#userid").focus();
	
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
	
	$("#idcheck").click(function(){
		
		if($("#userid").val().trim() == "") {
			alert("ID를 입력하세요!!");
			return;
		}
		
		var form_data = {userid:$("#userid").val()};
		
		$.ajax({
			url:"idDuplicateCheck.do",
			type:"POST",
			data:form_data,
		    dataType:"json",
		    success:function(json){
		    	
		    	if(json.n == 0) {
		    		$("#id_error").empty();
		    		$("#good_id").empty().html("ID로 사용가능합니다.");
		    		$("#hidden").val("0");
		    	}
		    	else if(json.n == 1) {
		    		$("#good_id").empty();
		    		$("#id_error").empty().html("이미 사용중인 ID입니다.");
		    		$("#hidden").val("1");
		    	}
		    },
		    error: function(request, status, error){
				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
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
	
function goRegister(event) {

	
	if ($("#hidden").val().trim() == ""){		
		alert("ID 중복확인 버튼을 눌러주세요!!")
		return;
	}
	
	else if ($("#hidden").val().trim() == "1"){		
		alert("새로운 ID를 입력하세요!!")
		return;
	}
	
	if (!$("input:checkbox[id=agree]").is(":checked")) {
		alert("이용약관에 동의해주세요!!")
		return;
	}
	
	var frm = document.registerFrm;
	frm.method = "POST";
	frm.action = "memberRegisterEnd.do";
	frm.submit();
	// 유효성 검사 통과하면 memberInsert.jsp로 보내준다.
	
} // end of function goRegister(event) {

</script>

<%-- 큰 사진 --%>
<aside id="colorlib-hero" class="breadcrumbs">
    <div class="flexslider">
       <ul class="slides">
          <li style="background-image: url(<%=CtxPath %>/store/images/cover-img-1.jpg);">
             <div class="overlay"></div>
             <div class="container-fluid">
                <div class="row">
                   <div class="col-md-6 col-md-offset-3 col-sm-12 col-xs-12 slider-text">
                      <div class="slider-text-inner text-center">
                         <h1>Join Us</h1>
                         <h2 class="bread"><span><a href="index.do">Home</a></span> <span><a href="login.do">Login</a></span></h2>
                      </div>
                   </div>
                </div>
             </div>
          </li>
         </ul> 
      </div>
</aside> 
      
<div class="container" style="margin-left: 30%;">      
	<div class="col-md-8">
	
		<form method="post" name ="registerFrm" class="colorlib-form">
		
			<div class="form-group">
			
				<div class="col-md-6">
					<label for="userid">아이디</label>
					<input type="text" id="userid" name="userid" class="form-control requiredInfo userid" placeholder="ID" required/>
					<span class="error">아이디란은 필수입력 사항입니다.</span>
					<span id="good_id"></span>
					<span id="id_error"></span>
					<input type="hidden" id="hidden" name="hidden" value=""/>  
				</div>
				
				<%-- 아이디 중복체크 --%>
				<div class="col-md-3" style="margin-top: 7%; margin-left: 3%;">
					<button type="button" id="idcheck" class="btn" style="width: 120px; height: 30px; padding: 0%;"><span style="font-size: 10pt;">아이디  중복확인</span></button>
				</div>
			</div>
			
			
            <div class="form-group">
            
				<div class="col-md-6">
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
            
				<div class="col-md-6">
					<label for="name">성명</label>
					<input type="text" id="name" name="name" class="form-control requiredInfo" placeholder="Name" required/>
					<span class="error">성명란은 필수입력 사항입니다.</span>
				</div>
            </div>
            
            <div class="form-group">
				<div class="col-md-6" >
					<label for="email">이메일</label>
					<input type="text" id="email" name="email" class="form-control requiredInfo" placeholder="abc@gmail.com" required/>
					<span class="error">이메일 형식에 맞지 않습니다.</span>
				</div>
			</div>
			
            <div class="form-group">   
            	<div class="col-md-6">
					<label for="phone">연락처</label>
					<input type="text" id="phone" name="phone" class="form-control requiredInfo" placeholder="Phone Number" required/>
					<span class="error error_hp">휴대폰 형식이 아닙니다.</span>
               </div>   
            </div>
            
            <div class="form-group">
				<div class="col-md-4">
					<label for="postnum">우편번호</label>
					<input type="text" id="postnum" name="postnum" class="form-control requiredInfo" placeholder="PostNum" required/>
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
					<input type="text" id="addr1" name="addr1" class="form-control requiredInfo address" placeholder="Enter Your Address" required/>
				</div>
				<div class="form-group">
					<input type="text" id="addr2" name="addr2" class="form-control requiredInfo address" placeholder="Second Address" required/>
					<span class="error">주소를 입력하세요.</span>
				</div>
			</div>
			
               <div class="form-group">
               <div class="col-md-4">
                  <label for="postnum">생년월일</label>
                  <input type="number" id="birthyyyy"name="birthyyyy" class="form-control requiredInfo" min="1950" max="2050" step="1" value="1995" required/>               
               </div>
               <div class="col-md-3" style="margin-top: 4%">
                  <select id="birthmm" name="birthmm" class="form-control requiredInfo">
                     <option value ="01">01</option>
                     <option value ="02">02</option>
                     <option value ="03">03</option>
                     <option value ="04">04</option>
                     <option value ="05">05</option>
                     <option value ="06">06</option>
                     <option value ="07">07</option>
                     <option value ="08">08</option>
                     <option value ="09">09</option>
                     <option value ="10">10</option>
                     <option value ="11">11</option>
                     <option value ="12">12</option>
                  </select> 
               </div>
               <div class="col-md-3" style="margin-top: 4%">
                  <select id="birthdd" name="birthdd" class="form-control requiredInfo">
	                  <option value ="01">01</option>
	                  <option value ="02">02</option>
	                  <option value ="03">03</option>
	                  <option value ="04">04</option>
	                  <option value ="05">05</option>
	                  <option value ="06">06</option>
	                  <option value ="07">07</option>
	                  <option value ="08">08</option>
	                  <option value ="09">09</option>
	                  <option value ="10">10</option>
	                  <option value ="11">11</option>
	                  <option value ="12">12</option>
	                  <option value ="13">13</option>
	                  <option value ="14">14</option>
	                  <option value ="15">15</option>
	                  <option value ="16">16</option>
	                  <option value ="17">17</option>
	                  <option value ="18">18</option>
	                  <option value ="19">19</option>
	                  <option value ="20">20</option>
	                  <option value ="21">21</option>
	                  <option value ="22">22</option>
	                  <option value ="23">23</option>
	                  <option value ="24">24</option>
	                  <option value ="25">25</option>
	                  <option value ="26">26</option>
	                  <option value ="27">27</option>
	                  <option value ="28">28</option>
	                  <option value ="29">29</option>
	                  <option value ="30">30</option>
	                  <option value ="31">31</option>
               	  </select> 
            	</div>
			</div>
			<div class="form-group">
			
		        <div class="col-md-12" style="position: relative; min-height: 1px; margin-top: 4%; padding-left: 15px; padding-right: 15px;">
		        	<label for="agree">이용약관에 동의합니다</label>&nbsp;&nbsp;<input type="checkbox" id="agree" />
		        </div>
		        
		        <div class="col-md-12" style="position: relative; min-height: 1px; margin-top: 4%; padding-left: 15px; padding-right: 15px;">
		        	<iframe src="<%=CtxPath %>/store/agree/agree.html" width="100%" height="150px" class="box" ></iframe>
		        </div>
			</div>
			
			<div class="row">
	           <div class="col-md-12" style="margin-left: 40%; margin-top: 5%;" >
	              <p>
	              	<button type="button" id="btnRegister" class="btn btn-primary" onClick="goRegister(event);">가입하기</button>
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
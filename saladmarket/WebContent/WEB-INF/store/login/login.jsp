<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>    

<jsp:include page="../header.jsp" />
<% String CtxPath = request.getContextPath(); %>

<script type="text/javascript" >

	$(document).ready(function(){
		
		$("#userid").focus();
		
		var userid = getCookie("userid");
	    $("input[name='userid']").val(userid); 
	     
	    if($("input[name='userid']").val() != ""){ // 그 전에 ID를 저장해서 처음 페이지 로딩 시, 입력 칸에 저장된 ID가 표시된 상태라면,
	        $("#saveid").attr("checked", true); // ID 저장하기를 체크 상태로 두기.
	    }
	     
	    $("#saveid").change(function(){ // 체크박스에 변화가 있다면,
	        if($("#saveid").is(":checked")){ // ID 저장하기 체크했을 때,
	            var userid= $("input[name='userid']").val();
	            setCookie("userid", userid, 7); // 7일 동안 쿠키 보관
	        }else{ // ID 저장하기 체크 해제 시,
	            deleteCookie("userid");
	        }
	    });
	     
	    // ID 저장하기를 체크한 상태에서 ID를 입력하는 경우, 이럴 때도 쿠키 저장.
	    $("input[name='userid']").keyup(function(){ // ID 입력 칸에 ID를 입력할 때,
	        if($("#saveid").is(":checked")){ // ID 저장하기를 체크한 상태라면,
	            var userid= $("input[name='userid']").val();
	            setCookie("userid", userid, 7); // 7일 동안 쿠키 보관
	        }
	    });
		
		$("#btnSubmit").click(function(){
			
 			goLogin();
			
		}); // end of $("#btnSubmit").click(function(){
		
		$("#password").keydown(function(event){
			
			if(event.keyCode == 13) {
				goLogin();
			}
			
		}); // end of $("#loginPwd").keydown(function(event){
			
		
		$(".myclose").click(function(){ // id찾기, 비번찾기 모달팝업창 닫기기능
			
			javascript:history.go(0);
			
		});
		
	}); // end of $(document).ready(function(){
		
	function setCookie(cookieName, value, exdays){
	    var exdate = new Date();
	    exdate.setDate(exdate.getDate() + exdays);
	    var cookieValue = escape(value) + ((exdays==null) ? "" : "; expires=" + exdate.toGMTString());
	    document.cookie = cookieName + "=" + cookieValue;
	}
	 
	function deleteCookie(cookieName){
	    var expireDate = new Date();
	    expireDate.setDate(expireDate.getDate() - 1);
	    document.cookie = cookieName + "= " + "; expires=" + expireDate.toGMTString();
	}
	 
	function getCookie(cookieName) {
	    cookieName = cookieName + '=';
	    var cookieData = document.cookie;
	    var start = cookieData.indexOf(cookieName);
	    var cookieValue = '';
	    if(start != -1){
	        start += cookieName.length;
	        var end = cookieData.indexOf(';', start);
	        if(end == -1)end = cookieData.length;
	        cookieValue = cookieData.substring(start, end);
	    }
	    return unescape(cookieValue);
	}
	
	function goLogin() {
		
		var loginUserid = $("#userid").val().trim();
		var loginPwd = $("#password").val().trim();
		
		if(loginUserid == "") {
			alert ("아이디를 입력하세요!!");
			$("#userid").val("").focus();
			return;
		}
		
		if(loginPwd == "") {
			alert ("비밀번호를 입력하세요!!");
			$("#password").val("").focus();
			return;
		}
		
		var frm = document.loginFrm;
		frm.method = "POST";
		frm.action = "loginEnd.do";
		frm.submit();
		
	} // end of function goLogin() {
		
	function goLogOut() {
		
		location.href = "<%=CtxPath%>/logout.do";
		
	} // end of function goLogOut() {
	
	
</script>

<aside id="colorlib-hero" class="breadcrumbs">
    <div class="flexslider">
       <ul class="slides">
          <li style="background-image: url(<%=CtxPath%>/store/images/cover-img-1.jpg);">
             <div class="overlay"></div>
             <div class="container-fluid">
                <div class="row">
                   <div class="col-md-6 col-md-offset-3 col-sm-12 col-xs-12 slider-text">
                      <div class="slider-text-inner text-center">
                         <h1>Login</h1>
                         <h2 class="bread"><span><a href="index.do">Home</a></span> <span><a href="memberRegister.do">Join Us</a></span></h2>
                      </div>
                   </div>
                </div>
             </div>
          </li>
         </ul> 
      </div>
</aside>
      
<div class="container">      
   <div class="col-md-12">
      <div>
       <form method="post" class="colorlib-form" name="loginFrm">
          <div class="form-group" style="margin-top: 3%;">
            <div class="col-md-4" style="margin-top: 3%;"></div> <%-- 이부분은 칸 조정할려고 넣어놨어요ㅠㅠ --%>
              <div class="col-md-1" style="margin-top: 3%;">
                <label for="userid"><span style="display:table-cell; line-height: 200%;">아이디</span></label>
             </div>
             <div class="col-md-3">
                <input type="text" id="userid" name="userid" class="form-control" placeholder="ID">
             </div>
          </div>
          <div class="form-group">
             <div class="col-md-4" style="margin-top: 3%;"></div> <%-- 이부분은 칸 조정할려고 넣어놨어요ㅠㅠ --%>
             <div class="col-md-1" style="margin-top: 3%;">
                 <label for="password">비밀번호</label>
             </div>
             <div class="col-md-3">
                 <input type="password" id="password" name="pwd" class="form-control" placeholder="Password">
             </div>
          </div>
          <div class="form-group" align="right" style="margin: 0%;">
              <div class="col-md-8">
                 <input type="checkbox" id="saveid" name="saveid"><label for="saveid">아이디 저장</label>
             </div>
          </div>
          <div class="row" style="margin-bottom: 2%">
             <div class="col-md-12" style="margin-top: 1%; margin-left: 33%;" >
                <button type="button" class="btn" data-toggle="modal" data-target="#userIdfind" data-dismiss="modal">
                	<span style="font-size: 9pt;">아이디 찾기</span></button>
                <button type="button" class="btn" data-toggle="modal" data-target="#passwdFind" data-dismiss="modal">
                <span style="font-size: 9pt;">비밀번호 찾기</span></button>
                <button type="button" class="btn btn-primary" id="btnSubmit" style="margin-left: 2%;"><span style="font-size: 10pt;">로그인</span></button>
             </div>
          </div>
       </form>
     </div>
   </div>
</div>

<%-- ****** 아이디 찾기 Modal ****** --%>
<div class="modal fade" id="userIdfind" role="dialog">
  <div class="modal-dialog">
  
    <!-- Modal content-->
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close myclose" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">아이디 찾기</h4>
      </div>
      <div class="modal-body" style="height: 500px; width: 100%;">
        <div id="idFind">
        	<iframe style="border: none; width: 100%; height: 500px;" src="<%=CtxPath%>/idFind.do">
        	</iframe>
        </div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default myclose" data-dismiss="modal">Close</button>
      </div>
    </div>
    
  </div>
</div>   

<%-- ****** 비밀번호 찾기 Modal ****** --%>
<div class="modal fade" id="passwdFind" role="dialog">
  <div class="modal-dialog">
  
    <!-- Modal content-->
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close myclose" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">비밀번호 찾기</h4>
      </div>
      <div class="modal-body">
        <div id="pwFind">
        	<iframe style="border: none; width: 100%; height: 500px;" src="<%=CtxPath%>/pwdFind.do">  
        	</iframe>
        </div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default myclose" data-dismiss="modal">Close</button>
      </div>
    </div>
  </div>
</div>


<div class="gototop js-top">
   <a href="#" class="js-gotop"><i class="icon-arrow-up2"></i></a>
</div>

<jsp:include page="../footer.jsp" />
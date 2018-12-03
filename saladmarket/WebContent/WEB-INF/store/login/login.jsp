<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>    

<jsp:include page="../header.jsp" />
<% String CtxPath = request.getContextPath(); %>

<script type="text/javascript" >

	$(document).ready(function(){
		
		$("#loginUserid").focus();
		
		$("#btnSubmit").click(function(){
			
 			goLogin();
			
		}); // end of $("#btnSubmit").click(function(){
		
		$("#loginPwd").keydown(function(event){
			
			if(event.keyCode == 13) {
				goLogin();
			}
			
		}); // end of $("#loginPwd").keydown(function(event){
			
		
		$(".myclose").click(function(){
			// alert("닫는다.");
			
			javascript:history.go(0);
			
			// 현재 페이지를 새로고침을 함으로써 모달창에 입력한 성명과 휴대폰의 값이 텍스트박스에 남겨있지 않고 삭제하는 효과를 누린다. 
			
			/* === 새로고침(다시읽기) 방법 3가지 차이점 ===
			   >>> 1. 일반적인 다시읽기 <<<
			   window.location.reload();
			   ==> 이렇게 하면 컴퓨터의 캐쉬에서 우선 파일을 찾아본다.
			            없으면 서버에서 받아온다.  
			   
			   >>> 2. 강력하고 강제적인 다시읽기 <<<
			   window.location.reload(true);
			   ==> true 라는 파라미터를 입력하면, 무조건 서버에서 직접 파일을 가져오게 된다.
			            캐쉬는 완전히 무시된다.
			   
			   >>> 3. 부드럽고 소극적인 다시읽기 <<<
			   history.go(0);
			   ==> 이렇게 하면 캐쉬에서 현재 페이지의 파일들을 항상 우선적으로 찾는다.
			*/	
			
		});
			
		
	}); // end of $(document).ready(function(){
		
		
	function goLogin() {
		
		var loginUserid = $("#loginUserid").val().trim();
		var loginPwd = $("#loginPwd").val().trim();
		
		if(loginUserid == "") {
			alert ("아이디를 입력하세요!!");
			$("#loginUserid").val("").focus();
			return;
		}
		
		if(loginPwd == "") {
			alert ("비밀번호를 입력하세요!!");
			$("#loginPwd").val("").focus();
			return;
		}
		
		var frm = document.loginFrm;
		frm.method = "POST";
		frm.action = "loginEnd.do";
		frm.submit();
		
	} // end of function goLogin() {
		
	function goLogOut() {
		
		location.href = "<%=request.getContextPath()%>/logout.do";
		
	} // end of function goLogOut() {
		
	function goEditPersonal(idx) {
		
		var url = "memberEdit.do?idx="+idx;
		
		window.open(url, "memberEdit",
				    "left=150px, top=50px, width=800px, height=650px");

	}
	
	// *** payment gateway(결제) 시작
	function goCoinPurchaseTypeChoice(idx) { // 코인충전버튼 클릭시 실행되는 함수 -> 코인충전 창을 띄운다.
		
		var url = "coinPurchaseTypeChoice.do?idx="+idx;
	
		window.open(url, "coinPurchaseTypeChoice",
					"left=350px, top=100px, width=650px, height=570px");
		
	} // end of function goCoinPurchaseTypeChoice(idx) { // 팝업창 띄우기

		
	function goCoinPurchaseEnd(idx, coinmoney) { // 코인구매액 결제창 띄우기
	
		var url = "coinPurchaseEnd.do?idx="+idx+"&coinmoney="+coinmoney;
		
		window.open(url, "coinPurchaseTypeEnd",
					"left=350px, top=100px, width=850px, height=600px");
	
	}
	
	function goCoinUpdate(idx){ //, coinmoney) {
		
		var frm = document.coinUpdateFrm;
		frm.idx.value = idx;
		// frm.idx.value = coinmoney;
		frm.method = "POST";
		frm.action = "<%=request.getContextPath()%>/coinAddUpdateLoginuser.do";
		frm.submit();
	}
	
	// *** payment gateway 끝
	
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
                <label for="userid">아이디</label>
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
                 <input type="checkbox" id="idcheck"><label for="idcheck">아이디 저장</label>
             </div>
          </div>
          
          
          <div class="row" style="margin-bottom: 2%">
             <div class="col-md-12" style="margin-top: 1%; margin-left: 33%;" >
                <button class="btn"><span style="font-size: 9pt;">아이디 찾기</span></button>
                <button class="btn"><span style="font-size: 9pt;">비밀번호 찾기</span></button>
                <button class="btn btn-primary" style="margin-left: 2%;"><span style="font-size: 10pt;">로그인</span></button>
             </div>
          </div>
          
          
       </form>
     </div>
   </div>
</div>

<div class="gototop js-top">
   <a href="#" class="js-gotop"><i class="icon-arrow-up2"></i></a>
</div>

<jsp:include page="../footer.jsp" />
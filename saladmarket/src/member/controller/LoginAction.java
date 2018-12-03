package member.controller;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.controller.AbstractController;
import member.model.MemberVO;

public class LoginAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest req, HttpServletResponse res) throws Exception {
		
/*

		MemberVO loginuser = (MemberVO)session.getAttribute("loginuser");
		
		if(loginuser == null) { // 로그인 하기 전 화면을 띄운다.
			
			        로그인 하려고 할때 WAS(톰캣서버)는 사용자 컴퓨터 웹브라우저로 부터 전송받은 쿠키를 검사해서 그 쿠키의 사용유효시간이 0초 짜리가 아니라면 그 쿠키를 가져와서 웹브라우저에 적용시키도록 해준다.
			        우리는 쿠키의 키 값이 "saveid" 가 있으면  로그인 ID 텍스트박스에 아이디 값을 자동적으로 올려주면 된다.
			
		
			Cookie[] cookieArr = request.getCookies();
			//  쿠키는 쿠키의 이름별로 여러개 저장되어 있으므로 쿠키를 가져올때는 배열타입으로 가져와서 가져온 쿠키배열에서 개발자가 원하는 쿠키의 이름과 일치하는것을 뽑기 위해서는 쿠키 이름을 하나하나씩 비교하는 것 밖에 없다.
			
			String cookie_key = "";
			String cookie_value = "";
			boolean flag = false;
			
			if(cookieArr != null) { // 클라이언트(사용자) 컴퓨터에서 보내온 쿠키의 정보가 있다면
				for(Cookie c :cookieArr) { 
					cookie_key = c.getName(); // 쿠키의 이름(키값)을 꺼내오는 메소드
				
					if("saveid".equals(cookie_key)) {
						cookie_value = c.getValue(); // 쿠키의 value값을 꺼내는 메소드
						flag = true; 
						break;
					}
				} // end of for
				
			}		
		}
		*/
		super.setRedirect(false);
		super.setViewPage("/WEB-INF/store/login/login.jsp");

	}

}

package member.controller;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import member.model.MemberDAO;
import member.model.MemberVO;

public class LoginEndAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest req, HttpServletResponse res) throws Exception {

		String method = req.getMethod();
		
		if(!"POST".equalsIgnoreCase(method)) {
			// post방식으로 들어온 것이 아니라면
			req.setAttribute("msg", "잘못된 경로로 들어왔습니다!!!");
			req.setAttribute("loc", "javascript:history.back()"); 
			
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/msg.jsp");
			
			return;
		}
		else {
			String userid = req.getParameter("userid");
			String pwd = req.getParameter("pwd");

			MemberDAO memberdao = new MemberDAO();
			
			//181204 로그인 메소드 만들기
			MemberVO loginUser = memberdao.loginOKmemberInfo(userid, pwd);
			
			if(loginUser == null) { // 로그인 실패
				
				req.setAttribute("msg", "아이디 또는 비밀번호를 확인해주세요!!!");
				req.setAttribute("loc", "login.do");
				
				super.setRedirect(false);
				super.setViewPage("/WEB-INF/msg.jsp");
				
				return;				

			} 
			
			else if(loginUser.isDormant()) {
				
				req.setAttribute("msg", "로그인 하신지 1년이 경과하여 휴면회원이 되셨습니다. 관리자에게 문의해주세요!!!");
				req.setAttribute("loc", "index.do");
				
				super.setRedirect(false);
				super.setViewPage("/WEB-INF/msg.jsp");
				
				return;		
			}
			
			else { // 로그인 성공!
				// 세션(session) 객체 생성
				HttpSession session = req.getSession();
				
				session.setAttribute("loginuser", loginUser);
				
				String returnPage = (String)session.getAttribute("returnPage");
				
				if(loginUser.isRequirePwdChange()) {
					
					req.setAttribute("msg", "비밀번호를 변경하신지 6개월이 지났습니다 비밀번호를 변경해주세요!!!");
					req.setAttribute("loc", "index.do");
					
					super.setRedirect(false);
					super.setViewPage("/WEB-INF/msg.jsp");
					
					return;		
				}
				// 세션에 goBackURL이 있다면 장바구니를 통해 들어온것이므로 로그인완료 후 제품 페이지로 돌아가야한다.
				else if(returnPage != null) {
					super.setRedirect(true);
					super.setViewPage("returnPage");
				}
				
				else {
					super.setRedirect(true);
					super.setViewPage("index.do");
					
					session.removeAttribute("returnPage");
				}
				
			}
			
		}

	} // end of execute
}

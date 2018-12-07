package member.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import member.model.MemberDAO;
import member.model.MemberVO;

public class MemberInfoMainAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest req, HttpServletResponse res) throws Exception {
		
		MemberVO loginuser = super.getLoginUser(req); 
		if(loginuser == null || "admin".equalsIgnoreCase(loginuser.getUserid())) return;
		
		super.setRedirect(false);
		super.setViewPage("/WEB-INF/store/mypage/memberInfoMain.jsp");
		
		String method = req.getMethod();
		if("POST".equalsIgnoreCase(method)) { // post 방식으로 들어올 경우
			
			if(loginuser == null || "admin".equalsIgnoreCase(loginuser.getUserid())) return;
			
			String userid = req.getParameter("userid");
			String pwd = req.getParameter("pwd");
			
			MemberDAO memberdao = new MemberDAO();
			
			// 로그인확인 메소드
			MemberVO loginUser = memberdao.loginOKmemberInfo(userid, pwd);

			if(loginUser == null) { // 비밀번호 확인 실패
				
				req.setAttribute("msg", "비밀번호가 올바르지 않습니다.");
				req.setAttribute("loc", "javascript:history.back();");
				
				super.setRedirect(false);
				super.setViewPage("/WEB-INF/msg.jsp");
				
				return;				

			} 
			else { // 비밀번호 확인 성공!
				
				MemberVO loginuserInfo = memberdao.getMemberDetail(userid);
				
				req.setAttribute("loginuser", loginuserInfo);
				super.setRedirect(false);
				super.setViewPage("/WEB-INF/store/mypage/memberModify.jsp");
							
			}
			
		}
	}
}

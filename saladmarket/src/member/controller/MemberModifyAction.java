package member.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import member.model.MemberDAO;
import member.model.MemberVO;

public class MemberModifyAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest req, HttpServletResponse res) throws Exception {
		
		
		String method = req.getMethod();
		
		if(!"POST".equalsIgnoreCase(method)) {
			String msg = "비정상적인 경로로 들어왔습니다.";
		    String loc = "javascript:history.back();";
		    
		    req.setAttribute("msg", msg);
		    req.setAttribute("loc", loc);
		    
		    super.setRedirect(false);
			super.setViewPage("/WEB-INF/msg.jsp");
		    return;
		}
		
		MemberVO loginuser = super.getLoginUser(req);
		
		if(loginuser == null || "admin".equalsIgnoreCase(loginuser.getUserid())) return;
		
		MemberVO membervo = new MemberVO();
		
		membervo.setUserid(req.getParameter("userid"));
		membervo.setPwd(req.getParameter("pwd"));
		membervo.setEmail(req.getParameter("email"));
		membervo.setPhone(req.getParameter("phone"));
		membervo.setPostnum(req.getParameter("postnum"));
		membervo.setAddr1(req.getParameter("addr1"));
		membervo.setAddr2(req.getParameter("addr2"));
	
		MemberDAO memberdao = new MemberDAO();
		int n = memberdao.updateMember(membervo);
		
		if(n == 1) {
			loginuser = super.getLoginUser(req);
			
			HttpSession session = req.getSession();
			session.setAttribute("loginuser", loginuser);
			
			req.setAttribute("msg", "회원정보 수정 성공!!!");
			req.setAttribute("loc", "memberInfoMain.do");
			
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/msg.jsp");
			
		}
		else {
			req.setAttribute("msg", "회원정보 수정 실패!!!");
			req.setAttribute("loc", "window.location.reload();");
			
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/msg.jsp");
		}

	}

}

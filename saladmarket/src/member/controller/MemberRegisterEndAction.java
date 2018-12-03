package member.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.controller.AbstractController;
import member.model.MemberDAO;
import member.model.MemberVO;

public class MemberRegisterEndAction extends AbstractController {

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
			
			MemberVO membervo = new MemberVO();
			membervo.setUserid(req.getParameter("userid"));
			membervo.setName(req.getParameter("name"));
			membervo.setPwd(req.getParameter("pwd"));
			membervo.setEmail(req.getParameter("email"));
			membervo.setPhone(req.getParameter("phone"));
			membervo.setPostnum(req.getParameter("postnum"));
			membervo.setAddr1(req.getParameter("addr1"));
			membervo.setAddr2(req.getParameter("addr2"));
			membervo.setBirthday(req.getParameter("birthyyyy")+req.getParameter("birthmm")+req.getParameter("birthdd"));

			MemberDAO memberdao = new MemberDAO();
			int n = memberdao.registerMember(membervo);
		
			if(n == 1) {
				req.setAttribute("msg", "회원가입 성공!!!");
				req.setAttribute("loc", "login.do");
				
				super.setRedirect(false);
				super.setViewPage("/WEB-INF/msg.jsp");
				
			}
			else {
				req.setAttribute("msg", "회원가입 실패!!!");
				req.setAttribute("loc", "memberRegister.do");
				
				super.setRedirect(false);
				super.setViewPage("/WEB-INF/msg.jsp");
			}
		}

	}

}

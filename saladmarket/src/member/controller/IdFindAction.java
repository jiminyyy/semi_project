package member.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.controller.AbstractController;
import member.model.MemberDAO;

public class IdFindAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest req, HttpServletResponse res) throws Exception {
		
		String method = req.getMethod();
		
		System.out.println(method+"이군요");
		
		if("POST".equalsIgnoreCase(method)) { // 찾기버튼을 누르고 다시 들어온 경우!
			
			String name = req.getParameter("name");
			String mobile = req.getParameter("mobile");
			
			System.out.println(name);
			System.out.println(mobile); 
			
			MemberDAO memberdao = new MemberDAO();
			String userid = memberdao.getUserid(name, mobile);
			
			if(userid != null) {
				
				req.setAttribute("userid", userid);
				req.setAttribute("name", name);
				req.setAttribute("mobile", mobile);
				
			}
			else {
			
				req.setAttribute("userid", "입력하신 정보와 일치하는 아이디가 없습니다!!");
				
			}
			
		}
		
		req.setAttribute("method", method);
		
		super.setRedirect(false);
		super.setViewPage("/WEB-INF/store/login/idFind.jsp");

	}

}

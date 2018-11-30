package member.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;

import common.controller.AbstractController;
import member.model.InterMemberDAO;
import member.model.MemberDAO;

public class IdDuplicateCheckAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest req, HttpServletResponse res) throws Exception {

		String method = req.getMethod();
		
		if("POST".equalsIgnoreCase(method)) {
		
			String userid = req.getParameter("userid");
			
			InterMemberDAO mdao = new MemberDAO();
			int n = mdao.idDuplicateCheck(userid);
			
			JSONObject jsonObj = new JSONObject();
			jsonObj.put("n", n);
			
			String str_json = jsonObj.toString();
			
			req.setAttribute("userid", userid);
			req.setAttribute("str_json", str_json);
			
			//req.setAttribute("str_json", str_json);

		}
		
		super.setRedirect(false);
		super.setViewPage("/WEB-INF/store/member/join.jsp"); // 보여줄 페이지 설정

	}

}

/*


String userid = req.getParameter("userid");

InterAjaxDAO adao = new AjaxDAO();

int n = adao.idDuplicateCheck(userid);

JSONObject jsonObj = new JSONObject();
jsonObj.put("n", n);

String str_json = jsonObj.toString();

req.setAttribute("str_json", str_json);

super.setRedirect(false);
super.setViewPage("/ajaxstudy/chap4/3idDuplicateCheck.jsp");*/
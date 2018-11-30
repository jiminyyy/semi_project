package common.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.controller.AbstractController;

public class IndexController extends AbstractController {

	@Override
	public void execute(HttpServletRequest req, HttpServletResponse res) throws Exception {
		
		
		super.setRedirect(false);
		super.setViewPage("/WEB-INF/store/index.jsp");
		/*
			확장자가 .java인 파일과 .xml인 파일에서 view단 페이지의 경로를 나타낼 때 맨 앞의 /는 http://localhost:9090/MyMVC/ 를 의미한다.
			.html, .jsp에서는 http://localhost:9090/까지를 의미한다.
			
		*/
	}

}
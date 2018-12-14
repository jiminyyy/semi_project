package product.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;

import common.controller.AbstractController;
import product.model.InterProductDAO;
import product.model.ProductDAO;

public class SearchPageBarJSONAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest req, HttpServletResponse res) throws Exception {
		
		String code = req.getParameter("code");
		
		if(code == null || "".equals(code)) { 
			
			req.setAttribute("msg", "잘못된 경로로 들어오셨습니다!");
			req.setAttribute("loc", "javascript:history.back();");
			
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/msg.jsp");
			
			return;
		}
		
		String ldname = req.getParameter("ldname");
		
		if(ldname == null || "".equals(ldname)) { // 정상적 접근이면 0으로 들어오는 곳
			req.setAttribute("msg", "잘못된 경로로 들어오셨습니다!");
			req.setAttribute("loc", "javascript:history.back();");
			
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/msg.jsp");
			
			return;
		}
		
		String searchword = req.getParameter("searchword");
		
		if(searchword == null) { // null이 들어왔다면 비정상
			req.setAttribute("msg", "잘못된 경로로 들어오셨습니다!");
			req.setAttribute("loc", "javascript:history.back();");
			
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/msg.jsp");
			
			return;
		}
		
		String sizePerPage = req.getParameter("sizePerPage");
		
		if(sizePerPage == null || "".equals(sizePerPage)) {
			sizePerPage = "8";
		}
		
		InterProductDAO adao = new ProductDAO();
				
		// -- 검색조건에 맞는 총 게시물갯수 totalCount 알아오기 
		int totalCount = 0;
		
		if("0".equals(ldname)) { // 이경우 대분류 페이징 처리
			totalCount = adao.getTotalCountByLdcode(code, searchword); 
		}
		else {// (!"0".equals(ldname)) { // 소분류 페이징 처리
			totalCount = adao.getTotalCountBySdcode(code, searchword);
		}
		/*
		else { // 검색으로만 들어온 경우 (전체검색)
			totalCount = adao.getTotalCountBySearchword(searchword); 
		}
		*/		
		// -- 총 페이지수 totalPage 구하기
		int totalPage = (int)Math.ceil((double)totalCount/Integer.parseInt(sizePerPage)); 
		/*
		   57/10 ==> 5.7  ==> 6.0   ==> 6
		   57/5  ==> 11.4 ==> 12.0  ==> 12
		   57/3  ==> 19   ==> 19.0  ==> 19
		*/
		
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("totalPage", totalPage);
		
		String str_totalPage = jsonObj.toString();
		
		req.setAttribute("str_totalPage", str_totalPage);
		
		super.setRedirect(false);
		super.setViewPage("/WEB-INF/store/product/searchPageBarJSON.jsp");

	}

}

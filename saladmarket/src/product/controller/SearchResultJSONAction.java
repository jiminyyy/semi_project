package product.controller;

import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import common.controller.AbstractController;
import product.model.InterProductDAO;
import product.model.ProductDAO;

public class SearchResultJSONAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest req, HttpServletResponse res) throws Exception {
		
		String code = req.getParameter("code"); // code에 아무 값도 없다면 그건 전체검색이거나 오류다..gosearch에서는 오류다
		
		if(code == null || "".equals(code)) { // gosearch에서는 이경우 오류입니다...
			//contentList = adao.getSearchContent(sizePerPage, currentShowPageNo, searchword); 전체검색 메소드
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
		
		String str_currentShowPageNo = req.getParameter("currentShowPageNo");
		
		if(str_currentShowPageNo == null || "".equals(str_currentShowPageNo)) {
			str_currentShowPageNo = "1";
		}
		
		int	currentShowPageNo = Integer.parseInt(str_currentShowPageNo);
		int sizePerPage = 8; // 결과물
		
		InterProductDAO adao = new ProductDAO();
		
		List<HashMap<String, String>> contentList = null;
		
		if("0".equals(ldname)) { //code에 값이 있으나 ldname에는 없는경우 (대분류 진입입니다)
			contentList = adao.getSearchContentByLdcode(sizePerPage, currentShowPageNo, code, searchword);
		}
		else {// code값과 ldname값이 모두 있으면 code는 소분류 코드입니다.
			contentList = adao.getSearchContentBySdcode(sizePerPage, currentShowPageNo, code, searchword);
		}
		
		JSONArray jsonArray = new JSONArray();
		
		if(contentList != null && contentList.size() > 0) {
			for(HashMap<String, String> map : contentList) {
				JSONObject jsonObj = new JSONObject();
				// JSONObject 는 JSON형태(키:값)의 데이터를 관리해 주는 클래스이다.
				
			    jsonObj.put("pacimage", map.get("pacimage"));
			    jsonObj.put("stname", map.get("stname"));
			    jsonObj.put("prodname", map.get("prodname"));
			    jsonObj.put("saleprice", map.get("saleprice"));
			    jsonObj.put("price", map.get("price"));
			    
			    jsonArray.add(jsonObj);
			}
		}
		
		String str_jsonArray = jsonArray.toString();
		
		req.setAttribute("str_jsonArray", str_jsonArray);
				
		super.setRedirect(false);
		super.setViewPage("/WEB-INF/store/product/searchResultJSON.jsp");
		
	}

}

package product.controller;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import common.controller.AbstractController;
import product.model.InterProductDAO;
import product.model.ProductDAO;

public class SpecResultJSONAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest req, HttpServletResponse res) throws Exception {
		
		String code = req.getParameter("ldcode");
		
		if(code == null || "".equals(code) || "0".equals(code)) { // ldcode로 받아올 값이 없음 ( 대분류 없음)
			code = req.getParameter("sdcode");
		}
		
		if(code == null || "".equals(code)) { // 소분류 코드도 못 받아오면 오류다
			req.setAttribute("msg", "잘못된 경로로 들어오셨습니다!");
			req.setAttribute("loc", "javascript:history.back();");
			
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/msg.jsp");
			
			return;
		}
		
		String spec = req.getParameter("spec");
		
		if(spec == null || "".equals(spec)) { // 소분류 코드도 못 받아오면 오류다
			req.setAttribute("msg", "잘못된 경로로 들어오셨습니다!");
			req.setAttribute("loc", "javascript:history.back();");
			
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/msg.jsp");
			
			return;
		}
		
		InterProductDAO adao = new ProductDAO();
		
		List<HashMap<String, String>> contentList = null;
		
		String ldname = req.getParameter("ldname");
		
		if(ldname == null || "".equals(ldname)) { // ldname이 0이면 대분류 진입
			req.setAttribute("msg", "잘못된 경로로 들어오셨습니다!");
			req.setAttribute("loc", "javascript:history.back();");
			
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/msg.jsp");
			
			return;
		}
		
		else if("0".equals(ldname)) { // ldname이 0이면 대분류 진입
			contentList = adao.getContentBySpecNLdcode(code, spec);
		}
		
		else { // 소분류 진입 spec
			contentList = adao.getContentBySpecNSdcode(code, spec);
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
		super.setViewPage("/WEB-INF/store/product/specResultJSON.jsp");
		
	}

}

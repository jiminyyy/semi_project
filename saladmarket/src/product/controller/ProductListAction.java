package product.controller;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.controller.AbstractController;
import product.model.CategoryVO;
import product.model.InterProductDAO;
import product.model.ProductDAO;
import product.model.ProductVO;

public class ProductListAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest req, HttpServletResponse res) throws Exception {
		
		// 대분류 클릭 시
		String ldcode = req.getParameter("ldcode");
		// 소분류 클릭 시
		String sdcode = req.getParameter("sdcode");
		String ldname = req.getParameter("ldname");
		
		String spec = req.getParameter("spec");
		
		if("".equals(spec) || spec == null) {
			spec = "BEST";
		}
		
		if("".equals(ldcode) || ldcode == null) { // 대분류코드가 공백이거나 null일 경우
			ldcode = "0";
		}
		
		if("".equals(sdcode) || sdcode == null) { // 소분류코드가 공백이거나 null일 경우
			sdcode = "0";
		}
		
		if("".equals(ldname) || ldname == null) { // 소분류코드가 공백이거나 null일 경우
			ldname = "0";
		}
		
		if("0".equals(ldcode) && "0".equals(sdcode) && "0".equals(ldname)) {
			
			req.setAttribute("msg", "잘못된 경로로 들어오셨습니다!");
			req.setAttribute("loc", "javascript:history.back();");
			
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/msg.jsp");
			
			return;
			
		}
		
		req.setAttribute("ldcode", ldcode);
		req.setAttribute("ldname", ldname);
		req.setAttribute("sdcode", sdcode);
		req.setAttribute("spec", spec);
		
		super.setRedirect(false);
		super.setViewPage("/WEB-INF/store/product/productList.jsp");

	}

}

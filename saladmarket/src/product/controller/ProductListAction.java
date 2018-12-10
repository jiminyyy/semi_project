package product.controller;

import java.sql.SQLException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.controller.AbstractController;
import product.model.CategoryVO;
import product.model.ProductDAO;
import product.model.ProductVO;

public class ProductListAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest req, HttpServletResponse res) throws Exception {
		
		String ldCode = req.getParameter("ldCode");
		
		ProductDAO pdao = new ProductDAO();
		
		// ld코드를 통해 sdname을 가져와서 이를 통해 package리스트를 뽑아..
		//List<ProductVO> prodByCategoryList = pdao.getProductByCategory(ldCode);

		super.setRedirect(false);
		super.setViewPage("/WEB-INF/store/product/productList.jsp");

	}

}

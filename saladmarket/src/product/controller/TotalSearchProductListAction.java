package product.controller;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.controller.AbstractController;
import product.model.InterProductDAO;
import product.model.ProductDAO;
import store.util.MyUtil;

public class TotalSearchProductListAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest req, HttpServletResponse res) throws Exception {
		
		// 1. MemberDAO 객체 생성
		InterProductDAO pdao = new ProductDAO();
		
		// 2. 검색어 및 날짜 구간을 받아서 검색
		// 페이징 처리를 위해 페이지 당 보여줄 sizePerPage 받아오기
		String str_sizePerPage = req.getParameter("sizePerPage");
		int sizePerPage = 0; 
		try {
			sizePerPage = Integer.parseInt(str_sizePerPage);
		} catch (NumberFormatException e) {
			sizePerPage = 8;
		}
		/* 최근 몇일 이내 정렬값
		String str_period = req.getParameter("period");
		int period = 0; 
		try {
			period = Integer.parseInt(str_period);
		} catch (NumberFormatException e) {
			period = -1;
		}
		*/
		// String searchType = req.getParameter("searchType");
		
		String totalSearchWord = req.getParameter("totalSearchWord");
		
		// == 초기화면 설정 값 정하기 ==
		if(str_sizePerPage == null) {
			str_sizePerPage = "5";
		}
		/*
		if(str_period == null) {
			str_period = "-1";
		}
		
		if(searchType == null) {
			searchType = "name";
		}
		*/
		if(totalSearchWord == null) {
			totalSearchWord = "";
		}
		/*
		// GET방식 잘못된 경로일 경우 차단
		if(sizePerPage != 3 && sizePerPage != 5 && sizePerPage != 10) {
			sizePerPage = 5;
		}
		
		if(period != -1 && period != 3 && period != 10 && period != 30 && period != 60) {
			period = -1;
		}
		
		if(!"name".equals(searchType) &&
		   !"userid".equals(searchType) &&
		   !"email".equals(searchType)) {
			searchType = "name";
		}
		*/
		// 3. 전체 페이지 갯수 알아오기
		// 3-1. 총 상품 갯수
		int totalCount = 0;
		totalCount = pdao.getTotalSearchCount(totalSearchWord);
		
		// 3-2. 전체 페이지 수
		int totalPage = (int)Math.ceil((double)totalCount / sizePerPage);
		
		// 사용자가 보고자 선택한 페이지
		String str_currentShowPageNo = req.getParameter("currentShowPageNo");
		int currentShowPageNo = 0;
		
		if(str_currentShowPageNo == null) { // 처음 검색하고 들어왔을 때
			currentShowPageNo = 1;
		}
		else { // 사용자가 보고자 하는 페이지번호를 설정한 경우(목록보기를 통해 돌아왔을 때)
			try {
				currentShowPageNo = Integer.parseInt(str_currentShowPageNo);
				if(currentShowPageNo < 1 || currentShowPageNo > totalPage ) {
					currentShowPageNo = 1;
				}
			} catch (NumberFormatException e) {
				currentShowPageNo = 1;
			}
		}
		// 4. 검색 조건에 맞는 상품 정보를 select한 결과물을 가져와서 담는다.
		
		List<HashMap<String,String>> productList = null;
		productList = pdao.getSearchProduct(sizePerPage, currentShowPageNo, totalSearchWord);
		
		// 되돌아갈 URL
		String currentURL = MyUtil.getCurrentURL(req);
					
		// 5. 페이지 바 만들기
		String url = "totalSearchProductList.do";
		int blockSize = 3;
		String pageBar = MyUtil.getSearchPageBar(url, currentShowPageNo, sizePerPage, totalPage, blockSize, totalSearchWord);
		
		// 6. 지금까지 작성한 데이터값들을 VIEW단으로 넘긴다
		
		req.setAttribute("sizePerPage", sizePerPage);
		req.setAttribute("totalSearchWord", totalSearchWord);
		req.setAttribute("productList", productList);
		req.setAttribute("currentURL", currentURL);
		req.setAttribute("pageBar", pageBar);
		req.setAttribute("currentShowPageNo", currentShowPageNo);
		req.setAttribute("totalCount", totalCount);
		req.setAttribute("totalPage", totalPage);
		
		
		super.setRedirect(false);
		super.setViewPage("/WEB-INF/store/product/totalSearchProductList.jsp");

	}

}

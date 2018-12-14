package product.model;

import java.sql.*;
import java.util.*;

import member.model.MemberVO;

public interface InterProductDAO {
	
	// 카테고리 리스트 보여주기
	List<CategoryVO> getCategoryList() throws SQLException;
	
	// ld코드를 통한 카테고리의 상품 리스트
	// List<HashMap<String, String>> getProductByCategory(String ldCode) throws SQLException;
	
	//ld네임을통해 sd리스트 가져오기
	List<HashMap<String,String>> getsdList(String ldname) throws SQLException;
	
	//페이징처리를 포함한 상품리스트 ver.검색기능 (헤더의 전체검색)
	List<HashMap<String, String>> getSearchContent(int sizePerPage, int currentShowPageNo, String searchword) throws SQLException;
	
	//페이지처리를 포함한 상품리스트 ver.대분류
	List<HashMap<String, String>> getSearchContentByLdcode(int sizePerPage, int currentShowPageNo, String code, String searchword) throws SQLException;
	
	//페이징처리를 포함한 상품리스트 ver.소분류
	List<HashMap<String, String>> getSearchContentBySdcode(int sizePerPage, int currentShowPageNo, String code, String searchword) throws SQLException;
	
	// ldcode 토탈카운트 가져오기
	int getTotalCountByLdcode(String code, String searchword) throws SQLException;
	
	// sdcode 토탈카운트 가져오기
	int getTotalCountBySdcode(String code, String searchword) throws SQLException;

	// searchword 토탈카운트 가져오기
	//int getTotalCountBySearchword(String searchword) throws SQLException;
	
	// spac 상품 리스트 가져오기 ver.대분류
	List<HashMap<String, String>> getContentBySpecNLdcode(String code, String spec) throws SQLException;

	// spac 상품 리스트 가져오기 ver.소분류
	List<HashMap<String, String>> getContentBySpecNSdcode(String code, String spec) throws SQLException;
	
	// 헤더 전체 검색 시 카운트 가져오기
	int getTotalSearchCount(String totalSearchWord) throws SQLException;
	
	// 헤더 검색으로 나오는 상품 리스트
	List<HashMap<String,String>> getSearchProduct(int sizePerPage, int currentShowPageNo, String totalSearchWord) throws SQLException;
	
}

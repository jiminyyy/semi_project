package product.model;

import java.sql.*;
import java.util.*;

import member.model.MemberVO;

public interface InterProductDAO {
	
	//ldcode를 통해 상품리스트 가져오기
	//List<ProductVO> getProductByCategory(String ldCode);
	
	// 카테고리 리스트 보여주기
	List<CategoryVO> getCategoryList() throws SQLException;
	
	// ld코드를 통한 카테고리의 상품 리스트
	//List<ProductVO> getProductsByCategory(String code) throws SQLException;
	
	//ld네임을통해 sd리스트 가져오기
	List<HashMap<String,String>> getsdList(String ldname) throws SQLException;
	
	
	
}

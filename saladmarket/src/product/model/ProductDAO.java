package product.model;

import java.io.UnsupportedEncodingException;
import java.security.GeneralSecurityException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import jdbc.util.AES256;
import jdbc.util.SHA256;
import member.model.MemberVO;
import store.util.MyKey;

public class ProductDAO implements InterProductDAO {
	
	private DataSource ds = null;
	// 객체변수 ds는 아파치톰캣이 제공하는 DBCP

	private Connection conn = null;
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	
	AES256 aes = null;
	
	/*
		MemoDAO 생성자에서 해야할 일은 아파치톰캣이 제공하는 DBCP(DB Connection Pool) 객체인 ds를 얻어오는 것이다.
	*/
	
	public ProductDAO () {
		
		Context initContext;
		try {
			
			initContext = new InitialContext();
			Context envContext  = (Context)initContext.lookup("java:/comp/env");
			ds = (DataSource)envContext.lookup("jdbc/myoracle");
			
			String key = MyKey.key; // 암호화, 복호화 키
			aes = new AES256(key);
		
		} catch (NamingException e) {
			e.printStackTrace();
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}	
	} // 기본생성자
	
	// 사용한 자원 반납하는 메소드 생성
	public void close() {
		try {
			if(rs != null) {
			   rs.close();
			   rs = null;
			}
			
			if(pstmt != null) {
			   pstmt.close();
			   pstmt = null;
			}
			
			if(conn != null) { 
				conn.close();
				conn = null;
			}
			
		} catch(SQLException e) {
			e.printStackTrace();
		}
		
	} // end of close();

	//////////////////////////////////////////////////////////////////////////////////////////// 기본 설정
	
	@Override
	public List<CategoryVO> getCategoryList() throws SQLException {
		
		List<CategoryVO> categoryList = null;
		
		try {
			conn = ds.getConnection();
			
			String sql = " select ldnum, ldname " +
						 " from large_detail " +
						 " order by ldnum ";
			
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			int cnt = 0;
			
			while(rs.next()) {
				
				cnt ++;
				if(cnt == 1) {
					
					categoryList = new ArrayList<CategoryVO>();
				}
				
				String ldnum = rs.getString("ldnum");
				String ldname = rs.getString("ldname");
				
				CategoryVO ctgvo = new CategoryVO();
				
				ctgvo.setLdnum(ldnum);
				ctgvo.setLdname(ldname);
		
				categoryList.add(ctgvo);
			}
			
		} finally {
			close();
		}
		
		return categoryList;
	}

	@Override
	public List<ProductVO> getProductsByCategory(String code) throws SQLException {
		

		List<ProductVO> prodListByCtg = null;
		
		try {
			conn = ds.getConnection();
			
			String sql = " select pnum, pname, pcategory_fk, pcompany, pimage1, pimage2, pqty, price, saleprice, " + 
						 " pspec, pcontent, point, to_char(pinputdate, 'yyyy-mm-dd') as pinputdate "+
						 " from product "+
						 " where pcategory_fk = ? "+
						 " order by pnum desc ";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, code);
			rs = pstmt.executeQuery();
			
			int cnt = 0;
			
			while(rs.next()) {
				
				cnt ++;
				if(cnt == 1) {
					
					prodListByCtg = new ArrayList<ProductVO>();
				}
				
				int pnum = rs.getInt("pnum");
				String pname = rs.getString("pname");
				String pcategorycode = rs.getString("pcategory_fk");
				String pcompany = rs.getString("pcompany");
				String pimage1 = rs.getString("pimage1");
				String pimage2 = rs.getString("pimage2");
				int pqty = rs.getInt("pqty");
				int price = rs.getInt("price");
				int saleprice = rs.getInt("saleprice");
				String pspec = rs.getString("pspec");
				String pcontent = rs.getString("pcontent");
				int point = rs.getInt("point");
				String pinputdate = rs.getString("pinputdate");
				
				ProductVO pvo = new ProductVO(pnum, pname, pcategorycode, pcompany, pimage1, pimage2, 
											  pqty, price, saleprice, pspec, pcontent, point, pinputdate);
		
				prodListByCtg.add(pvo);
			}
			
		} finally {
			close();
		}
		
		return prodListByCtg;
	}



	
	
}

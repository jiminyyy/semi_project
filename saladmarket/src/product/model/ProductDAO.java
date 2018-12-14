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
	public List<HashMap<String, String>> getsdList(String ldname) throws SQLException {
		
		List<HashMap<String, String>> sdCtgList = null;
		try {
			conn = ds.getConnection();
			
			String sql = " select sdnum, fk_ldname, sdname "+
						 " from small_detail " +
						 " order by sdnum ";
			
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			int cnt = 0;
			
			while(rs.next()) {
				
				cnt ++;
				if(cnt == 1) {
					
					sdCtgList = new ArrayList<HashMap<String, String>>();
				}
				
				String sdnum = rs.getString("sdnum");
				String fk_ldname = rs.getString("fk_ldname");
				String sdname = rs.getString("sdname");
				
				HashMap<String, String> map = new HashMap<String, String>();
				
				map.put("sdnum", sdnum);
				map.put("fk_ldname", fk_ldname);
				map.put("sdname", sdname);
		
				sdCtgList.add(map);
			}
			
		} finally {
			close();
		}
		
		return sdCtgList;
	}
/*
	@Override
	public List<HashMap<String, String>> getProductByCategory(String ldCode) throws SQLException {
		
		List<HashMap<String, String>> productList = null;
		
		try {
			conn = ds.getConnection();
			
			String sql = " select rnum, pacnum, prodname, paccontents, pacimage, pnum\n"+
						 "         , sdname, ctname, stname, etname, pname, price\n"+
						 "         , saleprice, point, pqty, pcontents\n"+
						 "         , pcompanyname, pexpiredate, allergy, weight, salecount, plike, pdate\n"+
						 " from\n"+
						 " (\n"+
						 "     select rownum as rnum,pacnum, case when pacname = '없음' then pname else pacname end as prodname\n"+
						 " 						, paccontents, pacimage, pnum\n"+
						 " 						, sdname, ctname, stname, etname, pname, price\n"+
						 " 						, saleprice, point, pqty, pcontents\n"+
						 " 						, pcompanyname, pexpiredate, allergy, weight, salecount, plike, pdate\n"+
						 "     from \n"+
						 "     (\n"+
						 "         select pacnum, pacname, paccontents, pacimage, pnum\n"+
						 "                 , sdname, ctname, stname, etname, pname, price\n"+
						 "                 , saleprice, point, pqty, pcontents\n"+
						 "                 , pcompanyname, pexpiredate, allergy, weight, salecount, plike, pdate\n"+
						 "         from view_product\n"+
						 "  	   where sdname in (select sdname from small_detail where fk_ldname = (select ldname from large_detail where ldnum = ?))\n"+
						 "         order by pdate desc, pname asc\n"+
						 "     ) E\n"+
						 " ) F\n";
						 //" where rnum between 1 and 8";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, ldCode);
			rs = pstmt.executeQuery();
			
			int cnt = 0;
			
			while(rs.next()) {
				
				cnt ++;
				if(cnt == 1) {
					
					productList = new ArrayList<HashMap<String, String>>();
				}
				
				String rnum = rs.getString("rnum");
				String pacnum = rs.getString("pacnum");
				String prodname = rs.getString("prodname");
				String paccontents = rs.getString("paccontents");
				String pacimage = rs.getString("pacimage");
				String pnum = rs.getString("pnum");
				String sdname = rs.getString("sdname");
				String ctname = rs.getString("ctname");
				String stname = rs.getString("stname");
				String etname = rs.getString("etname");
				String pname = rs.getString("pname");
				String price = rs.getString("price");
				String saleprice = rs.getString("saleprice");
				String point = rs.getString("point");
				String pqty = rs.getString("pqty");
				String pcontents = rs.getString("pcontents");
				String pcompanyname = rs.getString("pcompanyname");
				String pexpiredate = rs.getString("pexpiredate");
				String allergy = rs.getString("allergy");
				String weight = rs.getString("weight");
				String salecount = rs.getString("salecount");
				String plike = rs.getString("plike");
				String pdate = rs.getString("pdate");
				
				HashMap<String, String> map = new HashMap<String, String>();
				
				map.put("rnum", rnum);
				map.put("pacnum", pacnum);
				map.put("prodname", prodname);
				map.put("paccontents", paccontents);
				map.put("pacimage", pacimage);
				map.put("pnum", pnum);
				map.put("sdname", sdname);
				map.put("ctname", ctname);
				map.put("stname", stname);
				map.put("etname", etname);
				map.put("pname", pname);
				map.put("price", price);
				map.put("saleprice", saleprice);
				map.put("point", point);
				map.put("pqty", pqty);
				map.put("pcontents", pcontents);
				map.put("pcompanyname", pcompanyname);
				map.put("pexpiredate", pexpiredate);
				map.put("allergy", allergy);
				map.put("weight", weight);
				map.put("salecount", salecount);
				map.put("plike", plike);
				map.put("pdate", pdate);
				
				productList.add(map);
			}
			
			
			
		}finally {
			close();
		}
		
		return productList;
	}
*/
	
	@Override
	public List<HashMap<String, String>> getSearchContent(int sizePerPage, int currentShowPageNo, String searchword) throws SQLException {
		
		List<HashMap<String, String>> productList = null;
		
		try {
			conn = ds.getConnection();
			
			String sql = " select rnum, pacnum, prodname, paccontents, pacimage, pnum\n"+
						 "		     , sdname, ctname, stname, etname, pname, price\n"+
						 "		     , saleprice, point, pqty, pcontents\n"+
						 "		     , pcompanyname, pexpiredate, allergy, weight, salecount, plike, pdate\n"+
						 " from\n"+
						 " (\n"+
						 " 	select rownum as rnum, pacnum, prodname, paccontents, pacimage, pnum\n"+
						 "         , sdname, ctname, stname, etname, pname, price\n"+
						 "         , saleprice, point, pqty, pcontents\n"+
						 "         , pcompanyname, pexpiredate, allergy, weight, salecount, plike, pdate\n"+
						 " from\n"+
						 " (\n"+
						 "     select rownum as rnum,pacnum, case when pacname = '없음' then pname else pacname end as prodname\n"+
						 " 						, paccontents, pacimage, pnum\n"+
						 " 						, sdname, ctname, stname, etname, pname, price\n"+
						 " 						, saleprice, point, pqty, pcontents\n"+
						 " 						, pcompanyname, pexpiredate, allergy, weight, salecount, plike, pdate\n"+
						 "     from \n"+
						 "     (\n"+
						 "         select pacnum, pacname, paccontents, pacimage, pnum\n"+
						 "                 , sdname, ctname, stname, etname, pname, price\n"+
						 "                 , saleprice, point, pqty, pcontents\n"+
						 "                 , pcompanyname, pexpiredate, allergy, weight, salecount, plike, pdate\n"+
						 "         from view_product\n"+
						 "         order by pdate desc, pname asc\n"+
						 "     ) E\n"+
						 " ) F\n" +
						 " where prodname like '%'|| ? || '%' \n"+
						 " ) T \n"+
						 " where rnum between ? and ? ";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, searchword);
			pstmt.setInt(2, (currentShowPageNo*sizePerPage) - (sizePerPage - 1) );
			pstmt.setInt(3, (currentShowPageNo*sizePerPage) );
			rs = pstmt.executeQuery();
			
			int cnt = 0;
			
			while(rs.next()) {
				
				cnt ++;
				if(cnt == 1) {
					
					productList = new ArrayList<HashMap<String, String>>();
				}
				
				String rnum = rs.getString("rnum");
				String pacnum = rs.getString("pacnum");
				String prodname = rs.getString("prodname");
				String paccontents = rs.getString("paccontents");
				String pacimage = rs.getString("pacimage");
				String pnum = rs.getString("pnum");
				String sdname = rs.getString("sdname");
				String ctname = rs.getString("ctname");
				String stname = rs.getString("stname");
				String etname = rs.getString("etname");
				String pname = rs.getString("pname");
				String price = rs.getString("price");
				String saleprice = rs.getString("saleprice");
				String point = rs.getString("point");
				String pqty = rs.getString("pqty");
				String pcontents = rs.getString("pcontents");
				String pcompanyname = rs.getString("pcompanyname");
				String pexpiredate = rs.getString("pexpiredate");
				String allergy = rs.getString("allergy");
				String weight = rs.getString("weight");
				String salecount = rs.getString("salecount");
				String plike = rs.getString("plike");
				String pdate = rs.getString("pdate");
				
				HashMap<String, String> map = new HashMap<String, String>();
				
				map.put("rnum", rnum);
				map.put("pacnum", pacnum);
				map.put("prodname", prodname);
				map.put("paccontents", paccontents);
				map.put("pacimage", pacimage);
				map.put("pnum", pnum);
				map.put("sdname", sdname);
				map.put("ctname", ctname);
				map.put("stname", stname);
				map.put("etname", etname);
				map.put("pname", pname);
				map.put("price", price);
				map.put("saleprice", saleprice);
				map.put("point", point);
				map.put("pqty", pqty);
				map.put("pcontents", pcontents);
				map.put("pcompanyname", pcompanyname);
				map.put("pexpiredate", pexpiredate);
				map.put("allergy", allergy);
				map.put("weight", weight);
				map.put("salecount", salecount);
				map.put("plike", plike);
				map.put("pdate", pdate);
				
				productList.add(map);
			}
			
			
			
		}finally {
			close();
		}
		
		return productList;
	}

	@Override
	public List<HashMap<String, String>> getSearchContentByLdcode(int sizePerPage, int currentShowPageNo, String code,
			String searchword) throws SQLException {

		List<HashMap<String, String>> productList = null;
		
		try {
			conn = ds.getConnection();
			
			System.out.println(sizePerPage);
			System.out.println(currentShowPageNo);
			System.out.println(code);
			System.out.println(searchword);
			
			String sql = "  select rnum, pacnum, prodname, paccontents, pacimage, pnum\n"+
					"		    , sdname, ctname, stname, etname, pname, price\n"+
					"		    , saleprice, point, pqty, pcontents\n"+
					"		    , pcompanyname, pexpiredate, allergy, weight, salecount, plike, pdate\n"+
					"from\n"+
					" (\n"+
					"	 select rownum as rnum, pacnum, prodname, paccontents, pacimage, pnum\n"+
					"		    , sdname, ctname, stname, etname, pname, price\n"+
					"		    , saleprice, point, pqty, pcontents\n"+
					"		    , pcompanyname, pexpiredate, allergy, weight, salecount, plike, pdate\n"+
					"	 from\n"+
					"	 (\n"+
					"		select rownum as rnum,pacnum, case when pacname = '없음' then pname else pacname end as prodname\n"+
					"							, paccontents, pacimage, pnum\n"+
					"							, sdname, ctname, stname, etname, pname, price\n"+
					"							, saleprice, point, pqty, pcontents\n"+
					"							, pcompanyname, pexpiredate, allergy, weight, salecount, plike, pdate\n"+
					"		from \n"+
					"		(\n"+
					"		    select pacnum, pacname, paccontents, pacimage, pnum\n"+
					"				  , sdname, ctname, stname, etname, pname, price\n"+
					"				  , saleprice, point, pqty, pcontents\n"+
					"				  , pcompanyname, pexpiredate, allergy, weight, salecount, plike, pdate\n"+
					"		    from view_product\n"+
					"		   where sdname in (select sdname from small_detail where fk_ldname = (select ldname from large_detail where ldnum = ?))\n"+
					"		    order by pdate desc, pname asc\n"+
					"		) E\n"+
					"	 ) F\n"+
					" where prodname like '%'|| ? || '%' \n"+
					" ) T \n"+
					" where rnum between ? and ? ";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, code);
			pstmt.setString(2, searchword);
			pstmt.setInt(3, (currentShowPageNo*sizePerPage) - (sizePerPage - 1) );
			pstmt.setInt(4, (currentShowPageNo*sizePerPage) );
			rs = pstmt.executeQuery();
			
			int cnt = 0;
			
			while(rs.next()) {
				
				cnt ++;
				if(cnt == 1) {
					
					productList = new ArrayList<HashMap<String, String>>();
				}
				
				String rnum = rs.getString("rnum");
				String pacnum = rs.getString("pacnum");
				String prodname = rs.getString("prodname");
				String paccontents = rs.getString("paccontents");
				String pacimage = rs.getString("pacimage");
				String pnum = rs.getString("pnum");
				String sdname = rs.getString("sdname");
				String ctname = rs.getString("ctname");
				String stname = rs.getString("stname");
				String etname = rs.getString("etname");
				String pname = rs.getString("pname");
				String price = rs.getString("price");
				String saleprice = rs.getString("saleprice");
				String point = rs.getString("point");
				String pqty = rs.getString("pqty");
				String pcontents = rs.getString("pcontents");
				String pcompanyname = rs.getString("pcompanyname");
				String pexpiredate = rs.getString("pexpiredate");
				String allergy = rs.getString("allergy");
				String weight = rs.getString("weight");
				String salecount = rs.getString("salecount");
				String plike = rs.getString("plike");
				String pdate = rs.getString("pdate");
				
				HashMap<String, String> map = new HashMap<String, String>();
				
				map.put("rnum", rnum);
				map.put("pacnum", pacnum);
				map.put("prodname", prodname);
				map.put("paccontents", paccontents);
				map.put("pacimage", pacimage);
				map.put("pnum", pnum);
				map.put("sdname", sdname);
				map.put("ctname", ctname);
				map.put("stname", stname);
				map.put("etname", etname);
				map.put("pname", pname);
				map.put("price", price);
				map.put("saleprice", saleprice);
				map.put("point", point);
				map.put("pqty", pqty);
				map.put("pcontents", pcontents);
				map.put("pcompanyname", pcompanyname);
				map.put("pexpiredate", pexpiredate);
				map.put("allergy", allergy);
				map.put("weight", weight);
				map.put("salecount", salecount);
				map.put("plike", plike);
				map.put("pdate", pdate);
				
				productList.add(map);
			}
			
			
			
		}finally {
			close();
		}
		
		return productList;
	}
	
	@Override
	public List<HashMap<String, String>> getSearchContentBySdcode(int sizePerPage, int currentShowPageNo, String code,
			String searchword) throws SQLException {

		List<HashMap<String, String>> productList = null;
		
		try {
			conn = ds.getConnection();
			
			System.out.println(sizePerPage);
			System.out.println(currentShowPageNo);
			System.out.println(code);
			System.out.println(searchword);
			
			String sql = "  select rnum, pacnum, prodname, paccontents, pacimage, pnum\n"+
					"		    , sdname, ctname, stname, etname, pname, price\n"+
					"		    , saleprice, point, pqty, pcontents\n"+
					"		    , pcompanyname, pexpiredate, allergy, weight, salecount, plike, pdate\n"+
					"from\n"+
					" (\n"+
					"	 select rownum as rnum, pacnum, prodname, paccontents, pacimage, pnum\n"+
					"		    , sdname, ctname, stname, etname, pname, price\n"+
					"		    , saleprice, point, pqty, pcontents\n"+
					"		    , pcompanyname, pexpiredate, allergy, weight, salecount, plike, pdate\n"+
					"	 from\n"+
					"	 (\n"+
					"		select rownum as rnum,pacnum, case when pacname = '없음' then pname else pacname end as prodname\n"+
					"							, paccontents, pacimage, pnum\n"+
					"							, sdname, ctname, stname, etname, pname, price\n"+
					"							, saleprice, point, pqty, pcontents\n"+
					"							, pcompanyname, pexpiredate, allergy, weight, salecount, plike, pdate\n"+
					"		from \n"+
					"		(\n"+
					"		    select pacnum, pacname, paccontents, pacimage, pnum\n"+
					"				  , sdname, ctname, stname, etname, pname, price\n"+
					"				  , saleprice, point, pqty, pcontents\n"+
					"				  , pcompanyname, pexpiredate, allergy, weight, salecount, plike, pdate\n"+
					"		    from view_product\n"+
					"		   where sdname in (select sdname from small_detail where sdnum = ?)\n"+
					"		    order by pdate desc, pname asc\n"+
					"		) E\n"+
					"	 ) F\n"+
					" where prodname like '%'|| ? || '%' \n"+
					" ) T \n"+
					" where rnum between ? and ? ";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, code);
			pstmt.setString(2, searchword);
			pstmt.setInt(3, (currentShowPageNo*sizePerPage) - (sizePerPage - 1) );
			pstmt.setInt(4, (currentShowPageNo*sizePerPage) );
			rs = pstmt.executeQuery();
			
			int cnt = 0;
			
			while(rs.next()) {
				
				cnt ++;
				if(cnt == 1) {
					
					productList = new ArrayList<HashMap<String, String>>();
				}
				
				String rnum = rs.getString("rnum");
				String pacnum = rs.getString("pacnum");
				String prodname = rs.getString("prodname");
				String paccontents = rs.getString("paccontents");
				String pacimage = rs.getString("pacimage");
				String pnum = rs.getString("pnum");
				String sdname = rs.getString("sdname");
				String ctname = rs.getString("ctname");
				String stname = rs.getString("stname");
				String etname = rs.getString("etname");
				String pname = rs.getString("pname");
				String price = rs.getString("price");
				String saleprice = rs.getString("saleprice");
				String point = rs.getString("point");
				String pqty = rs.getString("pqty");
				String pcontents = rs.getString("pcontents");
				String pcompanyname = rs.getString("pcompanyname");
				String pexpiredate = rs.getString("pexpiredate");
				String allergy = rs.getString("allergy");
				String weight = rs.getString("weight");
				String salecount = rs.getString("salecount");
				String plike = rs.getString("plike");
				String pdate = rs.getString("pdate");
				
				HashMap<String, String> map = new HashMap<String, String>();
				
				map.put("rnum", rnum);
				map.put("pacnum", pacnum);
				map.put("prodname", prodname);
				map.put("paccontents", paccontents);
				map.put("pacimage", pacimage);
				map.put("pnum", pnum);
				map.put("sdname", sdname);
				map.put("ctname", ctname);
				map.put("stname", stname);
				map.put("etname", etname);
				map.put("pname", pname);
				map.put("price", price);
				map.put("saleprice", saleprice);
				map.put("point", point);
				map.put("pqty", pqty);
				map.put("pcontents", pcontents);
				map.put("pcompanyname", pcompanyname);
				map.put("pexpiredate", pexpiredate);
				map.put("allergy", allergy);
				map.put("weight", weight);
				map.put("salecount", salecount);
				map.put("plike", plike);
				map.put("pdate", pdate);
				
				productList.add(map);
			}
			
			
			
		}finally {
			close();
		}
		
		return productList;
	}

	@Override
	public int getTotalCountByLdcode(String code, String searchword) throws SQLException {
		///////////////////////////////////////////////////////////////////////////////////////searchword
		int totalCount = 0;
		
		try {
			conn = ds.getConnection();
			// 객체 ds 를 통해 아파치톰캣이 제공하는 DBCP(DB Connection pool)에서 생성된 커넥션을 빌려온다.	
			
			String sql = " select count(*) AS CNT\n"+
						 " from\n"+
						 " (\n"+
						 "     select rownum as rnum,pacnum, case when pacname = '없음' then pname else pacname end as prodname\n"+
						 " 						, paccontents, pacimage, pnum\n"+
						 " 						, sdname, ctname, stname, etname, pname, price\n"+
						 " 						, saleprice, point, pqty, pcontents\n"+
						 " 						, pcompanyname, pexpiredate, allergy, weight, salecount, plike, pdate\n"+
						 "     from \n"+
						 "     (\n"+
						 "         select pacnum, pacname, paccontents, pacimage, pnum\n"+
						 "                 , sdname, ctname, stname, etname, pname, price\n"+
						 "                 , saleprice, point, pqty, pcontents\n"+
						 "                 , pcompanyname, pexpiredate, allergy, weight, salecount, plike, pdate\n"+
						 "         from view_product\n"+
						 "  	   where sdname in (select sdname from small_detail where fk_ldname = (select ldname from large_detail where ldnum = ?))\n"+
						 "         order by pdate desc, pname asc\n"+
						 "     ) E\n"+
						 " ) F\n" ;
					
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, code);
			
			rs = pstmt.executeQuery();
			
			rs.next();
			
			totalCount = rs.getInt("CNT");
			
		} finally {
			close();
		}
		
		return totalCount;
	}
	
	@Override
	public int getTotalCountBySdcode(String code, String searchword) throws SQLException {
		
		int totalCount = 0;
		
		try {
			conn = ds.getConnection();
			// 객체 ds 를 통해 아파치톰캣이 제공하는 DBCP(DB Connection pool)에서 생성된 커넥션을 빌려온다.	
			
			String sql = " select count(*) AS CNT\n"+
						 " from\n"+
						 " (\n"+
						 "     select rownum as rnum,pacnum, case when pacname = '없음' then pname else pacname end as prodname\n"+
						 " 						, paccontents, pacimage, pnum\n"+
						 " 						, sdname, ctname, stname, etname, pname, price\n"+
						 " 						, saleprice, point, pqty, pcontents\n"+
						 " 						, pcompanyname, pexpiredate, allergy, weight, salecount, plike, pdate\n"+
						 "     from \n"+
						 "     (\n"+
						 "         select pacnum, pacname, paccontents, pacimage, pnum\n"+
						 "                 , sdname, ctname, stname, etname, pname, price\n"+
						 "                 , saleprice, point, pqty, pcontents\n"+
						 "                 , pcompanyname, pexpiredate, allergy, weight, salecount, plike, pdate\n"+
						 "         from view_product\n"+
						 "  	   where sdname in (select sdname from small_detail where sdnum = ?)\n"+
						 "         order by pdate desc, pname asc\n"+
						 "     ) E\n"+
						 " ) F\n" ;
					
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, code);
			
			rs = pstmt.executeQuery();
			
			rs.next();
			
			totalCount = rs.getInt("CNT");
			
		} finally {
			close();
		}
		
		return totalCount;
	}

	@Override
	public int getTotalSearchCount(String totalSearchWord) throws SQLException {
		
		int totalCount = 0;
		
		try {
			conn = ds.getConnection();
			// 객체 ds 를 통해 아파치톰캣이 제공하는 DBCP(DB Connection pool)에서 생성된 커넥션을 빌려온다.	
			
			String sql = " select count(*) AS CNT\n"+
						 " from\n"+
						 " (\n"+
						 "     select rownum as rnum,pacnum, case when pacname = '없음' then pname else pacname end as prodname\n"+
						 " 						, paccontents, pacimage, pnum\n"+
						 " 						, sdname, ctname, stname, etname, pname, price\n"+
						 " 						, saleprice, point, pqty, pcontents\n"+
						 " 						, pcompanyname, pexpiredate, allergy, weight, salecount, plike, pdate\n"+
						 "     from \n"+
						 "     (\n"+
						 "         select pacnum, pacname, paccontents, pacimage, pnum\n"+
						 "                 , sdname, ctname, stname, etname, pname, price\n"+
						 "                 , saleprice, point, pqty, pcontents\n"+
						 "                 , pcompanyname, pexpiredate, allergy, weight, salecount, plike, pdate\n"+
						 "         from view_product\n"+
						 "         order by pdate desc, pname asc\n"+
						 "     ) E\n"+
						 " ) F\n" +
						 " where prodname like '%'|| ? || '%' ";
					
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, totalSearchWord);
			
			rs = pstmt.executeQuery();
			
			rs.next();
			
			totalCount = rs.getInt("CNT");
			
		} finally {
			close();
		}
		
		return totalCount;
	}

	@Override
	public List<HashMap<String, String>> getContentBySpecNLdcode(String code, String spec) throws SQLException {
		
		List<HashMap<String, String>> productList = null;
			
		try {
			conn = ds.getConnection();
			
			String sql = " select rnum, pacnum, prodname, paccontents, pacimage, pnum\n"+
						 "         , sdname, ctname, stname, etname, pname, price\n"+
						 "         , saleprice, point, pqty, pcontents\n"+
						 "         , pcompanyname, pexpiredate, allergy, weight, salecount, plike, pdate\n"+
						 " from\n"+
						 " (\n"+
						 "     select rownum as rnum,pacnum, case when pacname = '없음' then pname else pacname end as prodname\n"+
						 " 						, paccontents, pacimage, pnum\n"+
						 " 						, sdname, ctname, stname, etname, pname, price\n"+
						 " 						, saleprice, point, pqty, pcontents\n"+
						 " 						, pcompanyname, pexpiredate, allergy, weight, salecount, plike, pdate\n"+
						 "     from \n"+
						 "     (\n"+
						 "         select pacnum, pacname, paccontents, pacimage, pnum\n"+
						 "                 , sdname, ctname, stname, etname, pname, price\n"+
						 "                 , saleprice, point, pqty, pcontents\n"+
						 "                 , pcompanyname, pexpiredate, allergy, weight, salecount, plike, pdate\n"+
						 "         from view_product\n"+
						 "  	   where sdname in (select sdname from small_detail where fk_ldname = (select ldname from large_detail where ldnum = ?))\n"+
						 "         order by pdate desc, pname asc\n"+
						 "     ) E\n"+
						 " ) F\n" +
						 " where stname like '%'|| ? || '%' and rnum between 1 and 8 ";
				
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, code);
				pstmt.setString(2, spec);
				rs = pstmt.executeQuery();
				
				int cnt = 0;
				
				while(rs.next()) {
					
					cnt ++;
					if(cnt == 1) {
						
						productList = new ArrayList<HashMap<String, String>>();
					}
					
					String rnum = rs.getString("rnum");
					String pacnum = rs.getString("pacnum");
					String prodname = rs.getString("prodname");
					String paccontents = rs.getString("paccontents");
					String pacimage = rs.getString("pacimage");
					String pnum = rs.getString("pnum");
					String sdname = rs.getString("sdname");
					String ctname = rs.getString("ctname");
					String stname = rs.getString("stname");
					String etname = rs.getString("etname");
					String pname = rs.getString("pname");
					String price = rs.getString("price");
					String saleprice = rs.getString("saleprice");
					String point = rs.getString("point");
					String pqty = rs.getString("pqty");
					String pcontents = rs.getString("pcontents");
					String pcompanyname = rs.getString("pcompanyname");
					String pexpiredate = rs.getString("pexpiredate");
					String allergy = rs.getString("allergy");
					String weight = rs.getString("weight");
					String salecount = rs.getString("salecount");
					String plike = rs.getString("plike");
					String pdate = rs.getString("pdate");
					
					HashMap<String, String> map = new HashMap<String, String>();
					
					map.put("rnum", rnum);
					map.put("pacnum", pacnum);
					map.put("prodname", prodname);
					map.put("paccontents", paccontents);
					map.put("pacimage", pacimage);
					map.put("pnum", pnum);
					map.put("sdname", sdname);
					map.put("ctname", ctname);
					map.put("stname", stname);
					map.put("etname", etname);
					map.put("pname", pname);
					map.put("price", price);
					map.put("saleprice", saleprice);
					map.put("point", point);
					map.put("pqty", pqty);
					map.put("pcontents", pcontents);
					map.put("pcompanyname", pcompanyname);
					map.put("pexpiredate", pexpiredate);
					map.put("allergy", allergy);
					map.put("weight", weight);
					map.put("salecount", salecount);
					map.put("plike", plike);
					map.put("pdate", pdate);
					
					productList.add(map);
				}
				
			}finally {
				close();
			}
			
			return productList;
		}
	
	@Override
	public List<HashMap<String, String>> getContentBySpecNSdcode(String code, String spec) throws SQLException {
		
		List<HashMap<String, String>> productList = null;
					
		try {
			conn = ds.getConnection();
			
			String sql = " select rnum, pacnum, prodname, paccontents, pacimage, pnum\n"+
						 "         , sdname, ctname, stname, etname, pname, price\n"+
						 "         , saleprice, point, pqty, pcontents\n"+
						 "         , pcompanyname, pexpiredate, allergy, weight, salecount, plike, pdate\n"+
						 " from\n"+
						 " (\n"+
						 "     select rownum as rnum,pacnum, case when pacname = '없음' then pname else pacname end as prodname\n"+
						 " 						, paccontents, pacimage, pnum\n"+
						 " 						, sdname, ctname, stname, etname, pname, price\n"+
						 " 						, saleprice, point, pqty, pcontents\n"+
						 " 						, pcompanyname, pexpiredate, allergy, weight, salecount, plike, pdate\n"+
						 "     from \n"+
						 "     (\n"+
						 "         select pacnum, pacname, paccontents, pacimage, pnum\n"+
						 "                 , sdname, ctname, stname, etname, pname, price\n"+
						 "                 , saleprice, point, pqty, pcontents\n"+
						 "                 , pcompanyname, pexpiredate, allergy, weight, salecount, plike, pdate\n"+
						 "         from view_product\n"+
						 "  	   where sdname in (select sdname from small_detail where sdnum = ?)\n"+
						 "         order by pdate desc, pname asc\n"+
						 "     ) E\n"+
						 " ) F\n" +
						 " where stname like '%'|| ? || '%' and rnum between 1 and 8 ";
				
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, code);
				pstmt.setString(2, spec);
				rs = pstmt.executeQuery();
				
				int cnt = 0;
				
				while(rs.next()) {
					
					cnt ++;
					if(cnt == 1) {
						
						productList = new ArrayList<HashMap<String, String>>();
					}
					
					String rnum = rs.getString("rnum");
					String pacnum = rs.getString("pacnum");
					String prodname = rs.getString("prodname");
					String paccontents = rs.getString("paccontents");
					String pacimage = rs.getString("pacimage");
					String pnum = rs.getString("pnum");
					String sdname = rs.getString("sdname");
					String ctname = rs.getString("ctname");
					String stname = rs.getString("stname");
					String etname = rs.getString("etname");
					String pname = rs.getString("pname");
					String price = rs.getString("price");
					String saleprice = rs.getString("saleprice");
					String point = rs.getString("point");
					String pqty = rs.getString("pqty");
					String pcontents = rs.getString("pcontents");
					String pcompanyname = rs.getString("pcompanyname");
					String pexpiredate = rs.getString("pexpiredate");
					String allergy = rs.getString("allergy");
					String weight = rs.getString("weight");
					String salecount = rs.getString("salecount");
					String plike = rs.getString("plike");
					String pdate = rs.getString("pdate");
					
					HashMap<String, String> map = new HashMap<String, String>();
					
					map.put("rnum", rnum);
					map.put("pacnum", pacnum);
					map.put("prodname", prodname);
					map.put("paccontents", paccontents);
					map.put("pacimage", pacimage);
					map.put("pnum", pnum);
					map.put("sdname", sdname);
					map.put("ctname", ctname);
					map.put("stname", stname);
					map.put("etname", etname);
					map.put("pname", pname);
					map.put("price", price);
					map.put("saleprice", saleprice);
					map.put("point", point);
					map.put("pqty", pqty);
					map.put("pcontents", pcontents);
					map.put("pcompanyname", pcompanyname);
					map.put("pexpiredate", pexpiredate);
					map.put("allergy", allergy);
					map.put("weight", weight);
					map.put("salecount", salecount);
					map.put("plike", plike);
					map.put("pdate", pdate);
					
					productList.add(map);
				}
				
			}finally {
				close();
			}
			
			return productList;
		}
	
	@Override
	public List<HashMap<String, String>> getSearchProduct(int sizePerPage, int currentShowPageNo, String totalSearchWord) throws SQLException {

		List<HashMap<String, String>> productList = null;
		
		try {
			conn = ds.getConnection();
			
			String sql = "  select rnum, pacnum, prodname, paccontents, pacimage, pnum\n"+
					"		    , sdname, ctname, stname, etname, pname, price\n"+
					"		    , saleprice, point, pqty, pcontents\n"+
					"		    , pcompanyname, pexpiredate, allergy, weight, salecount, plike, pdate\n"+
					"from\n"+
					" (\n"+
					"	 select rownum as rnum, pacnum, prodname, paccontents, pacimage, pnum\n"+
					"		    , sdname, ctname, stname, etname, pname, price\n"+
					"		    , saleprice, point, pqty, pcontents\n"+
					"		    , pcompanyname, pexpiredate, allergy, weight, salecount, plike, pdate\n"+
					"	 from\n"+
					"	 (\n"+
					"		select rownum as rnum,pacnum, case when pacname = '없음' then pname else pacname end as prodname\n"+
					"							, paccontents, pacimage, pnum\n"+
					"							, sdname, ctname, stname, etname, pname, price\n"+
					"							, saleprice, point, pqty, pcontents\n"+
					"							, pcompanyname, pexpiredate, allergy, weight, salecount, plike, pdate\n"+
					"		from \n"+
					"		(\n"+
					"		    select pacnum, pacname, paccontents, pacimage, pnum\n"+
					"				  , sdname, ctname, stname, etname, pname, price\n"+
					"				  , saleprice, point, pqty, pcontents\n"+
					"				  , pcompanyname, pexpiredate, allergy, weight, salecount, plike, pdate\n"+
					"		    from view_product\n"+
					"		    order by pdate desc, pname asc\n"+
					"		) E\n"+
					"	 ) F\n"+
					" where prodname like '%'|| ? || '%' \n"+
					" ) T \n"+
					" where rnum between ? and ? ";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, totalSearchWord);
			pstmt.setInt(2, (currentShowPageNo*sizePerPage) - (sizePerPage - 1) );
			pstmt.setInt(3, (currentShowPageNo*sizePerPage) );
			rs = pstmt.executeQuery();
			
			int cnt = 0;
			
			while(rs.next()) {
				
				cnt ++;
				if(cnt == 1) {
					
					productList = new ArrayList<HashMap<String, String>>();
				}
				
				String rnum = rs.getString("rnum");
				String pacnum = rs.getString("pacnum");
				String prodname = rs.getString("prodname");
				String paccontents = rs.getString("paccontents");
				String pacimage = rs.getString("pacimage");
				String pnum = rs.getString("pnum");
				String sdname = rs.getString("sdname");
				String ctname = rs.getString("ctname");
				String stname = rs.getString("stname");
				String etname = rs.getString("etname");
				String pname = rs.getString("pname");
				String price = rs.getString("price");
				String saleprice = rs.getString("saleprice");
				String point = rs.getString("point");
				String pqty = rs.getString("pqty");
				String pcontents = rs.getString("pcontents");
				String pcompanyname = rs.getString("pcompanyname");
				String pexpiredate = rs.getString("pexpiredate");
				String allergy = rs.getString("allergy");
				String weight = rs.getString("weight");
				String salecount = rs.getString("salecount");
				String plike = rs.getString("plike");
				String pdate = rs.getString("pdate");
				
				HashMap<String, String> map = new HashMap<String, String>();
				
				map.put("rnum", rnum);
				map.put("pacnum", pacnum);
				map.put("prodname", prodname);
				map.put("paccontents", paccontents);
				map.put("pacimage", pacimage);
				map.put("pnum", pnum);
				map.put("sdname", sdname);
				map.put("ctname", ctname);
				map.put("stname", stname);
				map.put("etname", etname);
				map.put("pname", pname);
				map.put("price", price);
				map.put("saleprice", saleprice);
				map.put("point", point);
				map.put("pqty", pqty);
				map.put("pcontents", pcontents);
				map.put("pcompanyname", pcompanyname);
				map.put("pexpiredate", pexpiredate);
				map.put("allergy", allergy);
				map.put("weight", weight);
				map.put("salecount", salecount);
				map.put("plike", plike);
				map.put("pdate", pdate);
				
				productList.add(map);
			}
			
			
			
		}finally {
			close();
		}
		
		return productList;
	}
}

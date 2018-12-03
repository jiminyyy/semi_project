package member.model;

import java.io.UnsupportedEncodingException;
import java.security.GeneralSecurityException;
import java.sql.*;

import javax.naming.*;
import javax.sql.*;

import jdbc.util.AES256;
import store.util.MyKey;
import jdbc.util.SHA256;

import java.util.*;

public class MemberDAO implements InterMemberDAO {
	
	private DataSource ds = null;
	// 객체변수 ds는 아파치톰캣이 제공하는 DBCP

	private Connection conn = null;
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	
	AES256 aes = null;
	
	/*
		MemoDAO 생성자에서 해야할 일은 아파치톰캣이 제공하는 DBCP(DB Connection Pool) 객체인 ds를 얻어오는 것이다.
	*/
	
	public MemberDAO () {
		
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

	@Override
	public int idDuplicateCheck(String userid) throws SQLException {
		
		try {	
			conn = ds.getConnection();
			
			String sql = " select count(*) as cnt\n"+
						 " from member\n"+
						 " where userid = ? ";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, userid);
			
			rs = pstmt.executeQuery();
			
			rs.next();
			
			int cnt = rs.getInt("cnt");
			
			if(cnt == 1) { // id가 중복
				return 1;
			}
			else {
				return 0;
			}
		}  finally {
			close();
		}
		
	}
	
	@Override
	public int registerMember(MemberVO membervo) throws SQLException {
		
		int result = 0;
		
		int n1 = 0, n2 = 0, n3 = 0;
		try {	
			conn = ds.getConnection();
			
			conn.setAutoCommit(false);
			
			String sql = " insert into member(MNUM, USERID, NAME, EMAIL, PHONE, BIRTHDAY, POSTNUM, ADDRESS1, ADDRESS2, PWD) " + 
							" values(seq_member_mnum.nextval, ?, ?, ?, ?, ?, ?, ?, ?, ?) ";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, membervo.getUserid());
			pstmt.setString(2, membervo.getName());
			pstmt.setString(3, aes.encrypt( membervo.getEmail() ));			// AES256알고리즘으로 양방향 암호화
			pstmt.setString(4, aes.encrypt( membervo.getPhone() ));			// AES256알고리즘으로 양방향 암호화
			pstmt.setString(5, membervo.getBirthday());
			pstmt.setString(6, membervo.getPostnum());
			pstmt.setString(7, membervo.getAddr1());
			pstmt.setString(8, membervo.getAddr2());
			pstmt.setString(9, SHA256.encrypt( membervo.getPwd() ));		// SHA256알고리즘으로 단방향 암호화
			
			n1 = pstmt.executeUpdate();
			
			if(n1 == 1) {
				sql = " insert into my_coupon values(?, 1, add_months(sysdate, 3)) " ;
					  
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, membervo.getUserid());
				
				n2 = pstmt.executeUpdate();
				
				sql = " insert into my_coupon values(?, 2, add_months(sysdate, 3)) " ;
				  
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, membervo.getUserid());
				
				n3 = pstmt.executeUpdate();
				
				if(n2+n3 == 2) {
					conn.commit();
					result = 1;
				}
				else {
					conn.rollback();
					result = 0;
				}
				
			}
			else {
				conn.rollback();
				result = 0;
			}
			
		} catch (UnsupportedEncodingException | GeneralSecurityException e) {
			e.printStackTrace();
		} finally {
			close();
		}
		return result;
	} // end of public int registerMember(MemberVO membervo) throws SQLException {

}


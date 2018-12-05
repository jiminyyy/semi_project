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

	@Override
	public MemberVO loginOKmemberInfo(String userid, String pwd) throws SQLException {
			
		MemberVO membervo = null;
		
		try {
			conn = ds.getConnection();
			
			String sql = " select userid, name " +
						 " , trunc ( MONTHS_BETWEEN (sysdate, last_logindate ) ) as loginDategap " +
						 " , trunc ( MONTHS_BETWEEN (sysdate, last_changepwdate ) ) as pwdchangegap " +
						 " from member " +
						 " where status = 1 " +
						 " and userid = ? and pwd = ? ";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userid);
			pstmt.setString(2, SHA256.encrypt(pwd));
			
			rs = pstmt.executeQuery();
			
			boolean bool = rs.next();
			
			if(bool) {
				// 회원이 존재하는 경우
				String v_userid = rs.getString("userid");
				String name = rs.getString("name");
				
				int pwdchangegap = rs.getInt("pwdchangegap");
				int logindategap = rs.getInt("logindategap");
				
				membervo = new MemberVO();
				membervo.setUserid(v_userid);
				membervo.setName(name);
				
				// 마지막으로 암호를 변경한 날짜가 현재시각으로부터 6개월이 지낫으면 true
				if(pwdchangegap >= 6)
					membervo.setRequirePwdChange(true);
				
				if(logindategap >= 12) {
					membervo.setDormant(true);
				}
				else {
			
					// 로그인이 되었다면 로그인날짜 갱신
					sql = " update member set last_logindate = sysdate " +
						  " where userid = ? ";
					
					pstmt = conn.prepareStatement(sql);
					pstmt.setString(1, userid);
					pstmt.executeUpdate();
					
				}
			} // if(bool)
						
		} finally {
			close();
		}
		
		return membervo;
	}
	
	@Override
	public String getUserid(String name, String mobile) throws SQLException {
		
		String userid = null;
		
		try {
			conn = ds.getConnection();
			// DBCP 객체 ds를 통해 톰캣의 context.xml에 설정되어진 Connection 객체를 빌려오는 것이다.
		
			String sql = " select userid " +
						 " from member " +
						 " where status = 1 and name = ? and phone = ? ";
				
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, name);
				pstmt.setString(2, aes.encrypt(mobile));
				 
				rs = pstmt.executeQuery();
				
				if (rs.next()) {
					userid = rs.getString("userid");
				}
				
		} catch (UnsupportedEncodingException | GeneralSecurityException e) {
			e.printStackTrace();
		} finally {
			close();
		}
		return userid;
	}

	@Override
	public int isUserExists(String userid, String email) throws SQLException {
		
		 int n = 0;
		
		try {
			conn = ds.getConnection();
			// DBCP 객체 ds를 통해 톰캣의 context.xml에 설정되어진 Connection 객체를 빌려오는 것이다.
		
			String sql = " select count(*) as CNT " +
						 " from member " +
						 " where status = 1 and userid = ? and email = ? ";
				
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userid);
			pstmt.setString(2, aes.encrypt(email));
			
			rs = pstmt.executeQuery();
			
			rs.next();
			
			n = rs.getInt("CNT");
				
		} catch (UnsupportedEncodingException | GeneralSecurityException e) {
			e.printStackTrace();
		} finally {
			close();
		}
		return n;
	}

	@Override
	public int updatePwdUser(String userid, String pwd) throws SQLException {
		
		int result = 0;
		
		try {
			conn = ds.getConnection();
			// DBCP 객체 ds를 통해 톰캣의 context.xml에 설정되어진 Connection 객체를 빌려오는 것이다.
		
			String sql = " update member set pwd = ? " +
						 " , last_changepwdate = sysdate " +
						 " where userid = ? ";
				
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, SHA256.encrypt(pwd));
				pstmt.setString(2, userid);
				
				result = pstmt.executeUpdate();
		
		} finally {
			close();
		}
		
		return result;
	}


}


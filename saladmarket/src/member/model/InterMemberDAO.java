package member.model;

import java.sql.SQLException;
import java.util.List;

public interface InterMemberDAO {
	
	MemberVO loginOKmemberInfo(String userid, String pwd) throws SQLException;

	int idDuplicateCheck(String userid) throws SQLException;

	int registerMember(MemberVO membervo) throws SQLException;

	//int getTotalCount(String searchType, String searchWord, int period) throws SQLException;

	//List<MemberVO> getAllMember(int sizePerPage, int currentShowPageNo, int period, String searchType, String searchWord) throws SQLException;

	//int lastPwdChangeDateCheck(String userid) throws SQLException;

	//List<MemberVO> getActMember(int sizePerPage, int currentShowPageNo, int period, String searchType, String searchWord) throws SQLException;

	//int getActCount(String searchType, String searchWord, int period) throws SQLException;
	
	//int getMemberEnable(int idx) throws SQLException;

	//int getMemberDelete(int idx) throws SQLException;

	//int getMemberRecovery(int idx) throws SQLException;

	//MemberVO getMemberDetail(int idx) throws SQLException;

	//int updateMember(MemberVO membervo) throws SQLException;
	
	String getUserid(String name, String mobile) throws SQLException;
	
	int isUserExists(String userid, String email) throws SQLException;
	
	int updatePwdUser(String userid, String pwd) throws SQLException;
	
	//int coinAddUpdate(String idx, int coinmoney) throws SQLException;

}

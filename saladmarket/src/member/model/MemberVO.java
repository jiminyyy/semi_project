package member.model;

public class MemberVO {
	
	private String mnum;
	
	private String userid;
	private String name;
	private String email;
	private String phone;
	private String birthday;
	private String postnum;
	private String addr1;
	private String addr2;
	
	private int point;
	
	private String registerdate;
	private String last_logindate;
	private String last_changePwdate;
	
	private String status;
	
	private int sumMoney;
	
	private String fk_lvnum;

	public MemberVO() {
		
	}

	public MemberVO(String mnum, String userid, String name, String email, String phone, String birthday,
			String postnum, String addr1, String addr2, int point, String registerdate, String last_logindate,
			String last_changePwdate, String status, int sumMoney, String fk_lvnum) {
		super();
		this.mnum = mnum;
		this.userid = userid;
		this.name = name;
		this.email = email;
		this.phone = phone;
		this.birthday = birthday;
		this.postnum = postnum;
		this.addr1 = addr1;
		this.addr2 = addr2;
		this.point = point;
		this.registerdate = registerdate;
		this.last_logindate = last_logindate;
		this.last_changePwdate = last_changePwdate;
		this.status = status;
		this.sumMoney = sumMoney;
		this.fk_lvnum = fk_lvnum;
	}

	public String getMnum() {
		return mnum;
	}

	public void setMnum(String mnum) {
		this.mnum = mnum;
	}

	public String getUserid() {
		return userid;
	}

	public void setUserid(String userid) {
		this.userid = userid;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getBirthday() {
		return birthday;
	}

	public void setBirthday(String birthday) {
		this.birthday = birthday;
	}

	public String getPostnum() {
		return postnum;
	}

	public void setPostnum(String postnum) {
		this.postnum = postnum;
	}

	public String getAddr1() {
		return addr1;
	}

	public void setAddr1(String addr1) {
		this.addr1 = addr1;
	}

	public String getAddr2() {
		return addr2;
	}

	public void setAddr2(String addr2) {
		this.addr2 = addr2;
	}

	public int getPoint() {
		return point;
	}

	public void setPoint(int point) {
		this.point = point;
	}

	public String getRegisterdate() {
		return registerdate;
	}

	public void setRegisterdate(String registerdate) {
		this.registerdate = registerdate;
	}

	public String getLast_logindate() {
		return last_logindate;
	}

	public void setLast_logindate(String last_logindate) {
		this.last_logindate = last_logindate;
	}

	public String getLast_changePwdate() {
		return last_changePwdate;
	}

	public void setLast_changePwdate(String last_changePwdate) {
		this.last_changePwdate = last_changePwdate;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public int getSumMoney() {
		return sumMoney;
	}

	public void setSumMoney(int sumMoney) {
		this.sumMoney = sumMoney;
	}

	public String getFk_lvnum() {
		return fk_lvnum;
	}

	public void setFk_lvnum(String fk_lvnum) {
		this.fk_lvnum = fk_lvnum;
	}
	
}

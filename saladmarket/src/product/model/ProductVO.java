package product.model;

public class ProductVO {
	
	private String pnum;
	private String pacname;
	private String sdname;
	private String ctname;
	private String stname;
	private String etname;
	private String pname;
	private int price;
	private int saleprice;
	private int point;
	private int pqty;
	private String pcontents;
	private String pcompanyname;
	private String pexpiredate;
	private String allergy;
	private String weight;
	private int salecount;
	private int plike;
	private String pdate;
		
	public ProductVO() {
	}

	public ProductVO(String pnum, String pacname, String sdname, String ctname, String stname, String etname,
			String pname, int price, int saleprice, int point, int pqty, String pcontents, String pcompanyname,
			String pexpiredate, String allergy, String weight, int salecount, int plike, String pdate
			) {
		this.pnum = pnum;
		this.pacname = pacname;
		this.sdname = sdname;
		this.ctname = ctname;
		this.stname = stname;
		this.etname = etname;
		this.pname = pname;
		this.price = price;
		this.saleprice = saleprice;
		this.point = point;
		this.pqty = pqty;
		this.pcontents = pcontents;
		this.pcompanyname = pcompanyname;
		this.pexpiredate = pexpiredate;
		this.allergy = allergy;
		this.weight = weight;
		this.salecount = salecount;
		this.plike = plike;
		this.pdate = pdate;
	}

	public String getPnum() {
		return pnum;
	}

	public void setPnum(String pnum) {
		this.pnum = pnum;
	}

	public String getPacname() {
		return pacname;
	}

	public void setPacname(String pacname) {
		this.pacname = pacname;
	}

	public String getSdname() {
		return sdname;
	}

	public void setSdname(String sdname) {
		this.sdname = sdname;
	}

	public String getCtname() {
		return ctname;
	}

	public void setCtname(String ctname) {
		this.ctname = ctname;
	}

	public String getStname() {
		return stname;
	}

	public void setStname(String stname) {
		this.stname = stname;
	}

	public String getEtname() {
		return etname;
	}

	public void setEtname(String etname) {
		this.etname = etname;
	}

	public String getPname() {
		return pname;
	}

	public void setPname(String pname) {
		this.pname = pname;
	}

	public int getPrice() {
		return price;
	}

	public void setPrice(int price) {
		this.price = price;
	}

	public int getSaleprice() {
		return saleprice;
	}

	public void setSaleprice(int saleprice) {
		this.saleprice = saleprice;
	}

	public int getPoint() {
		return point;
	}

	public void setPoint(int point) {
		this.point = point;
	}

	public int getPqty() {
		return pqty;
	}

	public void setPqty(int pqty) {
		this.pqty = pqty;
	}

	public String getPcontents() {
		return pcontents;
	}

	public void setPcontents(String pcontents) {
		this.pcontents = pcontents;
	}

	public String getPcompanyname() {
		return pcompanyname;
	}

	public void setPcompanyname(String pcompanyname) {
		this.pcompanyname = pcompanyname;
	}

	public String getPexpiredate() {
		return pexpiredate;
	}

	public void setPexpiredate(String pexpiredate) {
		this.pexpiredate = pexpiredate;
	}

	public String getAllergy() {
		return allergy;
	}

	public void setAllergy(String allergy) {
		this.allergy = allergy;
	}

	public String getWeight() {
		return weight;
	}

	public void setWeight(String weight) {
		this.weight = weight;
	}

	public int getSalecount() {
		return salecount;
	}

	public void setSalecount(int salecount) {
		this.salecount = salecount;
	}

	public int getPlike() {
		return plike;
	}

	public void setPlike(int plike) {
		this.plike = plike;
	}

	public String getPdate() {
		return pdate;
	}

	public void setPdate(String pdate) {
		this.pdate = pdate;
	}

	

}

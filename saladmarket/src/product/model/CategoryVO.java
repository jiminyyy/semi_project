package product.model;

public class CategoryVO {

	private String ldnum;
	private String ldname;
	
	public CategoryVO() {
		super();
	}

	public CategoryVO(String ldnum, String ldname) {
		super();
		this.ldnum = ldnum;
		this.ldname = ldname;
	}

	public String getLdnum() {
		return ldnum;
	}

	public void setLdnum(String ldnum) {
		this.ldnum = ldnum;
	}

	public String getLdname() {
		return ldname;
	}

	public void setLdname(String ldname) {
		this.ldname = ldname;
	}
	
}

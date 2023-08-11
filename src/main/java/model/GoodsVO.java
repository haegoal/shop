package model;

public class GoodsVO {
	private String gid;
	private String maker;
	private String title;
	private String regDate;
	private String image;
	private int price;
	
	public String getGid() {
		return gid;
	}
	public void setGid(String gid) {
		this.gid = gid;
	}
	public String getMaker() {
		return maker;
	}
	public void setMaker(String maker) {
		this.maker = maker;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getRegDate() {
		return regDate;
	}
	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}
	public String getImage() {
		return image;
	}
	public void setImage(String image) {
		this.image = image;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	@Override
	public String toString() {
		return "GoodsVO [gid=" + gid + ", maker=" + maker + ", title=" + title + ", regDate=" + regDate + ", image="
				+ image + ", price=" + price + "]";
	}
}

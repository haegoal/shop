package model;

public class CartVO extends GoodsVO{
	private int qnt;

	public int getQnt() {
		return qnt;
	}

	public void setQnt(int qnt) {
		this.qnt = qnt;
	}

	@Override
	public String toString() {
		return "CartVO [qnt=" + qnt + ", getGid()=" + getGid() + ", getMaker()=" + getMaker() + ", getTitle()="
				+ getTitle() + ", getRegDate()=" + getRegDate() + ", getImage()=" + getImage() + ", getPrice()="
				+ getPrice() + "]";
	}
	
	
}

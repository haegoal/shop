package model;

public class PurchaseVO extends UserVO{
	private String pid;
	private String purDate;
	private int status;
	private int purSum;
	
	public String getPid() {
		return pid;
	}
	public void setPid(String pid) {
		this.pid = pid;
	}
	public String getPurDate() {
		return purDate;
	}
	public void setPurDate(String purDate) {
		this.purDate = purDate;
	}
	public int getStatus() {
		return status;
	}
	public void setStatus(int status) {
		this.status = status;
	}
	public int getPurSum() {
		return purSum;
	}
	public void setPurSum(int purSum) {
		this.purSum = purSum;
	}
	
	@Override
	public String toString() {
		return "PurchaseVO [pid=" + pid + ", purDate=" + purDate + ", status=" + status + ", purSum=" + purSum
				+ ", getUid()=" + getUid() + ", getUname()=" + getUname() + ", getPhone()=" + getPhone()
				+ ", getAddress1()=" + getAddress1() + ", getAddress2()=" + getAddress2() + "]";
	}
	
	
}

package iot.bean;

import java.sql.Timestamp;

public class Tgate {
	private int id;
	private int pid;
	private String gatename;
	private String gateid;
	private int gateenabled;
	private String remark;
	private String address;
	private Timestamp addtime;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getPid() {
		return pid;
	}
	public void setPid(int pid) {
		this.pid = pid;
	}
	public String getGatename() {
		return gatename;
	}
	public void setGatename(String gatename) {
		this.gatename = gatename;
	}
	public String getGateid() {
		return gateid;
	}
	public void setGateid(String gateid) {
		this.gateid = gateid;
	}
	public int getGateenabled() {
		return gateenabled;
	}
	public void setGateenabled(int gateenabled) {
		this.gateenabled = gateenabled;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public Timestamp getAddtime() {
		return addtime;
	}
	public void setAddtime(Timestamp addtime) {
		this.addtime = addtime;
	}
	
}

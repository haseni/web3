package iot.bean;
import java.sql.Timestamp;

import javax.ejb.Stateless;

@Stateless
public class DeviceTp implements java.io.Serializable {
	private Long id;
	private Long dtid;
	private String devicecode;
	private String devicename;
	private String deviceconfig;
	private String devicephoto;
	private String remark;
	private Timestamp addtime;
	private int deviceenabled;

	
	public DeviceTp(){
	}


	public Long getId() {
		return id;
	}


	public void setId(Long id) {
		this.id = id;
	}


	public Long getDtid() {
		return dtid;
	}


	public void setDtid(Long dtid) {
		this.dtid = dtid;
	}


	public String getDevicecode() {
		return devicecode;
	}


	public void setDevicecode(String devicecode) {
		this.devicecode = devicecode;
	}


	public String getDevicename() {
		return devicename;
	}


	public void setDevicename(String devicename) {
		this.devicename = devicename;
	}


	public String getDeviceconfig() {
		return deviceconfig;
	}


	public void setDeviceconfig(String deviceconfig) {
		this.deviceconfig = deviceconfig;
	}


	public String getDevicephoto() {
		return devicephoto;
	}


	public void setDevicephoto(String devicephoto) {
		this.devicephoto = devicephoto;
	}


	public String getRemark() {
		return remark;
	}


	public void setRemark(String remark) {
		this.remark = remark;
	}


	public Timestamp getAddtime() {
		return addtime;
	}


	public void setAddtime(Timestamp addtime) {
		this.addtime = addtime;
	}


	public int getDeviceenabled() {
		return deviceenabled;
	}


	public void setDeviceenabled(int deviceenabled) {
		this.deviceenabled = deviceenabled;
	}

	 
	
}

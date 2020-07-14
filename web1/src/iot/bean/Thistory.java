package iot.bean;
import java.sql.Timestamp;
public class Thistory {
	private Long id;
	private Long gdid;
	private Timestamp datetime;
	private String recorddata;
	private String remark;
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	public Long getGdid() {
		return gdid;
	}
	public void setGdid(Long gdid) {
		this.gdid = gdid;
	}
	public Timestamp getDatetime() {
		return datetime;
	}
	public void setDatetime(Timestamp datetime) {
		this.datetime = datetime;
	}
	public String getRecorddata() {
		return recorddata;
	}
	public void setRecorddata(String recorddata) {
		this.recorddata = recorddata;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
}
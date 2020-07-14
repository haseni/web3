package iot.dao;

import iot.bean.*;
import iot.utils.ConnDb;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class DeviceOp {
	private Connection cn = null;
	private PreparedStatement ps = null;
	private ResultSet rs = null;
	public static final int PAGE_LENGTH = 5;
	public void closedb() {
		try {
			if (rs != null) {
				rs.close();
			}
			if (ps != null) {
				ps.close();
			}
			if (cn != null) {
				cn.close();
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	// 查询,未分页
	public ArrayList<Device> query(String conStr) {
		ArrayList<Device> retlist = new ArrayList<Device>();
		try {
			cn = new ConnDb().getcon();
			String sqlstr = "select  * from  tdevicetype  ";
			if (conStr != "") {
				sqlstr = "select  * from  tdevicetype  where " + conStr + " ";
			}
			System.out.println(sqlstr);
			ps = cn.prepareStatement(sqlstr);

			rs = ps.executeQuery();
			while (rs.next()) {
				Device temp = new Device();
				temp.setId(rs.getLong("id"));
				temp.setDevicetypename(rs.getString("devicetypename"));
				temp.setDevicetypecode(rs.getString("devicetypecode"));
				temp.setDevicetypeconfig(rs.getString("devicetypeconfig"));
				temp.setRemark(rs.getString("remark"));
				temp.setAddtime(rs.getTimestamp("addtime"));
				 
				retlist.add(temp);
			}

		} catch (Exception e) {
			retlist = null;
			e.printStackTrace();
		} finally {
			this.closedb();
		}

		return retlist;
	}

	// 分页查询
	public ArrayList<Device> queryPage(String conStr, int page) {
		ArrayList<Device> retlist = new ArrayList<Device>();
		try {
			cn = new ConnDb().getcon();

			int begin = (page - 1) * PAGE_LENGTH;
			String sqllimit = "  order by id desc limit " + begin + ","
					+ PAGE_LENGTH;

			String sqlstr = "select  * from tdevicetype " + sqllimit;
			if (conStr != "") {
				sqlstr = "select  * from tdevicetype where " + conStr + sqllimit;
			}
			// System.out.println(sqlstr);
			ps = cn.prepareStatement(sqlstr);

			rs = ps.executeQuery();
			while (rs.next()) {
				Device temp = new Device();
				temp.setId(rs.getLong("id"));
				temp.setDevicetypename(rs.getString("devicetypename"));
				temp.setDevicetypecode(rs.getString("devicetypecode"));
				temp.setDevicetypeconfig(rs.getString("devicetypeconfig"));
				temp.setRemark(rs.getString("remark"));
				temp.setAddtime(rs.getTimestamp("addtime"));

				retlist.add(temp);
			}

		} catch (Exception e) {
			retlist = null;
			e.printStackTrace();
		} finally {
			this.closedb();
		}

		return retlist;
	}

public int count(String conStr) {

		int n = 0;
		try {
			cn = new ConnDb().getcon();
			String sqlstr = "select  count(*) from tdevicetype ";
			if (conStr != "") {
				sqlstr = "select  count(*) from tdevicetype where " + conStr;
			}
			// System.out.println(sqlstr);
			ps = cn.prepareStatement(sqlstr);

			rs = ps.executeQuery();
			if (rs.next()) {

				n = rs.getInt(1);

			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			this.closedb();
		}
		return n;
	}

	// 用户添加
	public boolean add(Device device) {
		boolean addFlag = false;
		try {
			cn = new ConnDb().getcon();
			String sqlstr = "insert into tdevicetype(devicetypename,devicetypecode,devicetypeconfig,addtime,remark) values(?,?,?,?,?) ";

			ps = cn.prepareStatement(sqlstr);
			// 采用参数构造法，避免用拼接方法带来的特殊字符冲突
			
		 
			ps.setString(1, device.getDevicetypename());
			ps.setString(2, device.getDevicetypecode());
			ps.setString(3, device.getDevicetypeconfig()); 
			ps.setTimestamp(4, device.getAddtime());
			ps.setString(5, device.getRemark());
			int rows = ps.executeUpdate();
			if (rows > 0) {
				addFlag = true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			this.closedb();
		}
		return addFlag;
	}
	 
	// 修改
	public boolean update(Device device) {
		boolean altFlag = false;
		try {
			cn = new ConnDb().getcon();
			String sqlstr = "update tdevicetype set  devicetypename=?,devicetypecode=?,devicetypeconfig=? where id=? ";

			ps = cn.prepareStatement(sqlstr);
			// 采用参数构造法，避免用拼接方法带来的特殊字符冲突
			ps.setString(1, device.getDevicetypename());
			ps.setString(2, device.getDevicetypecode());
			
			ps.setString(3, device.getDevicetypeconfig()); 
			ps.setLong(4, device.getId());

			int rows = ps.executeUpdate();
			if (rows > 0) {
				altFlag = true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			this.closedb();
		}
		return altFlag;
	}
 
	// 删除记录
	public boolean delete(String number) {
		boolean delFlag = false;
		try {
			cn = new ConnDb().getcon();

			String sqlstr = "delete from  tdevicetype  where id=" + number + "  ";
			ps = cn.prepareStatement(sqlstr);

			int rows = ps.executeUpdate();
			if (rows > 0) {
				delFlag = true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			this.closedb();
		}
		return delFlag;
	}
}

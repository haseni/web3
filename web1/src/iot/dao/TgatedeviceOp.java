package iot.dao;

import iot.bean.*;
import iot.utils.ConnDb;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class TgatedeviceOp {

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
	public ArrayList<tgatedevice> query(String conStr) {
		ArrayList<tgatedevice> retlist = new ArrayList<tgatedevice>();
		try {
			cn = new ConnDb().getcon();
			String sqlstr = "select  * from  tgatedevice  ";
			if (conStr != "") {
				sqlstr = "select  * from  tgatedevice  where " + conStr + " ";
			}
			System.out.println(sqlstr);
			ps = cn.prepareStatement(sqlstr);

			rs = ps.executeQuery();
			while (rs.next()) {
				tgatedevice temp = new tgatedevice();
				temp.setId(rs.getLong("id"));
				temp.setGid(rs.getLong("gid"));
				temp.setDid(rs.getLong("did"));
				temp.setClientdevicename(rs.getString("clientdevicename"));
				temp.setClientdevicestate(rs.getString("clientdevicestate"));
				temp.setClientdeviceid(rs.getString("clientdeviceid"));
				temp.setClientdeviceenabled(rs.getInt("clientdeviceenabled"));
				temp.setClientdeviceconfig(rs.getString("clientdeviceconfig"));
				 
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
	public ArrayList<tgatedevice> queryPage(String conStr, int page) {
		ArrayList<tgatedevice> retlist = new ArrayList<tgatedevice>();
		try {
			cn = new ConnDb().getcon();

			int begin = (page - 1) * PAGE_LENGTH;
			String sqllimit = "  order by id desc limit " + begin + ","
					+ PAGE_LENGTH;

			String sqlstr = "select  * from tgatedevice " + sqllimit;
			if (conStr != "") {
				sqlstr = "select  * from tgatedevice where " + conStr + sqllimit;
			}
			// System.out.println(sqlstr);
			ps = cn.prepareStatement(sqlstr);

			rs = ps.executeQuery();
			while (rs.next()) {
				tgatedevice temp = new tgatedevice();
				temp.setId(rs.getLong("id"));
				temp.setGid(rs.getLong("gid"));
				temp.setDid(rs.getLong("did"));
				temp.setClientdevicename(rs.getString("clientdevicename"));
				temp.setClientdevicestate(rs.getString("clientdevicestate"));
				temp.setClientdeviceid(rs.getString("clientdeviceid"));
				temp.setClientdeviceenabled(rs.getInt("clientdeviceenabled"));
				temp.setClientdeviceconfig(rs.getString("clientdeviceconfig"));
			 

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
			String sqlstr = "select  count(*) from tgatedevice ";
			if (conStr != "") {
				sqlstr = "select  count(*) from tgatedevice where " + conStr;
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
	public boolean add(tgatedevice tgate) {
		boolean addFlag = false;
		try {
			cn = new ConnDb().getcon();
			String sqlstr = "insert into tgatedevice(clientdevicename,clientdeviceenabled,clientdeviceid) values(?,?,?) ";

			ps = cn.prepareStatement(sqlstr);
			// 采用参数构造法，避免用拼接方法带来的特殊字符冲突
			ps.setString(1, tgate.getClientdevicename());
			ps.setInt(2, tgate.getClientdeviceenabled());
			ps.setString(3, tgate.getClientdeviceid());
			 
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
	public boolean update(tgatedevice tgate) {
		boolean altFlag = false;
		try {
			cn = new ConnDb().getcon();
			String sqlstr = "update tgatedevice set gid=?,  clientdevicename=?,clientdeviceenabled=?,clientdeviceid=? where id=? ";

			ps = cn.prepareStatement(sqlstr);
			// 采用参数构造法，避免用拼接方法带来的特殊字符冲突
			ps.setLong(1, tgate.getGid());
			ps.setString(2, tgate.getClientdevicename());
			ps.setInt(3, tgate.getClientdeviceenabled());
			ps.setString(4, tgate.getClientdeviceid());
			
			ps.setLong(5, tgate.getId());

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

			String sqlstr = "delete from  tgatedevice  where id=" + number + "  ";
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
	public String selectGatename(Long gid){
		String gatename="";
		try {
			cn = new ConnDb().getcon();
			String sqlstr = "select gatename from tgate where id="+gid;
			ps = cn.prepareStatement(sqlstr);
			rs = ps.executeQuery();
			if(rs.next()){
				gatename=rs.getString("gatename");
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			this.closedb();
		}
		return gatename;
	}
	
	public String selectProjectname(Long did){
		String projectname="";
		try {
			cn = new ConnDb().getcon();
			String sqlstr = "select projectname from tproject where id="+did;
			ps = cn.prepareStatement(sqlstr);
			rs = ps.executeQuery();
			if(rs.next()){
				projectname=rs.getString("projectname");
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			this.closedb();
		}
		return projectname;
	}
	
	public String selectDevicename(Long did){
		String devicename="";
		try {
			cn = new ConnDb().getcon();
			String sqlstr = "select devicename from tdevice where id="+did;
			ps = cn.prepareStatement(sqlstr);
			rs = ps.executeQuery();
			if(rs.next()){
				devicename=rs.getString("devicename");
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			this.closedb();
		}
		return devicename;
	}
	
}

package iot.dao;
import iot.bean.Tgate;
import iot.utils.CodeExchange;
import iot.utils.ConnDb;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.sql.Timestamp;
public class TgateDao {
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
	public ArrayList<Tgate> query(String conStr) {
		ArrayList<Tgate> retlist = new ArrayList<Tgate>();
		try {
			cn = new ConnDb().getcon();
			String sqlstr = "select  * from  tgate  ";
			if (conStr != "") {
				sqlstr = "select  * from  tgate  where " + conStr + " " ;
			}
			System.out.println(sqlstr);
			ps = cn.prepareStatement(sqlstr);

			rs = ps.executeQuery();
			while (rs.next()) {
				Tgate temp = new Tgate();
				temp.setId(rs.getInt("id"));
				temp.setPid(rs.getInt("pid"));
				temp.setGatename(rs.getString("gatename"));
				temp.setGateid(rs.getString("gateid"));
				temp.setGateenabled(rs.getInt("gateenabled"));
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
	public ArrayList<Tgate> queryPage(String conStr, int page) {
		ArrayList<Tgate> retlist = new ArrayList<Tgate>();
		try {
			cn = new ConnDb().getcon();

			int begin = (page - 1) * PAGE_LENGTH;
			String sqllimit = "  order by id desc limit " + begin + ","
					+ PAGE_LENGTH;

			String sqlstr = "select  * from tgate " + sqllimit;
			if (conStr != "") {
				sqlstr = "select  * from tgate where " + conStr + sqllimit;
			}
			// System.out.println(sqlstr);
			ps = cn.prepareStatement(sqlstr);

			rs = ps.executeQuery();
			while (rs.next()) {
				Tgate temp = new Tgate();
				temp.setId(rs.getInt("id"));
				temp.setPid(rs.getInt("pid"));
				temp.setGatename(rs.getString("gatename"));
				temp.setGateid(rs.getString("gateid"));
				temp.setGateenabled(rs.getInt("gateenabled"));
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
	
/*	//普通用户查找
	public ArrayList<Tgate> queryPage01(String conStr, int page) {
		ArrayList<Tgate> retlist = new ArrayList<Tgate>();
		try {
			cn = new ConnDb().getcon();
			Tgate user=new Tgate();
		
			
			int begin = (page - 1) * PAGE_LENGTH;
			String sqllimit = "  order by id desc limit " + begin + ","
					+ PAGE_LENGTH;

			String sqlstr = "select  * from tgate " + sqllimit;
			if (conStr != "") {
				sqlstr = "select  * from tgate where " + conStr +   sqllimit  ;
			}
			// System.out.println(sqlstr);
			ps = cn.prepareStatement(sqlstr);

			rs = ps.executeQuery();
			
			while (rs.next()) {
				Tgate temp = new Tgate();
				temp.setId(rs.getInt("id"));
				temp.setPid(rs.getInt("pid"));
				temp.setGateid(rs.getString("gateid"));
				temp.setGateenabled(rs.getInt("gateenabled"));
				temp.setRemark(rs.getString("remark"));
				temp.setAddtime(rs.getTimestamp("addtime"));
				retlist.add(temp);
				if(rs.getString("usertype").length()==4){
				retlist.add(temp);
			}
			}
		
		} catch (Exception e) {
			retlist = null;
			e.printStackTrace();
		} finally {
			this.closedb();
		}

		return retlist;
	}
*/
	public int count(String conStr) {

		int n = 0;
		try {
			cn = new ConnDb().getcon();
			String sqlstr = "select  count(*) from tgate ";
			if (conStr != "") {
				sqlstr = "select  count(*) from tgate where " + conStr;
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
	public boolean add(Tgate gate) {
		boolean addFlag = false;
		try {
			cn = new ConnDb().getcon();
			String sqlstr = "insert into tgate(pid,gatename,gateid,gateenabled,remark,addtime) values(?,?,?,?,?,?) ";

			ps = cn.prepareStatement(sqlstr);
			// 采用参数构造法，避免用拼接方法带来的特殊字符冲突
			ps.setInt(1, gate.getPid());
			ps.setString(2, gate.getGatename());
			ps.setString(3, gate.getGateid());
			ps.setInt(4, gate.getGateenabled());
			ps.setString(5, gate.getRemark());
			ps.setTimestamp(6, gate.getAddtime());

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
	public boolean update(Tgate gate) {
		boolean Flag = false;
		try {
			cn = new ConnDb().getcon();
			String sqlstr = "update tgate set  pid=?,gatename=?,gateid=?,gateenabled=?   where  id=? ";

			ps = cn.prepareStatement(sqlstr);
			// 采用参数构造法，避免用拼接方法带来的特殊字符冲突
			ps.setInt(1, gate.getPid());
			ps.setString(2, gate.getGatename());
			ps.setString(3, gate.getGateid());
			ps.setInt(4, gate.getGateenabled());
		 
			ps.setLong(5, gate.getId());
			
		int rows = ps.executeUpdate();
		if (rows > 0) {
			Flag = true;
		}
	}catch (Exception e) {
		e.printStackTrace();
	} finally {
		this.closedb();
	}
	return Flag;
}

	// 删除记录
	public boolean delete(String number) {
		boolean delFlag = false;
		try {
			cn = new ConnDb().getcon();

			String sqlstr = "delete from  tgate  where id=" + number + "  ";
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
	public String selectProjectname(Long pid){
		String projectname="";
		try {
			cn = new ConnDb().getcon();
			String sqlstr = "select projectname from tproject where id="+pid;
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

}

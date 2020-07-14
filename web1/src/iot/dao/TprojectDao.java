package iot.dao;
import iot.bean.Tproject;
import iot.utils.ConnDb;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
public class TprojectDao {
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
	public ArrayList<Tproject> query(String conStr) {
		ArrayList<Tproject> retlist = new ArrayList<Tproject>();
		try {
			cn = new ConnDb().getcon();
			String sqlstr = "select  * from tproject  ";
			if (conStr != "") {
				sqlstr = "select  * from tproject where " + conStr + " ";
			}
			System.out.println(sqlstr);
			ps = cn.prepareStatement(sqlstr);

			rs = ps.executeQuery();
			while (rs.next()) {
				Tproject temp = new Tproject();
				temp.setId(rs.getLong("id"));
				temp.setUid(rs.getLong("uid"));
				temp.setProjectname(rs.getString("projectname"));
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
	public ArrayList<Tproject> queryPage(String conStr, int page) {
		ArrayList<Tproject> retlist = new ArrayList<Tproject>();
		try {
			cn = new ConnDb().getcon();

			int begin = (page - 1) * PAGE_LENGTH;
			String sqllimit = "  order by id desc limit " + begin + ","
					+ PAGE_LENGTH;

			String sqlstr = "select  * from  tproject " + sqllimit;
			if (conStr != "") {
				sqlstr = "select  * from  tproject  where " + conStr + sqllimit;
			}
			// System.out.println(sqlstr);
			ps = cn.prepareStatement(sqlstr);

			rs = ps.executeQuery();
			while (rs.next()) {
				Tproject temp = new Tproject();
				temp.setId(rs.getLong("id"));
				temp.setUid(rs.getLong("uid"));
				temp.setProjectname(rs.getString("projectname"));
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
			String sqlstr = "select  count(*) from tproject ";
			if (conStr != "") {
				sqlstr = "select  count(*) from tproject where " + conStr;
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
	public boolean add(Tproject tproject) {
		boolean addFlag = false;
		try {
			cn = new ConnDb().getcon();
			String sqlstr = "insert into tproject(uid,projectname,remark,addtime) values(?,?,?,?) ";

			ps = cn.prepareStatement(sqlstr);
			// 采用参数构造法，避免用拼接方法带来的特殊字符冲突
			ps.setString(2, tproject.getProjectname());
			ps.setLong(1, tproject. getUid());
			ps.setString(3, tproject.getRemark());
			ps.setTimestamp(4, tproject.getAddtime());

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
	public boolean update(Tproject tproject) {
		boolean altFlag = false;
		try {
			cn = new ConnDb().getcon();
			String sqlstr = "update tproject set  projectname=?,remark=?,uid=?  where id=? ";

			ps = cn.prepareStatement(sqlstr);
			// 采用参数构造法，避免用拼接方法带来的特殊字符冲突
			
			
			ps.setString(1, tproject.getProjectname());
			ps.setString(2, tproject.getRemark());
			ps.setLong(3, tproject.getUid());
			/*ps.setTimestamp(4, tproject. getAddtime());*/
			ps.setLong(4, tproject.getId());
			

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

			String sqlstr = "delete from  tproject  where id=" + number + "  ";
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

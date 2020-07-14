package iot.dao;
import iot.bean.Tuser;
import iot.utils.CodeExchange;
import iot.utils.ConnDb;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
public class UserDao {
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

	// ��ѯ,δ��ҳ
	public ArrayList<Tuser> query(String conStr) {
		ArrayList<Tuser> retlist = new ArrayList<Tuser>();
		try {
			cn = new ConnDb().getcon();
			String sqlstr = "select  * from  tuser  ";
			if (conStr != "") {
				sqlstr = "select  * from  tuser  where " + conStr + " " ;
			}
			System.out.println(sqlstr);
			ps = cn.prepareStatement(sqlstr);

			rs = ps.executeQuery();
			while (rs.next()) {
				Tuser temp = new Tuser();
				temp.setId(rs.getLong("id"));
				temp.setUsername(rs.getString("username"));
				temp.setPassword(rs.getString("password"));
				temp.setTruename(rs.getString("truename"));
				temp.setTelephone(rs.getString("telephone"));
				temp.setAddress(rs.getString("address"));
				temp.setUsertype(rs.getString("usertype"));
				temp.setUserenabled(rs.getInt("userenabled"));
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

	// ��ҳ��ѯ
	public ArrayList<Tuser> queryPage(String conStr, int page) {
		ArrayList<Tuser> retlist = new ArrayList<Tuser>();
		try {
			cn = new ConnDb().getcon();

			int begin = (page - 1) * PAGE_LENGTH;
			String sqllimit = "  order by id desc limit " + begin + ","
					+ PAGE_LENGTH;

			String sqlstr = "select  * from tuser " + sqllimit;
			if (conStr != "") {
				sqlstr = "select  * from tuser where " + conStr + sqllimit;
			}
			// System.out.println(sqlstr);
			ps = cn.prepareStatement(sqlstr);

			rs = ps.executeQuery();
			while (rs.next()) {
				Tuser temp = new Tuser();
				temp.setId(rs.getLong("id"));
				temp.setUsername(rs.getString("username"));
				temp.setPassword(rs.getString("password"));
				temp.setTruename(rs.getString("truename"));
				temp.setTelephone(rs.getString("telephone"));
				temp.setAddress(rs.getString("address"));
				temp.setUsertype(rs.getString("usertype"));
				temp.setUserenabled(rs.getInt("userenabled"));
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
	
	//��ͨ�û�����
	public ArrayList<Tuser> queryPage01(String conStr, int page) {
		ArrayList<Tuser> retlist = new ArrayList<Tuser>();
		try {
			cn = new ConnDb().getcon();
			Tuser user=new Tuser();
		
			
			int begin = (page - 1) * PAGE_LENGTH;
			String sqllimit = "  order by id desc limit " + begin + ","
					+ PAGE_LENGTH;

			String sqlstr = "select  * from tuser " + sqllimit;
			if (conStr != "") {
				sqlstr = "select  * from tuser where " + conStr +   sqllimit  ;
			}
			// System.out.println(sqlstr);
			ps = cn.prepareStatement(sqlstr);

			rs = ps.executeQuery();
			
			while (rs.next()) {
				Tuser temp = new Tuser();
				temp.setId(rs.getLong("id"));
				temp.setUsername(rs.getString("username"));
				temp.setPassword(rs.getString("password"));
				temp.setTruename(rs.getString("truename"));
				temp.setTelephone(rs.getString("telephone"));
				temp.setAddress(rs.getString("address"));
				temp.setUsertype(rs.getString("usertype"));
				temp.setUserenabled(rs.getInt("userenabled"));
				temp.setAddtime(rs.getTimestamp("addtime"));
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
//�ο�
	public ArrayList<Tuser> queryPage02(String conStr, int page) {
		ArrayList<Tuser> retlist = new ArrayList<Tuser>();
		try {
			cn = new ConnDb().getcon();
			Tuser user=new Tuser();
		
			
			int begin = (page - 1) * PAGE_LENGTH;
			String sqllimit = "  order by id desc limit " + begin + ","
					+ PAGE_LENGTH;

			String sqlstr = "select  * from tuser " + sqllimit;
			if (conStr != "") {
				sqlstr = "select  * from tuser where " + conStr +   sqllimit  ;
			}
			// System.out.println(sqlstr);
			ps = cn.prepareStatement(sqlstr);

			rs = ps.executeQuery();
			
			while (rs.next()) {
				Tuser temp = new Tuser();
				temp.setId(rs.getLong("id"));
				temp.setUsername(rs.getString("username"));
				temp.setPassword(rs.getString("password"));
				temp.setTruename(rs.getString("truename"));
				temp.setTelephone(rs.getString("telephone"));
				temp.setAddress(rs.getString("address"));
				temp.setUsertype(rs.getString("usertype"));
				temp.setUserenabled(rs.getInt("userenabled"));
				temp.setAddtime(rs.getTimestamp("addtime"));
				if(rs.getString("usertype").length()==2){
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

	public int count(String conStr) {

		int n = 0;
		try {
			cn = new ConnDb().getcon();
			String sqlstr = "select  count(*) from tuser ";
			if (conStr != "") {
				sqlstr = "select  count(*) from tuser where " + conStr;
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

	// �û����
	public boolean add(Tuser user) {
		boolean addFlag = false;
		try {
			cn = new ConnDb().getcon();
			String sqlstr = "insert into tuser(username,password,usertype) values(?,?,?) ";

			ps = cn.prepareStatement(sqlstr);
			// ���ò������취��������ƴ�ӷ��������������ַ���ͻ
			ps.setString(1, user.getUsername());
			ps.setString(2, user.getPassword());
			ps.setString(3, user.getUsertype());

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

	// �޸�
	public boolean update(Tuser user) {
		boolean altFlag = false;
		try {
			cn = new ConnDb().getcon();
			String sqlstr = "update tuser set  username=?,password=?,usertype=? where id=? ";

			ps = cn.prepareStatement(sqlstr);
			// ���ò������취��������ƴ�ӷ��������������ַ���ͻ
			ps.setString(1, user.getUsername());
			ps.setString(2, user.getPassword());
			ps.setString(3, user.getUsertype());
			ps.setLong(4, user.getId());

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

	// ɾ����¼
	public boolean delete(String number) {
		boolean delFlag = false;
		try {
			cn = new ConnDb().getcon();

			String sqlstr = "delete from  tuser  where id=" + number + "  ";
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

package iot.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import iot.bean.*;
import iot.utils.ConnDb;

public class JsonDao {
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
	
	public boolean add(Json json) {
		boolean addFlag = false;
		try {
			cn = new ConnDb().getcon();
			String sqlstr = "insert into thistorydata(gdid,recordtime,recorddata) values(?,?,?) ";

			ps = cn.prepareStatement(sqlstr);
			// ���ò������취��������ƴ�ӷ��������������ַ���ͻ
			ps.setString(1, json.getMsg());
			ps.setTimestamp(2, json.getRecordtime());
			ps.setObject(3, json.getObj());

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
}

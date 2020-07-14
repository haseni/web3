package iot.dao;
import iot.utils.ConnDb;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
public class HistoryDao {
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
	public ArrayList<String> get(String starttime,String endtime,Long gdid){
		ArrayList<String> retlist = new ArrayList<String>();
		try {
			cn = new ConnDb().getcon();
			String sqlstr = "select * from thistorydata where gdid="+gdid+" and recordtime >= '"+starttime+"' and recordtime<= '"+endtime+"'";
			ps = cn.prepareStatement(sqlstr);
			rs = ps.executeQuery();
			while(rs.next()){
				String temp=new String();
				temp=rs.getString("recorddata");
				String time=rs.getString("recordtime");
				temp=temp.substring(0, temp.length()-1);
				temp=temp+",\"time\":\""+time.substring(0, time.length()-2)+"\"}";
				retlist.add(temp);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			this.closedb();
		}
		return retlist;
	}
}
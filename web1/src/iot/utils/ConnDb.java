package iot.utils;
import java.sql.Connection;
import java.sql.DriverManager;
import javax.swing.JOptionPane;
public class ConnDb {
	private Connection cn=null;	
	public Connection getcon(){	    
		try {
			String url="jdbc:mysql://localhost:3306/iotdb?useUnicode=true&characterEncoding=utf8";
			Class.forName("com.mysql.jdbc.Driver");
			String userName ="root";
			String password="123456";//ע����ݻ������˺���������޸�
			cn =DriverManager.getConnection(url,userName,password);
		} catch (Exception e) {
			// TODO Auto-generated catch block            
			e.printStackTrace();
		} 

	    return cn;
	}
}

package bean;

import java.sql.Connection;
import java.sql.DriverManager;

import javax.swing.JOptionPane;

public class conndb {
	private Connection cn=null;
	
	public Connection getcon(){
	    
		try {
			//Class.forName("com.mysql.jdbc.Driver").newInstance();
			//String url="Jdbc:mysql://localhost:3306/onlineshop?user=root&password=''";
			//cn=DriverManager.getConnection(url);
			String url="jdbc:mysql://localhost:3306/iotdb";
			Class.forName("com.mysql.jdbc.Driver");
			String userName ="root";
			String password="123456";
			cn =DriverManager.getConnection(url,userName,password);
			if(cn==null)
            JOptionPane.showMessageDialog(null, "Can not connect to DB!");
		} catch (Exception e) {
			// TODO Auto-generated catch block
            JOptionPane.showMessageDialog(null, "Can not connect to DB!");
			e.printStackTrace();
		} 

	    return cn;
	}
}

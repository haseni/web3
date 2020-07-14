package bean;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.swing.JOptionPane;

public class userCheck {
	private PreparedStatement ps;
	private ResultSet rs;
	private Connection con=null;
	public void close(){
		try{
			if(ps!=null){
				ps.close();
				ps=null;
			}
			if(rs!=null){
				rs.close();
				rs=null;				
			}
			if(con!=null){
				con.close();
				con=null;
			}
		}catch(Exception e){
			e.printStackTrace();
		}		    
	}
	
	public String getUser(String un,String pswd){
		String strres="userwrong";
		try{
			con=new conndb().getcon();
			String sqlstr= "select user_account,user_password from yydk_user where user_account='"+un+"'";
			ps=con.prepareStatement(sqlstr);
			rs=ps.executeQuery();
			String pd="";
			if(rs.next()){
				strres="passwordwrong";
				pd=rs.getString("user_password").trim();
				if(pswd.equals(pd))
				{
					strres=rs.getString("user_account").trim();
				}
				//JOptionPane.showMessageDialog(null, pswd+","+pd);
			}
			return strres;
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			this.close();
		}
		
		return strres;
	}
	
	public String checkUser(String un){
		String strres="";
		if(!un.equals(""))
		{
			try{
				con=new conndb().getcon();
				String sqlstr= "select user_account from yydk_user where user_account='"+un+"'";
				ps=con.prepareStatement(sqlstr);
				rs=ps.executeQuery();
				if(rs.next()){
					strres="已存在此用户名！";
				}
				else
					strres="√";
				return strres;
			}catch(Exception e){
				e.printStackTrace();
			}finally{
				this.close();
			}
		}
		return strres;
	}
	
	public boolean userRegister(String un,String pass){
		if(!un.equals("") && !pass.equals(""))
		{
			try{
				con=new conndb().getcon();
				String sqlstr= "insert into yydk_user (user_account,user_password)values(?,?)";
				ps=con.prepareStatement(sqlstr);
				ps.setString(1, un);
				ps.setString(2, pass);
				int i=ps.executeUpdate();
				if(i>0)
					return true;
			}catch(Exception e){
				e.printStackTrace();
			}finally{
				this.close();
			}
		}
		return false;
	}

}

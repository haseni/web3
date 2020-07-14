package iot.servlet;

import iot.bean.Tuser;
import iot.dao.UserDao;
import iot.utils.CodeExchange;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.swing.JOptionPane;


public class UserServlet extends HttpServlet {

	/**
	 * Constructor of the object.
	 */
	public UserServlet() {
		super();
	}

	/**
	 * Destruction of the servlet. <br>
	 */
	public void destroy() {
		super.destroy(); // Just puts "destroy" string in log
		// Put your code here
	}

	/**
	 * The doGet method of the servlet. <br>
	 *
	 * This method is called when a form has its tag value method equals to get.
	 * 
	 * @param request the request send by the client to the server
	 * @param response the response send by the server to the client
	 * @throws ServletException if an error occurred
	 * @throws IOException if an error occurred
	 */
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		this.doPost(request,response);
	}

	/**
	 * The doPost method of the servlet. <br>
	 *
	 * This method is called when a form has its tag value method equals to post.
	 * 
	 * @param request the request send by the client to the server
	 * @param response the response send by the server to the client
	 * @throws ServletException if an error occurred
	 * @throws IOException if an error occurred
	 */
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		//有删除、添加和修改传递action参数
				String action=request.getParameter("action");
				
				if(action!=null){
					if(action.equals("delete")){
						String id=request.getParameter("id");
						//改4：
						HttpSession session = request.getSession();
						String usertype01=CodeExchange.chinese((String)session.getAttribute("usertype01"));
						/*PrintWriter out = response.getWriter();
						out.print(usertype01);*/
						
						/*
						Tuser user=new Tuser();
					
					
						user.setUsertype(CodeExchange.chinese(request.getParameter("usertype")));
						*/
						
						if(id!=null&&id.length()>0){
							UserDao userDao=new UserDao();
							//1改：普通用户无权限删除
							
								if(usertype01.length()==3){
							if(userDao.delete(id)){
								request.setAttribute("msg", "删除成功！");
							}else{
								request.setAttribute("msg", "删除失败！");
							}	
								}
							
						}else{
							response.sendRedirect("error.jsp");//设计一个错误页面来显示
							return;
						}
						
					}else if(action.equals("add")){
						Tuser user=new Tuser();
						user.setUsername(CodeExchange.chinese(request.getParameter("username")));
						user.setPassword(CodeExchange.chinese(request.getParameter("password")));
						user.setUsertype(CodeExchange.chinese(request.getParameter("usertype")));
						UserDao userDao=new UserDao();
						//2改：普通用户无添加权限
						//改4：
						HttpSession session = request.getSession();
						String usertype01=CodeExchange.chinese((String)session.getAttribute("usertype01"));
						
							
							if(usertype01.length()==3){
						//这里还可以进一步查询用户名是否存在，避免用户名重复
						if(userDao.add(user)){
							request.setAttribute("msg", "添加成功！");
						}else{
							request.setAttribute("msg", "添加失败！");
						}
						
							}else{
								JOptionPane.showMessageDialog(null, "对不起，你还不是管理员，请前往第八组找组长进行权限更改");
								
							}
						
						
					}else if(action.equals("update")){
						
						String id=request.getParameter("id");
						if(id!=null&&id.length()>0){
							UserDao userDao=new UserDao();
							
							HttpSession session = request.getSession();
							String usertype01=CodeExchange.chinese((String)session.getAttribute("usertype01"));
							
							if(usertype01.length()==3){
							ArrayList<Tuser> users=	userDao.query(" id=" + id);
							
							if(users!=null && users.size()>0){
								Tuser user=users.get(0);//获取用户信息
								request.setAttribute("user", user);
								//转向修改页面编辑信息
								request.getRequestDispatcher("useredit.jsp").forward(request, response);
								return;
							}else{
								response.sendRedirect("error.jsp");//设计一个错误页面来显示
								return;
							}
							}else{
								JOptionPane.showMessageDialog(null, "对不起，你还不是管理员，请前往第八组找组长进行权限更改");
								
							}
							
						}else{
							response.sendRedirect("error.jsp");//设计一个错误页面来显示
							return;
						}
						
					}else if(action.equals("updateSave")){
						
						Tuser user=new Tuser();
						user.setUsername(CodeExchange.chinese(request.getParameter("username")));
						user.setPassword(CodeExchange.chinese(request.getParameter("password")));
						user.setUsertype(CodeExchange.chinese(request.getParameter("usertype")));
						//这里还可以进一步校验id的合法性
						user.setId(Long.parseLong(request.getParameter("id")));
						
						UserDao userDao=new UserDao();
						
						//这里还可以进一步查询用户名是否存在，避免用户名重复
						if(userDao.update(user)){
							request.setAttribute("msg", "修改成功！");
						}else{
							request.setAttribute("msg", "修改失败！");
						}
						
					}else if(action.equals("login")){
						
						Tuser user=new Tuser();
						user.setUsername(CodeExchange.chinese(request.getParameter("username")));
						user.setPassword(CodeExchange.chinese(request.getParameter("password")));
						
						UserDao userDao=new UserDao();
						ArrayList<Tuser> users=	userDao.query(" username='" + user.getUsername() +"' and password='"+user.getPassword()+"'");
						if(users!=null && users.size()>0){
							user=users.get(0);//获取用户信息
							HttpSession session = request.getSession();
							//用户登录信息存到session
							session.setAttribute("loginusername", user.getUsername());
							session.setAttribute("loginusertype", user.getUsertype());
							//转向修改页面编辑信息
							request.getRequestDispatcher("login.jsp").forward(request, response);
							return;
						}else{
							request.setAttribute("msg", "登录失败！");
							request.getRequestDispatcher("index.jsp").forward(request, response);
							return;
						}
						
					}		
					else{
						//不能识别动作
						response.sendRedirect("error.jsp");//设计一个错误页面来显示
						return;
					}
				}	
				
				//查询条件
				String whereSQL="";
				String keyword=CodeExchange.chinese(request.getParameter("keyword"));
				String fieldname=request.getParameter("fieldname");
				
				
				Tuser user=new Tuser();
				user.setUsertype(CodeExchange.chinese(request.getParameter("usertype")));
				
				HttpSession session = request.getSession();
				String usertype01=CodeExchange.chinese((String)session.getAttribute("usertype01"));
				
				if(usertype01.length()==3){
				if(keyword!=null&&fieldname!=null&&fieldname.length()>0&&keyword.length()>0){
					//id为整型
					if(fieldname.equals("id")){
						whereSQL=fieldname+"="+keyword;
					}
					//其他为字符串型，要加入单引号
					else
					{
						whereSQL=fieldname+" like '%"+keyword+"%' ";
					}
					//回传给页面显示查询条件，否则会清空
					request.setAttribute("fieldname", fieldname);
					request.setAttribute("keyword", keyword);
					
				}
				//查询页码
				String page=request.getParameter("page");
				if(page==null){
					page="1";
				}
				UserDao userDao=new UserDao();
				ArrayList<Tuser> users =new ArrayList<Tuser>();		
				users = userDao.queryPage(whereSQL,Integer.parseInt(page));
				request.setAttribute("users", users);
				
				int total=userDao.count(whereSQL);
			
				request.setAttribute("total", total/userDao.PAGE_LENGTH + 1);//计算总页数
				request.setAttribute("currentPage", Integer.parseInt(page));
				request.getRequestDispatcher("userlist.jsp").forward(request, response);

				
				
				
				}
				
				//普通用户不能看管理员的
				
				if(usertype01.length()==4){
					if(keyword!=null&&fieldname!=null&&fieldname.length()>0&&keyword.length()>0){
						//id为整型
						if(fieldname.equals("id")){
							whereSQL=fieldname+"="+keyword;
							
						}
						//其他为字符串型，要加入单引号
						else 
						{
							whereSQL=fieldname+" like '%"+keyword+"%' " ;
						}
						//回传给页面显示查询条件，否则会清空
						request.setAttribute("fieldname", fieldname);
						request.setAttribute("keyword", keyword);
						
					}
					
					
					
					//查询页码
					String page=request.getParameter("page");
					if(page==null){
						page="1";
					}
					UserDao userDao=new UserDao();
					ArrayList<Tuser> users =new ArrayList<Tuser>();		
					users = userDao.queryPage01(whereSQL,Integer.parseInt(page));
					request.setAttribute("users", users);
					
					int total=userDao.count(whereSQL);
				
					request.setAttribute("total", total/userDao.PAGE_LENGTH + 1);//计算总页数
					request.setAttribute("currentPage", Integer.parseInt(page));
					request.getRequestDispatcher("userlist.jsp").forward(request, response);

					}
				
				//游客
				if(usertype01.length()==2){
					if(keyword!=null&&fieldname!=null&&fieldname.length()>0&&keyword.length()>0){
						//id为整型
						if(fieldname.equals("id")){
							whereSQL=fieldname+"="+keyword;
							
						}
						//其他为字符串型，要加入单引号
						else 
						{
							whereSQL=fieldname+" like '%"+keyword+"%' " ;
						}
						//回传给页面显示查询条件，否则会清空
						request.setAttribute("fieldname", fieldname);
						request.setAttribute("keyword", keyword);
						
					}
					
					
					
					//查询页码
					String page=request.getParameter("page");
					if(page==null){
						page="1";
					}
					UserDao userDao=new UserDao();
					ArrayList<Tuser> users =new ArrayList<Tuser>();		
					users = userDao.queryPage02(whereSQL,Integer.parseInt(page));
					request.setAttribute("users", users);
					
					int total=userDao.count(whereSQL);
				
					request.setAttribute("total", total/userDao.PAGE_LENGTH + 1);//计算总页数
					request.setAttribute("currentPage", Integer.parseInt(page));
					request.getRequestDispatcher("userlist.jsp").forward(request, response);

					}
				

			}

			/**
			 * Initialization of the servlet. <br>
			 *
			 * @throws ServletException if an error occurs
			 */
			public void init() throws ServletException {
				// Put your code here
			}

		}

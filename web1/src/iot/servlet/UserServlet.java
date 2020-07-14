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

		//��ɾ������Ӻ��޸Ĵ���action����
				String action=request.getParameter("action");
				
				if(action!=null){
					if(action.equals("delete")){
						String id=request.getParameter("id");
						//��4��
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
							//1�ģ���ͨ�û���Ȩ��ɾ��
							
								if(usertype01.length()==3){
							if(userDao.delete(id)){
								request.setAttribute("msg", "ɾ���ɹ���");
							}else{
								request.setAttribute("msg", "ɾ��ʧ�ܣ�");
							}	
								}
							
						}else{
							response.sendRedirect("error.jsp");//���һ������ҳ������ʾ
							return;
						}
						
					}else if(action.equals("add")){
						Tuser user=new Tuser();
						user.setUsername(CodeExchange.chinese(request.getParameter("username")));
						user.setPassword(CodeExchange.chinese(request.getParameter("password")));
						user.setUsertype(CodeExchange.chinese(request.getParameter("usertype")));
						UserDao userDao=new UserDao();
						//2�ģ���ͨ�û������Ȩ��
						//��4��
						HttpSession session = request.getSession();
						String usertype01=CodeExchange.chinese((String)session.getAttribute("usertype01"));
						
							
							if(usertype01.length()==3){
						//���ﻹ���Խ�һ����ѯ�û����Ƿ���ڣ������û����ظ�
						if(userDao.add(user)){
							request.setAttribute("msg", "��ӳɹ���");
						}else{
							request.setAttribute("msg", "���ʧ�ܣ�");
						}
						
							}else{
								JOptionPane.showMessageDialog(null, "�Բ����㻹���ǹ���Ա����ǰ���ڰ������鳤����Ȩ�޸���");
								
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
								Tuser user=users.get(0);//��ȡ�û���Ϣ
								request.setAttribute("user", user);
								//ת���޸�ҳ��༭��Ϣ
								request.getRequestDispatcher("useredit.jsp").forward(request, response);
								return;
							}else{
								response.sendRedirect("error.jsp");//���һ������ҳ������ʾ
								return;
							}
							}else{
								JOptionPane.showMessageDialog(null, "�Բ����㻹���ǹ���Ա����ǰ���ڰ������鳤����Ȩ�޸���");
								
							}
							
						}else{
							response.sendRedirect("error.jsp");//���һ������ҳ������ʾ
							return;
						}
						
					}else if(action.equals("updateSave")){
						
						Tuser user=new Tuser();
						user.setUsername(CodeExchange.chinese(request.getParameter("username")));
						user.setPassword(CodeExchange.chinese(request.getParameter("password")));
						user.setUsertype(CodeExchange.chinese(request.getParameter("usertype")));
						//���ﻹ���Խ�һ��У��id�ĺϷ���
						user.setId(Long.parseLong(request.getParameter("id")));
						
						UserDao userDao=new UserDao();
						
						//���ﻹ���Խ�һ����ѯ�û����Ƿ���ڣ������û����ظ�
						if(userDao.update(user)){
							request.setAttribute("msg", "�޸ĳɹ���");
						}else{
							request.setAttribute("msg", "�޸�ʧ�ܣ�");
						}
						
					}else if(action.equals("login")){
						
						Tuser user=new Tuser();
						user.setUsername(CodeExchange.chinese(request.getParameter("username")));
						user.setPassword(CodeExchange.chinese(request.getParameter("password")));
						
						UserDao userDao=new UserDao();
						ArrayList<Tuser> users=	userDao.query(" username='" + user.getUsername() +"' and password='"+user.getPassword()+"'");
						if(users!=null && users.size()>0){
							user=users.get(0);//��ȡ�û���Ϣ
							HttpSession session = request.getSession();
							//�û���¼��Ϣ�浽session
							session.setAttribute("loginusername", user.getUsername());
							session.setAttribute("loginusertype", user.getUsertype());
							//ת���޸�ҳ��༭��Ϣ
							request.getRequestDispatcher("login.jsp").forward(request, response);
							return;
						}else{
							request.setAttribute("msg", "��¼ʧ�ܣ�");
							request.getRequestDispatcher("index.jsp").forward(request, response);
							return;
						}
						
					}		
					else{
						//����ʶ����
						response.sendRedirect("error.jsp");//���һ������ҳ������ʾ
						return;
					}
				}	
				
				//��ѯ����
				String whereSQL="";
				String keyword=CodeExchange.chinese(request.getParameter("keyword"));
				String fieldname=request.getParameter("fieldname");
				
				
				Tuser user=new Tuser();
				user.setUsertype(CodeExchange.chinese(request.getParameter("usertype")));
				
				HttpSession session = request.getSession();
				String usertype01=CodeExchange.chinese((String)session.getAttribute("usertype01"));
				
				if(usertype01.length()==3){
				if(keyword!=null&&fieldname!=null&&fieldname.length()>0&&keyword.length()>0){
					//idΪ����
					if(fieldname.equals("id")){
						whereSQL=fieldname+"="+keyword;
					}
					//����Ϊ�ַ����ͣ�Ҫ���뵥����
					else
					{
						whereSQL=fieldname+" like '%"+keyword+"%' ";
					}
					//�ش���ҳ����ʾ��ѯ��������������
					request.setAttribute("fieldname", fieldname);
					request.setAttribute("keyword", keyword);
					
				}
				//��ѯҳ��
				String page=request.getParameter("page");
				if(page==null){
					page="1";
				}
				UserDao userDao=new UserDao();
				ArrayList<Tuser> users =new ArrayList<Tuser>();		
				users = userDao.queryPage(whereSQL,Integer.parseInt(page));
				request.setAttribute("users", users);
				
				int total=userDao.count(whereSQL);
			
				request.setAttribute("total", total/userDao.PAGE_LENGTH + 1);//������ҳ��
				request.setAttribute("currentPage", Integer.parseInt(page));
				request.getRequestDispatcher("userlist.jsp").forward(request, response);

				
				
				
				}
				
				//��ͨ�û����ܿ�����Ա��
				
				if(usertype01.length()==4){
					if(keyword!=null&&fieldname!=null&&fieldname.length()>0&&keyword.length()>0){
						//idΪ����
						if(fieldname.equals("id")){
							whereSQL=fieldname+"="+keyword;
							
						}
						//����Ϊ�ַ����ͣ�Ҫ���뵥����
						else 
						{
							whereSQL=fieldname+" like '%"+keyword+"%' " ;
						}
						//�ش���ҳ����ʾ��ѯ��������������
						request.setAttribute("fieldname", fieldname);
						request.setAttribute("keyword", keyword);
						
					}
					
					
					
					//��ѯҳ��
					String page=request.getParameter("page");
					if(page==null){
						page="1";
					}
					UserDao userDao=new UserDao();
					ArrayList<Tuser> users =new ArrayList<Tuser>();		
					users = userDao.queryPage01(whereSQL,Integer.parseInt(page));
					request.setAttribute("users", users);
					
					int total=userDao.count(whereSQL);
				
					request.setAttribute("total", total/userDao.PAGE_LENGTH + 1);//������ҳ��
					request.setAttribute("currentPage", Integer.parseInt(page));
					request.getRequestDispatcher("userlist.jsp").forward(request, response);

					}
				
				//�ο�
				if(usertype01.length()==2){
					if(keyword!=null&&fieldname!=null&&fieldname.length()>0&&keyword.length()>0){
						//idΪ����
						if(fieldname.equals("id")){
							whereSQL=fieldname+"="+keyword;
							
						}
						//����Ϊ�ַ����ͣ�Ҫ���뵥����
						else 
						{
							whereSQL=fieldname+" like '%"+keyword+"%' " ;
						}
						//�ش���ҳ����ʾ��ѯ��������������
						request.setAttribute("fieldname", fieldname);
						request.setAttribute("keyword", keyword);
						
					}
					
					
					
					//��ѯҳ��
					String page=request.getParameter("page");
					if(page==null){
						page="1";
					}
					UserDao userDao=new UserDao();
					ArrayList<Tuser> users =new ArrayList<Tuser>();		
					users = userDao.queryPage02(whereSQL,Integer.parseInt(page));
					request.setAttribute("users", users);
					
					int total=userDao.count(whereSQL);
				
					request.setAttribute("total", total/userDao.PAGE_LENGTH + 1);//������ҳ��
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

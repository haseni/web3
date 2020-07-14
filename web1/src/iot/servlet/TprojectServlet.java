package iot.servlet;

import iot.bean.Tgate;
import iot.bean.Tproject;
import iot.dao.TgateDao;
import iot.dao.TprojectDao;
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

import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

public class TprojectServlet extends HttpServlet {

	/**
	 * Constructor of the object.
	 */
	public TprojectServlet() {
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
				HttpSession session = request.getSession();
				String usertype01=CodeExchange.chinese((String)session.getAttribute("usertype01"));
				if(id!=null&&id.length()>0){
					TprojectDao TprojectDao=new TprojectDao();
					if(usertype01.length()==3){
					if(TprojectDao.delete(id)){
						request.setAttribute("msg", "ɾ���ɹ���");
					}else{
						request.setAttribute("msg", "ɾ��ʧ�ܣ�");
					}
					}else{
						JOptionPane.showMessageDialog(null, "�Բ����㻹���ǹ���Ա����ǰ���ڰ������鳤����Ȩ�޸���");
					}
					
				}else{
					response.sendRedirect("error.jsp");//���һ������ҳ������ʾ
					return;
				}
			}else if(action.equals("add")){
				Tproject user=new Tproject();
				user.setUid(Long.parseLong(CodeExchange.chinese(request.getParameter("uid"))));
				user.setProjectname(CodeExchange.chinese(request.getParameter("projectname")));
				
				user.setRemark(CodeExchange.chinese(request.getParameter("remark")));
				
			
				Timestamp d=new  Timestamp(System.currentTimeMillis());
			    user.setAddtime(d);
						//ϵͳʱ��
				TprojectDao TprojectDao=new TprojectDao();
				//���ﻹ���Խ�һ����ѯ�û����Ƿ���ڣ������û����ظ�
				HttpSession session = request.getSession();
				String usertype01=CodeExchange.chinese((String)session.getAttribute("usertype01"));
				
				if(usertype01.length()==3||usertype01.length()==4){
				if(TprojectDao.add(user)){
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
					TprojectDao TprojectDao=new TprojectDao();
					
					HttpSession session = request.getSession();
					String usertype01=CodeExchange.chinese((String)session.getAttribute("usertype01"));
					
					if(usertype01.length()==3||usertype01.length()==4){
					ArrayList<Tproject> users=	TprojectDao.query(" id=" + id);
					if(users!=null && users.size()>0){
						Tproject user=users.get(0);//��ȡ�û���Ϣ
						request.setAttribute("tproject", user);
						//ת���޸�ҳ��༭��Ϣ
						request.getRequestDispatcher("tprojectredit.jsp").forward(request, response);
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
				
				Tproject user=new Tproject();
				user.setProjectname(CodeExchange.chinese(request.getParameter("projectname")));
				user.setRemark(CodeExchange.chinese(request.getParameter("remark")));
				user.setUid(Long.parseLong(CodeExchange.chinese(request.getParameter("uid"))));
				
				//���ﻹ���Խ�һ��У��id�ĺϷ���
				user.setId(Long.parseLong(request.getParameter("id")));
				
				TprojectDao TprojectDao=new TprojectDao();
				//���ﻹ���Խ�һ����ѯ�û����Ƿ���ڣ������û����ظ�
				
			
				if(TprojectDao.update(user)){
					request.setAttribute("msg", "�޸ĳɹ���");
				}else{
					request.setAttribute("msg", "�޸�ʧ�ܣ�");
				}
				
			
			}
			else if("search".equals(action)){}
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
		 
		TprojectDao gateDao=new TprojectDao();
		ArrayList<Tproject> gates =new ArrayList<Tproject>();	
		int total=1;
		if("search".equals(action)){
			String projectid=request.getParameter("pid");
			gates = gateDao.queryPage("id="+projectid,Integer.parseInt(page));
			request.setAttribute("fieldname", "pid");
			request.setAttribute("keyword", projectid);
			total=gateDao.count("id like '%"+projectid+"%' ");
		}else{
			gates = gateDao.queryPage(whereSQL,Integer.parseInt(page));
			total=gateDao.count(whereSQL);
		}
		request.setAttribute("tproject", gates);
		request.setAttribute("total", total/gateDao.PAGE_LENGTH + 1);//������ҳ��
		request.setAttribute("currentPage", Integer.parseInt(page));
		request.getRequestDispatcher("tproject_manage.jsp").forward(request, response);				
		
		
	
	
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

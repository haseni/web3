package iot.servlet;

import iot.bean.Tgate;
import iot.dao.TgateDao;
import iot.utils.CodeExchange;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.*;

import javax.*;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.swing.JOptionPane;

import java.sql.Timestamp;


public class TgateServlet extends HttpServlet {

	/**
	 * Constructor of the object.
	 */
	public TgateServlet() {
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

		this.doPost(request, response);
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
						
						if(id!=null&&id.length()>0){
							TgateDao tgateDao=new TgateDao();
							//1�ģ���ͨ�û���Ȩ��ɾ��
							
							if(usertype01.length()==3){
							if(tgateDao.delete(id)){
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
						Tgate gate=new Tgate();
						gate.setPid(Integer.parseInt(CodeExchange.chinese(request.getParameter("pid"))));
						gate.setGatename(CodeExchange.chinese(request.getParameter("gatename")));
						gate.setGateid(CodeExchange.chinese(request.getParameter("gateid")));
						
						gate.setGateenabled(Integer.parseInt(request.getParameter("gateenabled").toString()));
						gate.setRemark(CodeExchange.chinese(request.getParameter("remark")));
						Timestamp d=new  Timestamp(System.currentTimeMillis());
					    gate.setAddtime(d);
					
						
						
						
						
						
						TgateDao tgateDao=new TgateDao();
						//2�ģ���ͨ�û������Ȩ��
						//��4��
						HttpSession session = request.getSession();
						String usertype01=CodeExchange.chinese((String)session.getAttribute("usertype01"));
						
							
						
						//���ﻹ���Խ�һ����ѯ�û����Ƿ���ڣ������û����ظ�
						if(usertype01.length()==3||usertype01.length()==4){
						if(tgateDao.add(gate)){
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
							TgateDao tgateDao=new TgateDao();
							
							HttpSession session = request.getSession();
							String usertype01=CodeExchange.chinese((String)session.getAttribute("usertype01"));
							if(usertype01.length()==3||usertype01.length()==4){
						
							ArrayList<Tgate> gates=	tgateDao.query(" id=" + id);
							
							if(gates!=null && gates.size()>0){
								Tgate tgate=gates.get(0);//��ȡ�û���Ϣ
								request.setAttribute("gates", tgate);
								//ת���޸�ҳ��༭��Ϣ
								request.getRequestDispatcher("tgateredit.jsp").forward(request, response);
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
						
						Tgate gate=new Tgate();
						gate.setPid(Integer.parseInt(CodeExchange.chinese(request.getParameter("pid"))));
						gate.setGatename(CodeExchange.chinese(request.getParameter("gatename")));
						gate.setGateid(CodeExchange.chinese(request.getParameter("gateid")));				
						gate.setGateenabled(Integer.parseInt(request.getParameter("gateenabled").toString()));					
						gate.setRemark(request.getParameter("remark"));
						gate.setId(Integer.parseInt(CodeExchange.chinese(request.getParameter("id").toString())));
						
						TgateDao tgateDao=new TgateDao();
						
						//���ﻹ���Խ�һ����ѯ�û����Ƿ���ڣ������û����ظ�
						if(tgateDao.update(gate)){
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
				
				 
				TgateDao gateDao=new TgateDao();
				ArrayList<Tgate> gates =new ArrayList<Tgate>();	
				int total=1;
				if("search".equals(action)){
					String projectid=request.getParameter("projectid");
					gates = gateDao.queryPage("pid="+projectid,Integer.parseInt(page));
					request.setAttribute("fieldname", "pid");
					request.setAttribute("keyword", projectid);
					total=gateDao.count("pid like '%"+projectid+"%' ");
				}else{
					gates = gateDao.queryPage(whereSQL,Integer.parseInt(page));
					total=gateDao.count(whereSQL);
				}
				request.setAttribute("gates", gates);
				request.setAttribute("total", total/gateDao.PAGE_LENGTH + 1);//������ҳ��
				request.setAttribute("currentPage", Integer.parseInt(page));
				request.getRequestDispatcher("tgate_manage.jsp").forward(request, response);				
				
				
			
			
				

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

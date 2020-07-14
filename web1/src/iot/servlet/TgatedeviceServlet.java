package iot.servlet;

import iot.bean.*;
import iot.dao.TgatedeviceOp;
import iot.dao.TgatedeviceOp;
import iot.utils.CodeExchange;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.swing.JOptionPane;


public class TgatedeviceServlet extends HttpServlet {

	/**
	 * Constructor of the object.
	 */
	public TgatedeviceServlet() {
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
							TgatedeviceOp TgatedeviceOp=new TgatedeviceOp();
							if(usertype01.length()==3){
							if(TgatedeviceOp.delete(id)){
								request.setAttribute("msg", "ɾ���ɹ���");
							}else{
								request.setAttribute("msg", "ɾ��ʧ�ܣ�");
							}
							}else{
								response.sendRedirect("error.jsp");//���һ������ҳ������ʾ
								return;
							}				
							
						}else{
							response.sendRedirect("error.jsp");//���һ������ҳ������ʾ
							return;
						}
					}else if(action.equals("add")){
						tgatedevice tgate=new tgatedevice();
						tgate.setClientdevicename(CodeExchange.chinese(request.getParameter("clientdevicename")));
						tgate.setClientdeviceenabled( Integer.parseInt(request.getParameter("clientdeviceenabled").toString()));
						 
						tgate.setClientdeviceid(CodeExchange.chinese(request.getParameter("clientdeviceid")));
						TgatedeviceOp TgatedeviceOp=new TgatedeviceOp();
						//���ﻹ���Խ�һ����ѯ�û����Ƿ���ڣ������û����ظ�
						HttpSession session = request.getSession();
						String usertype01=CodeExchange.chinese((String)session.getAttribute("usertype01"));
						
						if(usertype01.length()==3||usertype01.length()==4){
							
						
						if(TgatedeviceOp.add(tgate)){
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
							TgatedeviceOp TgatedeviceOp=new TgatedeviceOp();
							HttpSession session = request.getSession();
							String usertype01=CodeExchange.chinese((String)session.getAttribute("usertype01"));
							
							if(usertype01.length()==3||usertype01.length()==4){
							ArrayList<tgatedevice> tgate=	TgatedeviceOp.query(" id=" + id);
							if(tgate!=null && tgate.size()>0){
								tgatedevice tgate1=tgate.get(0);//��ȡ�û���Ϣ
								request.setAttribute("tgate1", tgate1);
								//ת���޸�ҳ��༭��Ϣ
								request.getRequestDispatcher("tgatedevicedit.jsp").forward(request, response);
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
						
						tgatedevice tgate=new tgatedevice();
						tgate.setGid(Long.parseLong(CodeExchange.chinese(request.getParameter("gid") )));
						tgate.setClientdevicename(CodeExchange.chinese(request.getParameter("clientdevicename")));
						tgate.setClientdeviceenabled( Integer.parseInt(request.getParameter("clientdeviceenabled").toString()));
						 
						tgate.setClientdeviceid(CodeExchange.chinese(request.getParameter("clientdeviceid")));
						//���ﻹ���Խ�һ��У��id�ĺϷ���
						tgate.setId(Long.parseLong(request.getParameter("id")));
						System.out.println(tgate.getClientdevicename());
						TgatedeviceOp TgatedeviceOp=new TgatedeviceOp();
						//���ﻹ���Խ�һ����ѯ�û����Ƿ���ڣ������û����ظ�
						if(TgatedeviceOp.update(tgate)){
							request.setAttribute("msg", "�޸ĳɹ���");
						}else{
							request.setAttribute("msg", "�޸�ʧ�ܣ�");
						}
						
						
					} 
					else if("search".equals(action)){}
					else if("search1".equals(action)){}
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
				/*TgatedeviceOp TgatedeviceOp=new TgatedeviceOp();
				ArrayList<tgatedevice> tgate =new ArrayList<tgatedevice>();	
				System.out.print(tgate);
				tgate = TgatedeviceOp.queryPage(whereSQL,Integer.parseInt(page));
				request.setAttribute("tgate", tgate);
				
				int total=TgatedeviceOp.count(whereSQL);
				request.setAttribute("total", total/TgatedeviceOp.PAGE_LENGTH + 1);//������ҳ��
				
				request.setAttribute("currentPage", Integer.parseInt(page));
				request.getRequestDispatcher("tgatedevicelist.jsp").forward(request, response);*/
				int total=1;
				TgatedeviceOp gatedeviceDao=new TgatedeviceOp();
				ArrayList<tgatedevice> gatedevices =new ArrayList<tgatedevice>();
		/*		if("search".equals(action)){
					String gateid=request.getParameter("pid");
					gatedevices = gatedeviceDao.queryPage("gid="+gateid,Integer.parseInt(page));
					request.setAttribute("fieldname", "gid");
					request.setAttribute("keyword", gateid);
					total=gatedeviceDao.count("gid like '%"+gateid+"%' ");
				}else */if("search1".equals(action)){
					String deviceid=request.getParameter("did");
					gatedevices = gatedeviceDao.queryPage("did="+deviceid,Integer.parseInt(page));
					request.setAttribute("fieldname", "did");
					request.setAttribute("keyword", deviceid);
					total=gatedeviceDao.count("did like '%"+deviceid+"%' ");
				}else{
					gatedevices = gatedeviceDao.queryPage(whereSQL,Integer.parseInt(page));
					total=gatedeviceDao.count(whereSQL);
				}request.setAttribute("gatedevices", gatedevices);
				request.setAttribute("total", total/gatedeviceDao.PAGE_LENGTH + 1);//������ҳ��
				request.setAttribute("currentPage", Integer.parseInt(page));
				request.getRequestDispatcher("tgatedevicelist.jsp").forward(request, response);

				
				
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

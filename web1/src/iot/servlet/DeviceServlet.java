package iot.servlet;

import iot.bean.*;
import iot.dao.*;
import iot.utils.CodeExchange;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Timestamp;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.swing.JOptionPane;

public class DeviceServlet extends HttpServlet {

	/**
	 * Constructor of the object.
	 */
	public DeviceServlet() {
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
		doPost(request,response);
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

		response.setContentType("text/html");
		response.setCharacterEncoding("utf-8");
		request.setCharacterEncoding("utf-8");
		PrintWriter out = response.getWriter();
		//out.print("aaa");
		
		
		
	//��ɾ������Ӻ��޸Ĵ���action����
		String action=request.getParameter("action");
		if(action!=null){
			if(action.equals("delete")){
				String id=request.getParameter("id");
				
				HttpSession session = request.getSession();
				String usertype01=CodeExchange.chinese((String)session.getAttribute("usertype01"));
				if(id!=null&&id.length()>0)
				{
					DeviceOp deop=new DeviceOp();
					if(usertype01.length()==3){
					if(deop.delete(id))
					{
						 
 					request.setAttribute("msg", "ɾ���ɹ���");
					}
					else
					{
						 
						 request.setAttribute("msg", "ɾ��ʧ�ܣ�");
					}					
					}else{
						JOptionPane.showMessageDialog(null, "�Բ����㻹���ǹ���Ա����ǰ���ڰ������鳤����Ȩ�޸���");
						
					}
						
				}
				else
				{
					response.sendRedirect("error.jsp");//���һ������ҳ������ʾ
					return;
				}
			}	else if(action.equals("add")){
				Device device=new Device();
				device.setDevicetypename ((request.getParameter("devicetypename")));
				device.setDevicetypecode (CodeExchange.chinese(request.getParameter("devicetypecode")));
				device.setDevicetypeconfig (CodeExchange.chinese(request.getParameter("devicetypeconfig")));
				device.setDevicetypeconfig (CodeExchange.chinese(request.getParameter("remark")));
				Timestamp d=new  Timestamp(System.currentTimeMillis());
				device.setAddtime(d);
				DeviceOp deop=new DeviceOp();
				
				HttpSession session = request.getSession();
				String usertype01=CodeExchange.chinese((String)session.getAttribute("usertype01"));
				//���ﻹ���Խ�һ����ѯ�û����Ƿ���ڣ������û����ظ�
				
				if(usertype01.length()==3||usertype01.length()==4){
				if(deop.add(device)){
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
					DeviceOp DeviceOp=new DeviceOp();
					
					HttpSession session = request.getSession();
					String usertype01=CodeExchange.chinese((String)session.getAttribute("usertype01"));
					
					if(usertype01.length()==3||usertype01.length()==4){
					ArrayList<Device> device=	DeviceOp.query(" id=" + id);
					if(device!=null && device.size()>0){
						Device devices=device.get(0);//��ȡ�û���Ϣ
						request.setAttribute("device", devices);
						//ת���޸�ҳ��༭��Ϣ
						request.getRequestDispatcher("deviceredit.jsp").forward(request, response);
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
				
				Device device=new Device();
				device.setDevicetypename ((request.getParameter("devicetypename")));
				device.setDevicetypecode (CodeExchange.chinese(request.getParameter("devicetypecode")));
				device.setDevicetypeconfig (CodeExchange.chinese(request.getParameter("devicetypeconfig")));
				//���ﻹ���Խ�һ��У��id�ĺϷ���
				device.setId(Long.parseLong(request.getParameter("id")));
				
				DeviceOp DeviceOp=new DeviceOp();
				//���ﻹ���Խ�һ����ѯ�û����Ƿ���ڣ������û����ظ�
				if(DeviceOp.update(device)){
					request.setAttribute("msg", "�޸ĳɹ���");
				}else{
					request.setAttribute("msg", "�޸�ʧ�ܣ�");
				}
				
			}
		}	
		
		
		
		
		
		
		
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
		DeviceOp DeviceOp=new DeviceOp();
		ArrayList<Device> device =new ArrayList<Device>();		
		device = DeviceOp.queryPage(whereSQL,Integer.parseInt(page));
		request.setAttribute("device", device);
		
		int total=DeviceOp.count(whereSQL);
		request.setAttribute("total", total/DeviceOp.PAGE_LENGTH + 1);//������ҳ��
		
		request.setAttribute("currentPage", Integer.parseInt(page));
		request.getRequestDispatcher("devicelist.jsp").forward(request, response);
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

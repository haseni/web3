package iot.servlet;

import iot.bean.*;
import iot.dao.*;
import iot.utils.CodeExchange;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Timestamp;
import java.util.ArrayList;

 

import java.util.Iterator;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.swing.JOptionPane;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

public class DeviceTypeServlet extends HttpServlet {

	/**
	 * Constructor of the object.
	 */
	public DeviceTypeServlet() {
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
						
						HttpSession session = request.getSession();
						String usertype01=CodeExchange.chinese((String)session.getAttribute("usertype01"));
						
						if(id!=null&&id.length()>0){
							DeviceTypeOp typeop=new DeviceTypeOp();
							if(usertype01.length()==3){
							if(typeop.delete(id)){
								request.setAttribute("msg", "删除成功！");
							}else{
								request.setAttribute("msg", "删除失败！");
							}	
							}else{
								JOptionPane.showMessageDialog(null, "对不起，你还不是管理员，请前往第八组找组长进行权限更改");
							}
							
						}else{
							response.sendRedirect("error.jsp");//设计一个错误页面来显示
							return;
						}
					}
					else if(action.equals("add"))
					{
						DeviceTp devicetp=new DeviceTp();
						  DiskFileItemFactory factory = new DiskFileItemFactory();
							ServletFileUpload upload = new ServletFileUpload(factory);
							upload.setHeaderEncoding("ISO-8859-1");
							ArrayList<FileItem> items = null;
							try 
							{
								items = (ArrayList<FileItem>) upload.parseRequest(request);
							} 
							catch (FileUploadException e1) {
								// TODO Auto-generated catch block
								e1.printStackTrace();
							}
							Iterator<FileItem> it = items.iterator();
							while (it.hasNext()) 
							{
							    FileItem tempitem = it.next();//取得表单中的一个元素
							    String itemName = tempitem.getFieldName();//取得input标签的name属性值
							    if (tempitem.isFormField()) 
							    {
							    	//判断这个元素type是否为text，FCKediter也返回true
							    	String content = CodeExchange.chinese(tempitem.getString());
								    if (itemName.equals("dtid")) 
								    {
								    	devicetp.setDtid(Long.parseLong(content));
								    }
								    if (itemName.equals("devicecode")) 
								    {
								    	devicetp.setDevicecode(content);
								    }	
								    if (itemName.equals("devicename")) 
								    {
								    	devicetp.setDevicename(content);
								    }
								    if (itemName.equals("deviceconfig")) 
								    {
								    	devicetp.setId(Long.parseLong(content));
								    }

								    if (itemName.equals("deviceenabled")) 
								    {
								    	devicetp.setId(Long.parseLong(content));
								    }
								    if (itemName.equals("remark")) 
								    {
								    	devicetp.setId(Long.parseLong(content));
								    }
								    if (itemName.equals("addtime")) 
								    {
								    	Timestamp d=new  Timestamp(System.currentTimeMillis());
								    	devicetp.setAddtime(d);
								    }    	
							    	
							    }
							    else 
							    {
							    	//type是file，上传的文件
							    	File tempfile= new File(request.getSession().getServletContext().getRealPath("/")+"photos\\"+new File(CodeExchange.chinese(tempitem.getName())).getName());
							    	try
							    	{
							    		tempitem.write(tempfile);
							    	} 
							    	catch (Exception e) 
							    	{
							    		// TODO Auto-generated catch block
							    		e.printStackTrace();
							    	}
							    	devicetp.setDevicephoto("photos/"+tempfile.getCanonicalPath().substring(tempfile.getCanonicalPath().lastIndexOf("\\")+1));
							    }
							}
							DeviceTypeOp tpop=new DeviceTypeOp();
							HttpSession session = request.getSession();
							String usertype01=CodeExchange.chinese((String)session.getAttribute("usertype01"));
							
							if(usertype01.length()==3||usertype01.length()==4){
							if(tpop.add(devicetp)){
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
							DeviceTypeOp typeop=new DeviceTypeOp();
							HttpSession session = request.getSession();
							String usertype01=CodeExchange.chinese((String)session.getAttribute("usertype01"));
							
							if(usertype01.length()==3||usertype01.length()==4){
							ArrayList<DeviceTp> devicetp=	typeop.query(" id=" + id);
							if(devicetp!=null && devicetp.size()>0){
								DeviceTp type=devicetp.get(0);//获取用户信息
								request.setAttribute("deviceTp", type);
								//转向修改页面编辑信息
								request.getRequestDispatcher("devicetypedit.jsp").forward(request, response);
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
						DeviceTp devicetp=new DeviceTp();
						  DiskFileItemFactory factory = new DiskFileItemFactory();
							ServletFileUpload upload = new ServletFileUpload(factory);
							upload.setHeaderEncoding("ISO-8859-1");
							ArrayList<FileItem> items = null;
							try 
							{
								items = (ArrayList<FileItem>) upload.parseRequest(request);
							} 
							catch (FileUploadException e1) {
								// TODO Auto-generated catch block
								e1.printStackTrace();
							}
							Iterator<FileItem> it = items.iterator();
							while (it.hasNext()) 
							{
							    FileItem tempitem = it.next();//取得表单中的一个元素
							    String itemName = tempitem.getFieldName();//取得input标签的name属性值
							    if (tempitem.isFormField()) 
							    {
							    	//判断这个元素type是否为text，FCKediter也返回true
							    	String content = CodeExchange.chinese(tempitem.getString());
								    if (itemName.equals("id")) 
								    {
								    	devicetp.setId(Long.parseLong(content));
								    }
								    if (itemName.equals("devicename")) 
								    {
								    	devicetp.setDevicename(content);
								    }
								    if (itemName.equals("devicecode")) 
								    {
								    	devicetp.setDevicecode(content);
								    }				    	
							    	
							    }
							    else 
							    {
							    	//type是file，上传的文件
							    	File tempfile= new File(request.getSession().getServletContext().getRealPath("/")+"photos\\"+new File(CodeExchange.chinese(tempitem.getName())).getName());
							    	try
							    	{
							    		tempitem.write(tempfile);
							    	} 
							    	catch (Exception e) 
							    	{
							    		// TODO Auto-generated catch block
							    		e.printStackTrace();
							    	}
							    	devicetp.setDevicephoto("photos/"+tempfile.getCanonicalPath().substring(tempfile.getCanonicalPath().lastIndexOf("\\")+1));
							    }
							}
							DeviceTypeOp tpop=new DeviceTypeOp();
							HttpSession session = request.getSession();
							String usertype01=CodeExchange.chinese((String)session.getAttribute("usertype01"));
							
							if(usertype01.length()==3){
							if(tpop.update(devicetp)){
								request.setAttribute("msg", "修改成功！");
							}else{
								request.setAttribute("msg", "修改失败！");
							}
							}else{
								JOptionPane.showMessageDialog(null, "对不起，你还不是管理员，请前往第八组找组长进行权限更改");
								
							}
 
					} 
					else if("search".equals(action)){
						
					}
					
				}	
			
				//查询条件
				String whereSQL="";
				String keyword=CodeExchange.chinese(request.getParameter("keyword"));
				String fieldname=request.getParameter("fieldname");
				if(keyword!=null&&fieldname!=null&&fieldname.length()>0&&keyword.length()>0){
					if(fieldname.equals("id")){
						whereSQL=fieldname+"="+keyword;
					}
					else
					{
						whereSQL=fieldname+" like '%"+keyword+"%' ";
					}
					request.setAttribute("fieldname", fieldname);
					request.setAttribute("keyword", keyword);
				}
				String page=request.getParameter("page");
				if(page==null){
					page="1";
				}
				int total=1;
				DeviceTypeOp deviceDao=new DeviceTypeOp();
				ArrayList<DeviceTp> devices =new ArrayList<DeviceTp>();
				if("search".equals(action)){
					String devicetypeid=request.getParameter("devicetypeid");
					
					devices = deviceDao.queryPage("dtid="+devicetypeid,Integer.parseInt(page));
			 
					request.setAttribute("fieldname", "dtid");
					request.setAttribute("keyword", devicetypeid);
					total=deviceDao.count("dtid like '%"+devicetypeid+"%' ");
				}else{
					devices = deviceDao.queryPage(whereSQL,Integer.parseInt(page));
					total=deviceDao.count(whereSQL);
				}
				request.setAttribute("devices", devices);
				request.setAttribute("total", total/deviceDao.PAGE_LENGTH + 1);//计算总页数
				request.setAttribute("currentPage", Integer.parseInt(page));
				request.getRequestDispatcher("devicetype.jsp").forward(request, response);
			
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

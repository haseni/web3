package iot.servlet;

import iot.bean.Json;
import iot.bean.DeviceTp;
import iot.bean.Tuser;
import iot.dao.DeviceTypeOp;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.alibaba.fastjson.JSON;

public class DevicelistServlet extends HttpServlet {

	/**
	 * Constructor of the object.
	 */
	public DevicelistServlet() {
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
		// ����json����
				response.setCharacterEncoding("UTF-8");
				response.setContentType("application/json; charset=utf-8");
				// ����Json��Ϊͨ������࣬����ǰ��AJAX����
				Json j = new Json();
				PrintWriter out = null;
				// JSON.toJSONStringWithDateFormat(object, "yyyy-MM-dd HH:mm:ss");
				try {
					// ͳһ��ʽ��ʱ������
					String did=request.getParameter("did");
					
					//���巵������
					DeviceTypeOp deviceDao=new DeviceTypeOp();
					ArrayList<DeviceTp> devices =new ArrayList<DeviceTp>();
					devices=deviceDao.query("");//�����Լ�����
					
					//���ݴ��
					j.setSuccess(true);
					j.setMsg("��ȡ�ɹ�");
					j.setObj(devices);
					
					out = response.getWriter();
					out.write(JSON.toJSONStringWithDateFormat(j, "yyyy-MM-dd HH:mm:ss"));

				} catch (IOException e) {
					j.setSuccess(false);
					e.printStackTrace();
					out = response.getWriter();
					out.write(JSON.toJSONStringWithDateFormat(j, "yyyy-MM-dd HH:mm:ss"));
				} finally {
					if (out != null) {
						out.close();
					}
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

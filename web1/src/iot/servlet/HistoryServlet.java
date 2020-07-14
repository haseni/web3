package iot.servlet;

import iot.dao.HistoryDao;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class HistoryServlet extends HttpServlet {
	public HistoryServlet() {
		super();
	}
	public void destroy() {
		super.destroy();
	}
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
				this.doPost(request, response);
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HistoryDao historyDao=new HistoryDao();
		
		String starttime=request.getParameter("starttime");
		Long gdid=Long.parseLong(request.getParameter("gdid"));
		
		String endtime=request.getParameter("endtime");
		starttime=starttime.replaceFirst("T"," ");
		endtime=endtime.replaceFirst("T"," ");
		ArrayList<String> historys = historyDao.get(starttime,endtime,gdid);
		PrintWriter out = response.getWriter(); 
        out.println(historys);  
        out.flush();  
        out.close();   
	}

	public void init() throws ServletException {
		
	}

}

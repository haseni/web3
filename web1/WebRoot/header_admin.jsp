<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'userlogin.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
  </head>
  
  <body>
  <table width=100% >
    <tr height="100px"><td width="60%" align="right">
      <a href="index.jsp"><img src="images/logo.png"/></a>
    </td><td><div style="width:240px;margin:60px 0 0 10px;color:gray;border:0 solid gray;">●-＞＞<font face=黑体 size=6 color="gray"> 后台管理 <br></font></div></td></tr>
  </table>
  </body>
</html>

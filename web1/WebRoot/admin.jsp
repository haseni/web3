<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'index.jsp' starting page</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<script src="js/jquery-1.8.2.min.js"></script>
	<script src="js/adminNews.js"></script>
	<link rel="stylesheet" type="text/css" href="css/yydk.css">
    <script type="text/javascript"><!--
    	var rowsel=0;
		
    --></script>
  </head>
  
  <body>
    <div id="mframe">
    	<div id="header" style="border-bottom:1px solid silver;"></div>
    	<div id="content" style="margin:5px 0 5px 0;">
    	  <table width=100%>
	    	  <tr>
		    	  <td width=20% height="30px" valign="top" style="border-right:1px dashed gray;">
			    	  <div id="content_left" style="vertical-align:top;margin:30px 0 0 0;width:100%;height:auto;float:left;">
			    	      <div class="hreftype" id="newsadmin" style="height:30px;line-height:30px;vertical-align:middle;text-align:center;font-family:微软雅黑;;font-size:1em;color:blue;">◆ 新闻发布管理</div>
			    	      <div class="hreftype" id="useradmin" style="height:30px;line-height:30px;vertical-align:middle;text-align:center;font-family:微软雅黑;;font-size:1em;color:blue;">◆ 用户信息管理</div>
			    	  </div>
		    	  </td>
		    	  <td width=80% height="30px">
			    	  <div id="content_right" style="width:100%;border:0px dashed gray;">
			    	    <div id="rtop" style="width:100%;height:auto;border-bottom:0px solid lightgreen;"></div>
			    	    <div id="rbottom" style="width:100%;height:600px;"></div>
			    	  </div>
		    	  </td>
	    	  </tr>
    	  </table>
    	</div>
    	<div id="footer"></div>
    </div>
  </body>
</html>

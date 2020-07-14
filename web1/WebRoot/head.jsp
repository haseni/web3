<%@ page language="java" import="java.util.*,iot.bean.*,iot.utils.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>物联网监控平台</title>
<style type="text/css">

.bkcolor{
 
background:-webkit-linear-gradient(top,#808a87,#dcdcdc);
background:-moz-linear-gradient(top,#808a87,#dcdcdc);
background:-ms-linear-gradient(top,#808a87,#dcdcdc);
background:-linear-gradient(top,#808a87,#dcdcdc);
 
 
}

</style>  
<link href="js/bootstrap/css/bootstrap.min.css" rel="stylesheet">
<script src="js/jquery-1.11.3.min.js"></script>
<script src="js/bootstrap/js/bootstrap.min.js"></script>
<!-- 分页插件 -->
<script type="text/javascript" src="js/bootstrap-paginator.min.js"></script>
<script type="text/javascript">   
</script>  
 
</head>   
<body  >  

<nav class="navbar navbar-default navbar-static-top" role="navigation">
   <div>
 	<video  preload="none" autoplay loop >
    <source src="images/12.mp4" type="video/mp4"   width="100%" height="100%" id="">
	</video>
   </div>
   
  <div class="container">
    <div class="navbar-header">
      <a class="navbar-brand" href="#">物联网监控平台</a>
   </div>
   <div>
      <ul class="nav navbar-nav">
         <li class="active"><a href="UserServlet">用户管理</a></li>
          
          
         <li class="dropdown">
            <a href="#" class="dropdown-toggle" data-toggle="dropdown">
               设备管理<b class="caret"></b>
            </a>
            <ul class="dropdown-menu">
               <li><a href="DeviceServlet">设备型号管理</a></li>
               <li><a href="DeviceTypeServlet">设备类型管理</a></li>
            </ul>
         </li>
         <li class="dropdown">
            <a href="#" class="dropdown-toggle" data-toggle="dropdown">
               监控设置<b class="caret"></b>
            </a>
            <ul class="dropdown-menu">
             <li><a href="TgateServlet">监控网关管理</a></li>
               <li><a href="TprojectServlet">监控项目管理</a></li>
             
               <li><a href="TgatedeviceServlet">监控设备管理</a></li>
            </ul>
         </li>
         <li class="active"><a href="real.jsp">实时监控</a></li>
         <li class="active"><a href="history.jsp">历史数据</a></li>
          <li class="active"><a href="connect.jsp">联系我们</a></li>
      </ul>
   </div>   
   <form class="navbar-form navbar-right" >
   <%
   String 	usertype=CodeExchange.chinese((String)session.getAttribute("loginusertype"));	
  
   %>
   
         <label ><%=session.getAttribute("loginusername") %>，<%=session.getAttribute("loginusertype") %></label> 
          <!-- //3改 ：获取姓名和密码和类型 -->
          <label > <a href="index.jsp">注销</a></label>
    <%
     Tuser user=new Tuser();
 	   
    	String 	usertype01=CodeExchange.chinese((String)session.getAttribute("loginusertype"));	
    	
		session.setAttribute("usertype01", usertype01);
 	
     %>
                 
   </form>
  </div>
    
</nav>
</body>
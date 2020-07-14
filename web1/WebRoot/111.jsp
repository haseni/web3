<%@ page language="java" import="java.util.*,iot.bean.*"
	pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<jsp:include page="head.jsp"></jsp:include>
<div class="container">
	<ol class="breadcrumb">
		<li><a href="login.jsp">Home</a></li>
		<li class="active">首页</li>
	</ol>	
</div>
<jsp:include page="foot.jsp"></jsp:include>

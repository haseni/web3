<%@ page language="java" import="java.util.*,iot.bean.*"
	pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<jsp:include page="head.jsp"></jsp:include>

<div class="container">
	<ol class="breadcrumb">
		<li><a href="#">Home</a></li>
		<li class="active">编辑用户</li>
	</ol>

	<div class="panel panel-default">
		<div class="panel-heading">编辑用户信息</div>
		<div class="panel-body">
		    <jsp:useBean id="user" class="iot.bean.Tuser" scope="request">
		       <jsp:setProperty name="user" property="*" />
		    </jsp:useBean>
			<!-- form-horizontal：水平排列  ?action=add 带参数时 必须是post-->
			<form class="form-horizontal" action="UserServlet?action=updateSave" method="post" role="form">
				<div class="form-group">
				   <!--  col-md-4：表示12列占用4列，可以控制宽度 -->
					<label class="col-md-4 control-label">用户名：</label>
					<div class="col-md-4">
						<input class="form-control" name="username" id="username" value="<%=user.getUsername() %>" placeholder="请输入用户名" type="text" required>
					    <!-- hidden是为了传递不可见的参数 -->
					    <input type="hidden" name="id"  value="<%=user.getId() %>"  id="id" >
					</div>
				</div>
				<div class="form-group">
					<label class="col-md-4 control-label">密　码：</label>
					<div class="col-md-4">
						<input class="form-control" name="password" id="password"  value="<%=user.getPassword() %>"  placeholder="请输入密码" type="password" required>
					</div>
				</div>
				<div class="form-group">
					<label class="col-md-4 control-label">用户类型：</label>
					<div class="col-md-4">
						<select id="usertype" name="usertype"  class="form-control">
						   <option value="普通用户" <%=user.getUsertype().equals("普通用户")?"selected":"" %> >普通用户</option>
						   <option value="管理员"  <%=user.getUsertype().equals("管理员")?"selected":"" %>>管理员</option>
						     <option value="游客"  <%=user.getUsertype().equals("游客")?"selected":"" %>>游客</option>
						</select>
					</div>
				</div>
				<div class="form-group">
				    <label class="col-md-4 control-label"></label>
				    <div class="col-md-4">
				         <button type="submit" class="btn btn-default">保存</button>
				         <a class="btn btn-default" href="UserServlet">返回</a>
				    </div>
				</div>
			</form>
		</div>
	</div>

</div>


<jsp:include page="foot.jsp"></jsp:include>

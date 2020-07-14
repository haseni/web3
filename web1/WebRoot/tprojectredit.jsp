<%@ page language="java" import="java.util.*,iot.bean.*,iot.dao.*"
	pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<jsp:include page="head.jsp"></jsp:include>

<div class="container">
	<ol class="breadcrumb">
		<li><a href="#">Home</a></li>
		<li class="active">编辑监控设备</li>
	</ol>

	<div class="panel panel-default">
		<div class="panel-heading">编辑监控设备信息</div>
		<div class="panel-body">
		    <jsp:useBean id="tproject" class="iot.bean.Tproject" scope="request">
		       <jsp:setProperty name="tproject" property="*" />
		    </jsp:useBean>
			<!-- form-horizontal：水平排列  ?action=add 带参数时 必须是post-->
			<form class="form-horizontal" action="TprojectServlet?action=updateSave" method="post" role="form">
				<div class="form-group">
				   <!--  col-md-4：表示12列占用4列，可以控制宽度 -->
					<label class="col-md-4 control-label">监控设备名：</label>
					<div class="col-md-4">
						<input class="form-control" name="projectname" id="projectname" value="<%=tproject.getProjectname() %>" placeholder="请输入监控设备名" type="text" required>
					    <!-- hidden是为了传递不可见的参数 -->
					    <input type="hidden" name="id"  value="<%=tproject.getId() %>"  id="id" >
					</div>
				</div>
				<div class="form-group">
					<label class="col-md-4 control-label">备注：</label>
					<div class="col-md-4">
						<input class="form-control" name="remark" id="remark"  value="<%=tproject.getRemark() %>"  placeholder="请输入备注" type=text required>
					</div>
				</div>
				<div class="form-group">
					<label class="col-md-4 control-label">用户ID：</label>
					<div class="col-md-4">
							<input class="form-control" name="uid" id="uid"  value="<%=tproject.getUid() %>"  placeholder="请输入用户名" type="text" required>
					</div>
				</div>
				<%-- <div class="form-group">
					<label class="col-md-4 control-label">时间：</label>
					<div class="col-md-4">
							<input class="form-control" name="addtime" id="addtime"  value="<%=tproject.getAddtime() %>"  placeholder="请输入时间" type="text" required>
					</div>
				</div> --%>
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

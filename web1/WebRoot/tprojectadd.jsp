<%@ page language="java" import="java.util.*,iot.bean.*,java.text.SimpleDateFormat" 


	pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<jsp:include page="head.jsp"></jsp:include>

<div class="container">
	<ol class="breadcrumb">
		<li><a href="#">Home</a></li>
		<li class="active">添加监控项目</li>
	</ol>

	<div class="panel panel-default">
		<div class="panel-heading">添加监控项目信息</div>
		<div class="panel-body">
			<!-- form-horizontal：水平排列  ?action=add 带参数时 必须是post-->
			<form class="form-horizontal" action="TprojectServlet?action=add" method="post" role="form">
				<div class="form-group">
				   <!--  col-md-4：表示12列占用4列，可以控制宽度 -->
					<label class="col-md-4 control-label">监控项目名：</label>
					<div class="col-md-4">
						<input class="form-control" name="projectname" id="projectname" placeholder="请输入监控项目名" type="text" required>
					</div>
				</div>
				<div class="form-group">
					<label class="col-md-4 control-label">备注：</label>
					<div class="col-md-4">
						<input class="form-control" name="remark" id="remark" placeholder="请输入备注" type="text" required>
					</div>
				</div>
				<div class="form-group">
					<label class="col-md-4 control-label">用户ID：</label>
					<div class="col-md-4">
			         
						<input class="form-control" name="uid" id="uid" placeholder="用户ID" type="text" required >

					</div>
				</div>
				
				<!-- <div class="form-group">
					<label class="col-md-4 control-label">系统时间：</label>
					<div class="col-md-4">
					 
						<input class="form-control" name="addtime" id="addtime" placeholder="请输入时间" type="text" required>
					</div> -->
				</div>
				<div class="form-group">
				    <label class="col-md-4 control-label"></label>
				    <div class="col-md-4">
				         <button type="submit" class="btn btn-default">保存</button>
				         <a class="btn btn-default" href="TprojectServlet">返回</a>
				    </div>
				</div>
			</form>
		</div>
	</div>

</div>
<jsp:include page="foot.jsp"></jsp:include>

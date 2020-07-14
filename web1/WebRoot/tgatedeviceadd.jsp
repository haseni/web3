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
		<li class="active">添加设备监控</li>
	</ol>

	<div class="panel panel-default">
		<div class="panel-heading">添加设备监控信息</div>
		<div class="panel-body">
			<!-- form-horizontal：水平排列  ?action=add 带参数时 必须是post-->
			<form class="form-horizontal" action="TgatedeviceServlet?action=add" method="post" role="form">
				<div class="form-group">
				   <!--  col-md-4：表示12列占用4列，可以控制宽度 -->
					<label class="col-md-4 control-label">设备监控名：</label>
					<div class="col-md-4">
						<input class="form-control" name="clientdevicename" id="clientdevicename" placeholder="请输入设备监控名" type="text" required>
					</div>
				</div>
				<div class="form-group">
					<label class="col-md-4 control-label">设备监控接口号：</label>
				 	<div class="col-md-4">
  		<select id="clientdeviceenabled" name="clientdeviceenabled"  class="form-control">
						   <option value="0">0</option>
						   <option value="1">1</option>
						</select>
						</div>
				</div>
				<div class="form-group">
					<label class="col-md-4 control-label">默认号：</label>
					<div class="col-md-4">
						<input class="form-control" name="clientdeviceid" id="clientdeviceid" placeholder="请输入默认号" type="text" required>
					</div>
			
				</div>
				<div class="form-group">
				    <label class="col-md-4 control-label"></label>
				    <div class="col-md-4">
				         <button type="submit" class="btn btn-default">保存</button>
				         <a class="btn btn-default" href="TgatedeviceServlet">返回</a>
				    </div>
				</div>
			</form>
		</div>
	</div>

</div>
<jsp:include page="foot.jsp"></jsp:include>

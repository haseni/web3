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
		<li class="active">添加设备</li>
	</ol>

	<div class="panel panel-default">
		<div class="panel-heading">添加设备信息</div>
		<div class="panel-body">
			<!-- form-horizontal：水平排列  ?action=add 带参数时 必须是post-->
			<form class="form-horizontal" action="DeviceServlet?action=add" method="post" role="form">
		 
				<div class="form-group">
					<label class="col-md-4 control-label">设备型号名称：</label>
					<div class="col-md-4">
						<!-- <input class="form-control" name="devicetypename" id="devicetypename" placeholder="请输入设备型号名称" type="text" required> -->
					<select id="devicetypename" name="devicetypename"  class="form-control">
						   <option value="监控设备">监控设备</option>
						   <option value="感知设备">感知设备</option>
						    <option value="控制设备">控制设备</option>
						</select>
					</div>
				</div>
				<div class="form-group">
					<label class="col-md-4 control-label">设备型号：</label>
					<div class="col-md-4">
						<input class="form-control" name="devicetypecode" id="devicetypecode" placeholder="请输入设备标示" type="text" required>
					</div>
				</div>
				<div class="form-group">
					<label class="col-md-4 control-label">设备配置：</label>
					<div class="col-md-4">
						<input class="form-control" name="devicetypeconfig" id="devicetypeconfig" placeholder="请输入设备配置" type="text" required>
					</div>
				</div>
							<div class="form-group">
					<label class="col-md-4 control-label">备注：</label>
					<div class="col-md-4">
						<input class="form-control" name="remark" id="remark" placeholder="请输入备注" type="text" required>
					</div>
				</div>
				<div class="form-group">
				    <label class="col-md-4 control-label"></label>
				    <div class="col-md-4">
				         <button type="submit" class="btn btn-default">保存</button>
				         <a class="btn btn-default" href="devicelist.jsp">返回</a>
				    </div>
				</div>
			</form>
		</div>
	</div>

</div>
<jsp:include page="foot.jsp"></jsp:include>

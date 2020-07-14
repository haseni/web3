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
 	<form class="form-horizontal" action="DeviceTypeServlet?action=add" method="post" role="form" enctype="multipart/form-data" >
				<div class="form-group">
					<label class="col-md-4 control-label">设备类型dtid：</label>
					<div class="col-md-4">
					    <input class="form-control" name="dtid" id="dtid" placeholder="请输入设备类型dtid" type="text" required>
				    </div>
				</div>
					<div class="form-group">
					<label class="col-md-4 control-label">设备型号：</label>
					<div class="col-md-4">
					    <input class="form-control" name="devicecode" id="devicecode" placeholder="请输入设备型号" type="text" required>
				    </div>
				</div>
				<div class="form-group">
				   <!--  col-md-4：表示12列占用4列，可以控制宽度 -->
					<label class="col-md-4 control-label">设备型号名称：</label>
					<div class="col-md-4">
						<input class="form-control" name="devicename" id="devicename" placeholder="请输入设备型号名称" type="text" required>
					</div>
				</div>

				<div class="form-group">
					<label class="col-md-4 control-label">设备照片：</label>
					<div class="col-md-4">
					    <input class="form-control" name="devicephoto" id="devicephoto"  type="file" >
				    </div>
				</div>
					<div class="form-group">
					<label class="col-md-4 control-label">设备配置：</label>
					<div class="col-md-4">
					    <input class="form-control" name="deviceconfig" id="deviceconfig"  type="text" >
				    </div>
				</div>
				<div class="form-group">
					<label class="col-md-4 control-label">设备接口号：</label>
					<div class="col-md-4">
					    <input class="form-control" name="deviceenabled" id="deviceenabled"  type="text" >
				    </div>
				</div>
							<div class="form-group">
					<label class="col-md-4 control-label">备注：</label>
					<div class="col-md-4">
					    <input class="form-control" name="remark" id="remark"  type="text" >
				    </div>
				</div>
				<div class="form-group">
				    <label class="col-md-4 control-label"></label>
				    <div class="col-md-4">
				         <button type="submit" class="btn btn-default">保存</button>
				         <a class="btn btn-default" href="DeviceTypeServlet">返回</a>
				    </div>
				</div>
			</form>
 
		</div>
	</div>

</div>
<jsp:include page="foot.jsp"></jsp:include>

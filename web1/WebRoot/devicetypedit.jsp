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
		<li class="active">编辑设备类型</li>
	</ol>

	<div class="panel panel-default">
		<div class="panel-heading">编辑设备类型信息</div>
		<div class="panel-body">
		    <jsp:useBean id="deviceTp" class="iot.bean.DeviceTp" scope="request">
		       <jsp:setProperty name="deviceTp" property="*" />
		    </jsp:useBean>
 <jsp:useBean id="device" class="iot.bean.Device" scope="request">
		       <jsp:setProperty name="device" property="*" />
		    </jsp:useBean>
			<!-- form-horizontal：水平排列  ?action=add 带参数时 必须是post-->
			
			<form class="form-horizontal" action="DeviceTypeServlet?action=updateSave" method="post" role="form" enctype="multipart/form-data" >
				<div class="form-group">
			<%-- 		<label class="col-md-4 control-label">设备类型id：</label>
					<div class="col-md-4">
					    <input class="form-control" name="id" id="id" value="<%=deviceTp.getId() %> "placeholder="请输入设备类型id" type="text" required>
				    </div> --%>
				    
				</div>
				<%
				DeviceOp dop =new DeviceOp();
					ArrayList<Device> dds=dop.query("");	
					for(int i=0;i<dds.size();i++){
					Device ddds=dds.get(i);
					} 
				
				 %>
						 
			<%-- 				<div class="form-group">
				   <!--  col-md-4：表示12列占用4列，可以控制宽度 -->
					<label class="col-md-4 control-label">设备名称：</label>
					<div class="col-md-4">
						<input class="form-control" name="did" id="did" value="<%=ddds.getDevicetypename() %>" placeholder="请输入设备型号名称" type="text" required>
					 <input type="hidden" name="id"  value="<%=deviceTp.getId() %>"  id="id" >
					</div>
				</div> --%>
				
				
				<div class="form-group">
				   <!--  col-md-4：表示12列占用4列，可以控制宽度 -->
					<label class="col-md-4 control-label">设备型号名称：</label>
					<div class="col-md-4">
						<input class="form-control" name="devicename" id="devicename" value="<%=deviceTp.getDevicename() %>" placeholder="请输入设备型号名称" type="text" required>
					 <input type="hidden" name="id"  value="<%=deviceTp.getId() %>"  id="id" >
					</div>
				</div>
				<div class="form-group">
					<label class="col-md-4 control-label">设备型号：</label>
					<div class="col-md-4">
					    <input class="form-control" name="devicecode" id="devicecode" value="<%=deviceTp.getDevicecode() %>" placeholder="请输入设备型号" type="text" >
				    </div>
				</div>
				<div class="form-group">
					<label class="col-md-4 control-label">设备照片：</label>
					<div class="col-md-4">
					    <input class="form-control" name="devicephoto" id="devicephoto" value="<%=deviceTp.getDevicephoto() %>" type="file" >
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

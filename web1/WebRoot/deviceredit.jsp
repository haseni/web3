<%@ page language="java" import="java.util.*,iot.bean.*"
	pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<style>


#bkcolor{
 
background:-webkit-linear-gradient(top,#808a87,#dcdcdc);
background:-moz-linear-gradient(top,#808a87,#dcdcdc);
background:-ms-linear-gradient(top,#808a87,#dcdcdc);
background:-linear-gradient(top,#808a87,#dcdcdc);
 
 
}
 
</style>
<jsp:include page="head.jsp"></jsp:include>
 
<div class="container"  >
	<ol class="breadcrumb">
		<li><a href="#">Home</a></li>
		<li class="active">编辑设备</li>
	</ol>

	<div class="panel panel-default">
		<div class="panel-heading">编辑设备信息</div>
		<div class="panel-body">
		    <jsp:useBean id="device" class="iot.bean.Device" scope="request">
		       <jsp:setProperty name="device" property="*" />
		    </jsp:useBean>
			<!-- form-horizontal：水平排列  ?action=add 带参数时 必须是post-->
			<form class="form-horizontal" action="DeviceServlet?action=updateSave" method="post" role="form">
				<div class="form-group">
				   <!--  col-md-4：表示12列占用4列，可以控制宽度 -->
					<label class="col-md-4 control-label">设备名称：</label>
					<div class="col-md-4">
						<input class="form-control" name="devicetypename" id="devicetypename" value="<%=device.getDevicetypename() %>" placeholder=" " type="text" required>
					    <!-- hidden是为了传递不可见的参数 -->
					    <input type="hidden" name="id"  value="<%=device.getId() %>"  id="id" >
					</div>
				</div>
				<div class="form-group">
					<label class="col-md-4 control-label">设备型号：</label>
					<div class="col-md-4">
						<input class="form-control" name="devicetypecode" id="devicetypecode"  value="<%=device.getDevicetypecode() %>"  placeholder=" " type="text" required>
					</div>
				</div>
				<div class="form-group">
					<label class="col-md-4 control-label">设备配置：</label>
					<div class="col-md-4">
						<input class="form-control" name="devicetypeconfig" id="devicetypeconfig"  value="<%=device.getDevicetypeconfig() %>"  placeholder=" " type="text" required>
					</div>
				</div>
				<div class="form-group">
				    <label class="col-md-4 control-label"></label>
				    <div class="col-md-4">
				         <button type="submit" class="btn btn-default">保存</button>
				         <a class="btn btn-default" href="DeviceServlet">返回</a>
				    </div>
				</div>
			</form>
		</div>
	</div>

</div>


<jsp:include page="foot.jsp"></jsp:include>

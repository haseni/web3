<%@ page language="java" import="java.util.*,iot.bean.*,iot.dao.*"
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

<div class="container" id="bkcolor">
	<ol class="breadcrumb">
		<li><a href="#">Home</a></li>
		<li class="active">编辑控制设备信息</li>
	</ol>

	<div class="panel panel-default">
		<div class="panel-heading">编辑控制设备信息</div>
		<div class="panel-body">
		    <jsp:useBean id="tgate1" class="iot.bean.tgatedevice" scope="request">
		       <jsp:setProperty name="tgate1" property="*" />
		    </jsp:useBean>
			<!-- form-horizontal：水平排列  ?action=add 带参数时 必须是post-->
			<form class="form-horizontal" action="TgatedeviceServlet?action=updateSave" method="post" role="form">
				
				<div class="form-group">
				   <!--  col-md-4：表示12列占用4列，可以控制宽度 -->
					<label class="col-md-4 control-label">网关名称：</label>
					<div class="col-md-4">
						<select id="gid" name="gid"  class="form-control">
						<%
							TgateDao gateDao=new TgateDao();
							ArrayList<Tgate> gates=gateDao.query("");
							for(int i=0;i<gates.size();i++){
								Tgate gate=gates.get(i);
						%>
							<option value=<%=gate.getId() %>> <%=gate.getGatename() %></option>
						<%
							}
						%>
						</select>
					</div>
				</div>
				
			
				<div class="form-group">
				   <!--  col-md-4：表示12列占用4列，可以控制宽度 -->
					<label class="col-md-4 control-label">设备监控名：</label>
					<div class="col-md-4">
						<input class="form-control" name="clientdevicename" id="clientdevicename" value="<%=tgate1.getClientdevicename() %>" placeholder="请输入设备监控名" type="text" required>
					    <!-- hidden是为了传递不可见的参数 -->
					    <input type="hidden" name="id"  value="<%=tgate1.getId() %>"  id="id" >
					</div>
				</div>	 
				
					<div class="form-group">
				   <!--  col-md-4：表示12列占用4列，可以控制宽度 -->
					<label class="col-md-4 control-label">设备监控接口号码：：</label>
					<div class="col-md-4">
						<input class="form-control" name="clientdeviceenabled" id="clientdeviceenabled" value="<%=tgate1.getClientdeviceenabled() %>" placeholder="请输入监控接口号码" type="text" required>
					    
					</div>
				</div>
				
				<div class="form-group">
					<label class="col-md-4 control-label">默认号：</label>
					<div class="col-md-4">
						<input class="form-control" name="clientdeviceid" id="clientdeviceid"  value="<%=tgate1.getClientdeviceid() %>"  placeholder="请输入默认号" type="text" required>	 
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

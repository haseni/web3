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
		<li class="active">编辑监控网关</li>
	</ol>

	<div class="panel panel-default">
		<div class="panel-heading">编辑监控网关信息</div>
		<div class="panel-body">
		    <jsp:useBean id="gates" class="iot.bean.Tgate" scope="request">
		       <jsp:setProperty name="gates" property="*" />
		    </jsp:useBean>
			<!-- form-horizontal：水平排列  ?action=add 带参数时 必须是post-->
			<form class="form-horizontal" action="TgateServlet?action=updateSave" method="post" role="form">
		 
			 <div class="form-group">
				   <!--  col-md-4：表示12列占用4列，可以控制宽度 -->
					<label class="col-md-4 control-label">项目名称：</label>
					<div class="col-md-4">
						<select id="pid" name="pid"  class="form-control">
						<%
							TprojectDao projectDao=new TprojectDao();
							ArrayList<Tproject> projects=projectDao.query("");
							for(int i=0;i<projects.size();i++){
				          		Tproject project=projects.get(i);
						%>
							<option value=<%=project.getId()  %>>  <%=project.getProjectname() %></option>
						<%
							}
						%>
						</select>
					</div>
				</div>  <input type="hidden" name="id"  value="<%=gates.getId() %>"  id="id" >
				<div class="form-group">
					<label class="col-md-4 control-label">网关名称：</label>
					<div class="col-md-4">
						<input class="form-control" name="gatename" id="gatename"  value="<%=gates.getGatename() %>"  placeholder="请输入网关名称" type="text" required>
					</div>
				</div>
				<div class="form-group">
					<label class="col-md-4 control-label">网关编号：</label>
					<div class="col-md-4">
						<input class="form-control" name="gateid" id="gateid"  value="<%=gates.getId() %>"  placeholder="请输入网关编号" type="text" required>
					</div>
				</div>
				<div class="form-group">
					<label class="col-md-4 control-label">是否启用：</label>
					<div class="col-md-4">
						<%-- <select id="gateenabled" name="gateenabled"  class="form-control">
						   <option value="1" <%=gates.getGateenabled()==1?"selected":"" %> >是</option>
						   <option value="0"  <%=gates.getGateenabled()==0?"selected":"" %>>否</option>
						</select> --%>
						<input class="form-control" name="gateenabled" id="gateenabled"  value="<%=gates.getGateenabled() %>"  placeholder="请输入1（启用）或0（未启用）" type="text" required>
					</div>
				</div>
		 
		 
				<div class="form-group">
				    <label class="col-md-4 control-label"></label>
				    <div class="col-md-4">
				         <button type="submit" class="btn btn-default">保存</button>
				         <a class="btn btn-default" href="TgaterServlet">返回</a>
				    </div>
				</div>
			</form>
		</div>
	</div>

</div>


<jsp:include page="foot.jsp"></jsp:include>

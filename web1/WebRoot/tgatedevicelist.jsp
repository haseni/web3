<%@ page language="java" import="java.util.*,iot.bean.* ,iot.dao.*"
	pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<jsp:include page="head.jsp"></jsp:include>

<div class="container">
	<ol class="breadcrumb">
		<li><a href="#">Home</a></li>
		<li class="active">监控设备管理</li>
	</ol>

	<div class="btn-toolbar">
		<a class="btn btn-primary" href="tgatedeviceadd.jsp"> <i
			class="glyphicon glyphicon-plus"></i>添加
		</a>
		<!-- <button class="btn">导入</button>
		<button class="btn">导出</button> -->

<%
//取出上回输入的查询条件

String fieldname="";
String keyword="";

if(request.getAttribute("fieldname")!=null && request.getAttribute("keyword")!=null){
	fieldname=request.getAttribute("fieldname").toString();
	keyword=request.getAttribute("keyword").toString();
}

%>
       <!--  form-inline:行内块元素显示，会水平排列 pull-right：向右浮动 -->
		<form action="TgatedeviceServlet" class="form-inline pull-right">
			<div class="form-group">
				<label for="fieldname">选择:</label> 
				<select id="fieldname" name="fieldname" class="form-control">
					<option value="id" <%=fieldname.equals("id")?"selected":"" %> >监控设备ID</option>
					<option value="clientdevicename" <%=fieldname.equals("clientdevicename")?"selected":"" %> >监控设备名</option>
					<option value="clientdeviceenabled" <%=fieldname.equals("clientdeviceenabled")?"selected":"" %> >监控接口号</option>
				</select>
			</div>
            <div class="form-group">
                <input type="text" name="keyword" value="<%=keyword %>" id="keyword" class="form-control" placeholder="请输入关键词">
            </div>
			<div class="form-group">
				<button type="submit" class="btn btn-default">查询</button>
			</div>
		</form>
		

	</div>
	
	
<!-- table-striped：奇偶行颜色不同 -->
	<table class="table table-striped">
		<thead>
			<tr>
				<th>监控设备ID</th>
				<th>项目名称</th>
				<th>网关名称</th>
				<th>终端设备名称</th>
	 
				<th>监控设备名</th>
				<th>监控接口号</th>
				<th>默认号</th>
			</tr>
		</thead>
		<tbody>

			<% ArrayList<tgatedevice> tgate=(ArrayList<tgatedevice>)request.getAttribute("gatedevices");
            if(tgate!=null)
	         {  TgatedeviceOp top =new TgatedeviceOp();
	          	for(int i=0;i<tgate.size();i++)
	         	 {
	          		tgatedevice tgate1=tgate.get(i);
	            	 %>
			<tr>
				<td><%=tgate1.getId() %></td>
				<td><%=top.selectProjectname(tgate1.getGid())%></td>
					<td><%=top.selectGatename(tgate1.getGid()) %></td>
				<td><%= top.selectDevicename(tgate1.getDid()) %></td>
			
			 
				
				<td><%=tgate1.getClientdevicename()  %></td>
				<td><%=tgate1.getClientdeviceenabled() %></td>
				<td><%=tgate1.getClientdeviceid() %></td>
				<td><a href="TgatedeviceServlet?action=update&id=<%=tgate1.getId() %>"><i
						class="glyphicon glyphicon-pencil"></i></a>
						 <a href="#" onclick="javascript:if(confirm('是否确认要删除？')) location.href='TgatedeviceServlet?action=delete&id=<%=tgate1.getId() %>'"><i
						class="glyphicon glyphicon-remove"></i></a></td>
			</tr>
			<%
	             }
	         } %>

		</tbody>
	</table>

	<!-- 下面是控制分页控件，必须要是ul元素才行 -->
	<ul id='bp-element'></ul>
<%
String msg="";
if(request.getAttribute("msg")!=null){
	msg=request.getAttribute("msg").toString();
}
if(msg.length()>0){
//显示提示信息
%>
    <div class="alert alert-info" id="statusbar" role="alert"><%=msg %></div>
<% 
}
%>
	

</div>

<%

String currentPage=request.getAttribute("currentPage").toString();
String total=request.getAttribute("total").toString();

%>
<script type="text/javascript">
$(function(){

        var element = $('#bp-element');
        options = {
            bootstrapMajorVersion:3, //对应的bootstrap版本
            currentPage: <%=currentPage%>, //当前页数，获取从后台传过来的值
            numberOfPages: 5, //每页页数
            totalPages:<%=total%>, //总页数，获取从后台传过来的值
            shouldShowPage:true,//是否显示该按钮
            itemTexts: function (type, page, current) {//设置显示的样式，默认是箭头
                switch (type) {
                    case "first":
                        return "首页";
                    case "prev":
                        return "上一页";
                    case "next":
                        return "下一页";
                    case "last":
                        return "末页";
                    case "page":
                        return page;
                }
            },
            //点击事件
            onPageClicked: function (event, originalEvent, type, page) {
            	
                location.href = "UserServlet?page=" + page +"&fieldname=<%=fieldname%>&keyword=<%=keyword%>";
            }
        };
        element.bootstrapPaginator(options);

});
</script>

<jsp:include page="foot.jsp"></jsp:include>

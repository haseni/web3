<%@ page language="java" import="java.util.*,iot.bean.*"
	pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<jsp:include page="head1.jsp"></jsp:include>
<script src="js/echarts.common.min.js"></script>
<script type="text/javascript">
	$(function () {           
    // 指定图表的配置项和数据
    	var format = "";
    	var format1="2000-01-01T00:00:00";
		var nTime = new Date();
		format += nTime.getFullYear()+"-";
		format += (nTime.getMonth()+1)<10?"0"+(nTime.getMonth()+1):(nTime.getMonth()+1);
		format += "-";
		format += nTime.getDate()<10?"0"+(nTime.getDate()):(nTime.getDate());
		format += "T";
		format += nTime.getHours()<10?"0"+(nTime.getHours()):(nTime.getHours());
		format += ":";
		format += nTime.getMinutes()<10?"0"+(nTime.getMinutes()):(nTime.getMinutes());
		format += ":00";
		document.getElementById("starttime").value = format1;
		document.getElementById("endtime").value = format;
	    var myChart = echarts.init(document.getElementById('chartcontainer'));
	    $("#search").click(function(){
	    	$.ajax({
				type : "post",
				data : {
					starttime: $("#starttime").val(),
					endtime: $("#endtime").val(),
					gdid: $("#gdid").val()
				},
				dataType : "json",
				url : "HistoryServlet",
				success : function(message) {
					option = {
		                title: {      //标题组件
		                    text: '温湿度折线图'
		                },
		                tooltip: {    //提示框组件
		                    trigger: 'axis'
		                },
		                legend: {     //图例组件
		                	data: ['温度', '湿度']
		                },
		                grid: {       //直角坐标系内绘图网格
		                    left: '3%',
		                    right: '4%',
		                    bottom: '3%',
		                    containLabel: true
		                },
		                toolbox: {     //工具栏
		                   show : true,
		                
		                    feature: {
		                    mark : {show: true},
				            dataView : {show: true, readOnly: false},
				             magicType : {show: true, type: ['bar', 'line']}, 
				            restore : {show: true},
				            saveAsImage : {show: true}

		                    }
		                },
		                xAxis: {       //直角坐标系 grid 中的 x 轴
		                    type: 'category',
		                    boundaryGap: false,
		                },
		                yAxis: {       //直角坐标系 grid 中的 y 轴
		                    type: 'value'
		                },
		                series: [      //系列列表
		                    {
		                        name: '温度',
		                        symbol:'none',
		                        type: 'line',
		                        smooth:true,
		                    },
		                    {
		                        name: '湿度',
		                        symbol:'none',
		                        type: 'line',
		                        smooth:true,
		                    },
		                ]
		            };
					option.series[0].data=[];
					option.series[1].data=[];
					option.xAxis.data=[];
					for (var i = 0; i < message.length; i++) {
						option.series[0].data.push(message[i].temp);
						option.series[1].data.push(message[i].humi);
						option.xAxis.data.push(message[i].time);
					}
		            myChart.setOption(option); 
				},
				error : function(result) {
					alert("服务器异常，请稍后重试-100");
				}
			});
	    });
	});
		
</script>
<div class="container">
	<ol class="breadcrumb">
		<li><a href="index.jsp">Home</a></li>
		<li class="active">历史数据</li>
	</ol>
	<div class="btn-toolbar">
		<form action="" class="form-inline">
			<div class="form-group">
				<label for="form-control">选择网关设备ID:</label> 
				<select id="gdid" name="gdid" class="form-control">
					<option value="1010001">01010001</option>
					<option value="1010002">02010001</option>

				</select>
			</div>
			<div class="form-group">
			<label for="fieldname">开始时间:</label> 
				<input type="datetime-local" name="starttime" id="starttime" class="form-control">
			</div>
			<div class="form-group">
			<label for="fieldname">结束时间:</label> 
				<input type="datetime-local" name="endtime" id="endtime" class="form-control">
			</div>
			<div class="form-group">
				<button type="button" class="btn btn-default" id="search" >查询</button>
			</div>
		</form>
	</div>
	<div class="row">
		<div id="chartcontainer" style="min-width: 450px; height: 400px; margin: 0 auto;overflow:auto;"></div>
	</div>
</div>
<jsp:include page="foot.jsp"></jsp:include>
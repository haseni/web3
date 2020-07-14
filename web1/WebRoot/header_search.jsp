<%@ page language="java" import="java.util.*,javax.swing.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'userlogin.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<script src="js/login.js"></script>
	<script src="js/jquery-1.8.2.min.js"></script>

    <script>
		$(document).ready(function() {
			$("#search").keyup(function(){
		    	var keyCode = event.keyCode;    
		    	if(keyCode == 13)
		    	{
		    		$("#newsSearch").click();
		    	}
		    	else
		    	{     	
					var searcon=$("#search").val();
					$.ajax({ 
						type: "post", 
						url: "getSearchTips", 
						//dataType:'json', 
						data:"searchname="+searcon,
						success: function(data) {
							$('#hint').html(data);
							
							//如果有提示则显示，没有提示则不显示
							if($('#hint').text().length>0)
							{
								//获取网页滚动的left值
								var srlLeft=getScrollLeft();
								var LeftDiv=$("#search").offset().left;
								var Left=srlLeft+parseInt(LeftDiv);
								$("#hint").css("left",Left+"px");//设置列表框的left值
								
								//获取网页滚动的top值
								var srlTop=getScrollTop();
								var TopDiv=$("#search").offset().top;
								var Top=srlTop+parseInt(TopDiv)+24;
								$("#hint").css("top",Top+"px");//设置列表框的top值
								$("#hint").css("height","100px");
								$("#hint").css("width","226px");
								$("#hint").css("color","black");
								$("#hint").css({"background-color":"white"});
								$("#hint").css("position","absolute");
								$("#hint").show();
							}
							else
							{
								$("#hint").css('display','none');
							}
						} 
					});
				}
			});
			//$("#searchname").html($.ajax({url:"top.html",async:false}).responseText);
			$("#newsSearch").click(function(){
				var searcon=$("#search").val();
				$("#hint").css('display','none');
				//alert(searcon);
				$.ajax({ 
					type: "post", 
					url: "getNewsbySearch", 
					//dataType:'json', 
					data:"searchname="+searcon,
					success: function(data) {
						//正文两边比例调整，并将右边内容清除
						$("#td_right").css('width','0');
						$("#td_right").css('border','none');
						$("#td_left").css('width','100%');
						$("#content_left").css('width','100%');
						$("#content_right").css('width','0');
						$('#content_right').html("");
						
						$('#content_left').html(data);
					} 
				});
			});
		});
		
		//获取网页滚动的top值
	    function getScrollTop(){  
	         var bodyTop = 0;    
	         if (typeof window.pageYOffset != 'undefined') {    
	             bodyTop = window.pageYOffset;    
	         } else if (typeof document.compatMode != 'undefined' && document.compatMode != 'BackCompat') {    
	             bodyTop = document.documentElement.scrollTop;    
	         }    
	         else if (typeof document.body != 'undefined') {    
	             bodyTop = document.body.scrollTop;    
	         }    
	         return bodyTop  
	    }  
		
		//获取网页滚动的left值
	    function getScrollLeft(){  
	         var bodyLeft = 0;    
	         if (typeof window.pageXOffset != 'undefined') {    
	             bodyLeft = window.pageXOffset;    
	         } else if (typeof document.compatMode != 'undefined' && document.compatMode != 'BackCompat') {    
	             bodyLeft = document.documentElement.scrollLeft;    
	         }    
	         else if (typeof document.body != 'undefined') {    
	             bodyLeft = document.body.scrollLeft;    
	         }    
	         return bodyLeft  
	    }  

		function getlist(id)
		{
			//将选中项的内容放置到文本框"searchname"中
			$("#search").val($("#res_"+id).text());
			//选择提示列表消失，下面两种方法都可以
			//$("#reslist").hide();
			$("#hint").css('display','none');
		}
		
		function overlist(id)
		{
			$("#res_"+id).css('background-color','palegreen');
		}
		
		function outlist(id)
		{
			$("#res_"+id).css('background-color','transparent');
		}
		
		function getNewsbyCol(id)
		{
			if(id==10)
			{
				 location.href="index.jsp";
			}else{
				//正文两边比例调整，并将右边内容清除
				$("#td_right").css('width','0');
				$("#td_right").css('border','none');
				$("#td_left").css('width','100%');
				$("#content_left").css('width','100%');
				$("#content_right").css('width','0');
				$('#content_right').html("");
				
				$("#content_left").html($.ajax({url:"getColumnNews",data:"IndexCol="+id,async:false}).responseText);
			}
		}
	</script>
  </head>
  
  <body>
  <table width=100%>
    <tr height="100px"><td width="55%">
      <a href="index.jsp"><img src="images/logo.jpg"/></a>
      </td><td style="padding:0px 10px 0px 0px;">
      <div style="width:380px;height:55px;padding:10px 20px 0px 0px;text-align:right;color:gray;line-height:160%">
	      <%String username=(String)request.getSession().getAttribute("username");
	        if(username==null){ 
	      %>
	        <font color=gray>您好！欢迎光临新闻系统，请登录。</font>&nbsp;<a href="userRegister.jsp" style="color:blue;">注册</a><br/>用户名：<input type="text" name="username" id="username" onkeyup="$('#hint').css('display','none');" style="width:90px;"/>&nbsp;&nbsp;密码：<input type="password" name="password" id="password" onkeyup="$('#hint').css('display','none');PWEnter();" style="width:90px;"/><input type="button" class="buttontype2" id="login" value="登录" onclick="checkuser();" style="font-family:微软雅黑;"/>
	      <%}else{%>
	        <br/>&nbsp;&nbsp;<font color=gray><%=username %>,欢迎光临新闻系统。</font>&nbsp;&nbsp;<a style="color:blue;" href="userRegister.jsp">注册</a>&nbsp;&nbsp;<a class="hreftype" style="color:blue;" onclick="logout();">注销</a>
	      <%}%>
      </div>
      <div id="searcharea" style="text-align:right;width:360px;height:35px;font-family:微软雅黑;color:silver;background:red;margin:10px 0px 0px 10px;padding:7px 5px 0px 5px;" >
                     &nbsp;请输入:
        <input type="text" id="search" autocomplete="off" style="width:226px;height:22px;font-size:1.2em;border:0 solid gray;" >
        <button id="newsSearch" style="width:60px;height:24px;border:none;color:white;font-family:微软雅黑;font-size:1.2em;background:none;" value="搜索" >搜索</button></div>
    </td></tr>
    <tr height="26px"><td colspan="2" style="border-top:1 solid silver;" >
      <table width="100%" style="font-size:1em;font-family:微软雅黑;background:#2f65a9;"><tr>
        <td width="3%"></td>
        <td width="10%"><a class="nav" onclick="getNewsbyCol(10);">首页</a></td>
        <td width="10%"><a class="nav" onclick="getNewsbyCol(0);">最新消息</a></td>
        <td width="10%"><a class="nav" onclick="getNewsbyCol(1);">国内新闻</a></td>
        <td width="10%"><a class="nav" onclick="getNewsbyCol(2);">国际新闻</a></td>
        <td width="10%"><a class="nav" onclick="getNewsbyCol(3);">体育新闻</a></td>
        <td width="10%"><a class="nav" onclick="getNewsbyCol(4);">军事新闻</a></td>
        <td width="10%"><a class="nav" onclick="getNewsbyCol(5);">科技新闻</a></td>
        <td width="10%"><a class="nav" onclick="getNewsbyCol(6);">社会新闻</a></td>
        <td width="15%"><a class="nav" onclick="getNewsbyCol(7);"></a></td>
         <td width="2%"></td>
      </tr></table>
    </td></tr>
  </table>
  <div id="hint" style="top:50px;left:100px;width:150px;height:150px;overflow:auto;text-align:left;padding:2px 0 0 2px;background:white;border:1 solid gray;display:none;"></div>
  
  </body>
</html>

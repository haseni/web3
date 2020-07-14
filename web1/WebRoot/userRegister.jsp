<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'index.jsp' starting page</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	
	<script src="js/login.js"></script>
	<script src="js/jquery-1.8.2.min.js"></script>
	<link rel="stylesheet" type="text/css" href="css/yydk.css">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
    <script type="text/javascript"><!--
		var Regflag=true;
		var usermsg="";
		var passmsg="";
		var passmsg1="";
		var vericodemsg="";
		$(document).ready(function() {
			$("#header").html($.ajax({url:"header_reg.jsp",async:false}).responseText);
			$("#footer").html($.ajax({url:"footer.jsp",async:false}).responseText);
			
			//用户名输入事件
			$("#username").keyup(function(){
				var username=$('#username').val();
				$('#msg_reg').html("");   //清空注册错误消息
				if(username.length<5)    //该用户名太短信息显示
				{
					$('#usermsg').css("color","red");
					usermsg="用户名太短！";
					$('#usermsg').html("用户名太短！");
				}else{    //调用servlet查看用户表中是否存在该用户名
				 	$.ajax({ 
						type: "post", 
						url: "checkUser", 
						data:"username="+username,
						success: function(data) {
							if(data == "√")
							{
								$('#usermsg').css("color","blue");
								usermsg="";
							}
							else
							{
								$('#usermsg').css("color","red");
								usermsg=data;
							}
							$('#usermsg').html(data);
						} 
					});
				}
			});

			
			//密码输入事件
			$("#password").keyup(function(){
				var pass=$('#password').val();
				$('#msg_reg').html("");   //清空注册错误消息
				//判断密码强度
			 	getPasswordSecurity(pass);
			});

			//确认密码输入事件
			$("#password1").keyup(function(){
				var pass=$('#password').val();
				var pass1=$('#password1').val();
				$('#msg_reg').html("");   //清空注册错误消息
			 	if(pass != pass1)
			 	{
			 		$('#passmsg').css("color","red");
			 		$('#passmsg').html("两次输入密码不同！");
					passmsg1="两次密码不同。";
			 	}else
			 	{
			 		$('#passmsg').css("color","blue");
			 		$('#passmsg').html("√");
					passmsg1="";
			 	}
			});

			//刷新验证码
			$("#vericoderefresh").click(function(){
				$('#img_vcode').html("<img border=0 src=\"VerifyCode.jsp\">");
				$('#vericode').val("");
				$('#msg_vericode').html("");
			});
			
			//验证码输入框获得焦点时显示验证码
			$("#vericode").click(function(){
				$('#yzm').show();
			});
			
			//验证码输入事件
			$("#vericode").keyup(function(){
				var vericode=$('#vericode').val();
				$('#msg_reg').html("");   //清空注册错误消息
			 	$.ajax({ 
					type: "post", 
					url: "checkVericode", 
					data:"vericode="+vericode,
					success: function(data) {
						//判断验证码输入是否正确
						if(data == "")
						{
							$('#msg_vericode').css("color","blue");
							vericodemsg="";
						}
						else
						{
							$('#msg_vericode').css("color","red");
							vericodemsg="验证码错误。";
						}
						$('#msg_vericode').html(data);
					} 
				});
			});
			
			//注册按钮点击事件
			$("#register").click(function(){
				if(usermsg == "" && passmsg == "" && passmsg1 == "" && vericodemsg =="")
				{
					var username=$('#username').val();
					var password=$('#password').val();
				 	$.ajax({ 
						type: "post", 
						url: "userRegister", 
						data:"username="+username+"&password="+password,
						success: function(data) {
							$('#content').html("<div style=\'color:red;font-family:黑体;font-size:1.8em;margin:30px 0 5px 0;\'>恭喜你，"+data+"</div>");
							$('#content').append("<br>");
							$('#content').append("<a class='hreftype' href='index.jsp'>点击进入物联网监控平台系统首页</a>");
						} 
					});
				}else{
					$('#msg_reg').html("请修正红色错误。");
				}
			});

			//查看新闻系统协议
			$("#protocol").click(function(){
				var xy="1.经本站注册系统完成注册程序并通过身份认证的用户即成为正式用户，可以获得本站规定用户所应享有的一切权限；未经认证仅享有本站规定的部分会员权限。<br>2.用户有义务保证密码和帐号的安全，用户利用该密码和帐号所进行的一切活动引起的任何损失或损害，由用户自行承担全部责任，本站不承担任何责任。如用户发现帐号遭到未授权的使用或发生其他任何安全问题，应立即修改帐号密码并妥善保管，3.如有必要，请通知本站。因黑客行为或用户的保管疏忽导致帐号非法使用，本站不承担任何责任。<br>遵守中华人民共和国相关法律法规，包括但不限于《中华人民共和国计算机信息系统安全保护条例》、《计算机软件保护条例》、《最高人民法院关于审理涉及计算机网络著作权纠纷案件适用法律若干问题的解释(法释[2004]1号)》、《全国人大常委会关于维护互联网安全的决定》、《互联网电子公告服务管理规定》、《互联网新闻信息服务管理规定》、《互联网著作权行政保护办法》和《信息网络传播权保护条例》等有关计算机互联网规定和知识产权的法律和法规、实施办法。<br>4.用户对其自行发表、上传或传送的内容负全部责任，所有用户不得在本站任何页面发布、转载、传送含有下列内容之一的信息，否则本站有权自行处理并不通知用户：<br>(1)违反宪法确定的基本原则的；<br>(2)危害国家安全，泄漏国家机密，颠覆国家政权，破坏国家统一的；<br>(3)损害国家荣誉和利益的； <br>(4)煽动民族仇恨、民族歧视，破坏民族团结的； <br>(5)破坏国家宗教政策，宣扬邪教和封建迷信的；<br>(6)散布谣言，扰乱社会秩序，破坏社会稳定的；<br>(7)散布淫秽、色情、赌博、暴力、恐怖或者教唆犯罪的；<br> (8)侮辱或者诽谤他人，侵害他人合法权益的； <br>(9)煽动非法集会、结社、游行、示威、聚众扰乱社会秩序的； <br>(10)以非法民间组织名义活动的；<br>(11)含有法律、行政法规禁止的其他内容的。<br>5.用户承诺对其发表或者上传于本站的所有信息(即属于《中华人民共和国著作权法》规定的作品，包括但不限于文字、图片、音乐、电影、表演和录音录像制品和电脑程序等)均享有完整的知识产权，或者已经得到相关权利人的合法授权；如用户违反本条规定造成本站被第三人索赔的，用户应全额补偿本站一切费用(包括但不限于各种赔偿费、诉讼代理费及为此支出的其它合理费用)； <br>";
				$('#protocolcontent').html(xy);
				$('#protocolcontent').show();
			});
		});

		//密码强度 判断
		function getPasswordSecurity(pass){
			var pattern=/^[0-9]{6,}$/;
			var passSec=0;
			
			$('#flagStrong1').css({"background-color":"lightblue"});
			$('#flagStrong2').css({"background-color":"lightblue"});
			$('#flagStrong3').css({"background-color":"lightblue"});
			if(verifypass(pass))//如果密码长度小于6或是简单字母或数字重复或等差分布，强度为弱
			{
				$('#flagStrong1').css({"background-color":"red"});
		 		$('#passsecmsg').css("color","red");
		 		$('#passsecmsg').html(passmsg);
			}
			else if(pattern.exec(pass))//如果密码是6个只包含数字，强度为中
			{
				$('#flagStrong1').css({"background-color":"red"});
				$('#flagStrong2').css({"background-color":"red"});
		 		$('#passsecmsg').css("color","blue");
		 		$('#passsecmsg').html("√");
				passmsg="";
			}
			else
			{
				$('#flagStrong1').css({"background-color":"red"});
				$('#flagStrong2').css({"background-color":"red"});
				$('#flagStrong3').css({"background-color":"red"});
		 		$('#passsecmsg').css("color","blue");
		 		$('#passsecmsg').html("√");
				passmsg="";
			}
        }

		//弱密码条件判断        
        function verifypass(pass1){
        	var len1=pass1.length;
        	var cs=0;
        	if(len1<6)  //密码长度小于6
        	{
	        	passmsg="密码太短。";
        		return true;
        	}
        	if(len1>5)
        	{
        		var gap1=pass1.substring(1,2).charCodeAt()-pass1.substring(0,1).charCodeAt();
        		var len2=len1-1;
        		var i=0;
        		alert(gap1);
	        	while(i<len2)  //密码呈简单递增或递减，或密码相同
	        	{
	        		if(pass1.substring(i+1,i+2).charCodeAt()-pass1.substring(i,i+1).charCodeAt()==gap1)
	        			cs += 1;
	        		i++;
	        	}
	        	var pcs=len1*2/3;
	        	if(cs>pcs)
	        	{
	        		if(gap1==0)
	        			passmsg="密码重复字符太多。";
	        		else if(gap1==1 || gap1==-1)
						passmsg="密码简单分布。";
	        		return true;
	        	}
        	}
        	return false;
        }
    </script>
  </head>
  
  <body background="img/demo-1-bg.jpg">
    <div id="mframe">
    	<div id="header" style="border-bottom:1px solid silver;"></div>
    	<div id="content" style="margin:30px 0 0 0;">
    	  <table width=100% style="font-size:1em;font-family:微软雅黑;">
    	    <tr>
    	      <td width=35% height=50px align="right" valign="middle">用&nbsp;户&nbsp;名：</td>
    	      <td width=65% align="left" valign="middle"><div style="float:left;"><input type="text" id="username" style="width:240px;height:28px;"/></div>
    	      <div id="usermsg" style="width:240px;height:20px;color:red;float:left;line-height:28px;vertical-align:middle;font-size:0.7em;"></div></td>
    	    </tr>
    	    <tr>
    	      <td height=50px align="right" valign="middle">密&nbsp;&nbsp;&nbsp;&nbsp;码：</td>
    	      <td align="left" valign="middle"><div style="float:left;"><input type="password" id="password" style="width:240px;height:28px;"/></div>
	    	      <div id="flagStrong1" style="float:left;width:60px;height:24px;line-height:24px;text-align:center;vertical-align:middle;background-color:lightblue;margin:2 1px 0 2px;">弱</div>
	    	      <div id="flagStrong2" style="float:left;width:60px;height:24px;line-height:24px;text-align:center;vertical-align:middle;background-color:lightblue;margin:2 1px 0 1px;">中</div>
	    	      <div id="flagStrong3" style="float:left;width:60px;height:24px;line-height:24px;text-align:center;vertical-align:middle;background-color:lightblue;margin:2 0px 0 1px;">强</div>
    	      	  <div id="passsecmsg" style="width:120px;height:20px;color:red;float:left;line-height:28px;vertical-align:middle;font-size:0.7em;"></div>
    	      </td>
    	    </tr>
    	    <tr>
    	      <td height=50px align="right" valign="middle">密码确认：</td>
    	      <td align="left" valign="middle"><div style="float:left;"><input type="password" id="password1" style="width:240px;height:25px;"/></div>
    	      <div id="passmsg" style="width:240px;height:20px;color:red;float:left;font-size:0.7em;"></div></td>
    	    </tr>
    	    <tr>
    	      <td height="50px" align="right" valign="middle">验&nbsp;证&nbsp;码：</td>
    	      <td align="left" valign="middle"><div style="float:left;height:40px;"><input type="text" id="vericode" style="width:100px;height:40px;vertical-align:middle;"/></div>
    	      <div id="yzm" style="float:left;width:200px;height:40px;display:none;"><div id="img_vcode" style="float:left;"><img border=0 src="VerifyCode.jsp"></div>&nbsp;<a class="hreftype" id="vericoderefresh">刷新</a>
    	      <br/><div id="msg_vericode" style="font-size:0.7em;"></div></div>
    	      </td>
    	    </tr>
    	    <tr>
    	      <td height="100px" align="right" valign="bottom"></td>
    	      <td align="left" valign="middle"><div style="height:40px;"><input type="button" id="register" style="width:150px;height:40px;font-size:1em;" value="同意协议并注册"/></div>
    	      <div><a style="color:blue;" id="protocol" class="hreftype">《物联网监控平台系统协议》</a></div>
    	      <div id="msg_reg" style="color:red;font-size:0.7em;"></div>
    	      </td>
    	    </tr>
    	    <tr>
    	      <td height="60px" align="left" valign="middle" colspan="2">
    	      <div id="protocolcontent" style="float:left;overflow:auto;margin:0 30px 0 50px;height:300px;display:none;"></div>
    	      </td>
    	    </tr>
    	  </table>
    	</div>
    	<div id="footer"></div>
    </div>
  </body>
</html>

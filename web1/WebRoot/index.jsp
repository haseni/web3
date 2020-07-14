 <%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">

<title>物联网监控平台</title>

<!-- <link href="js/bootstrap/css/bootstrap.min.css" rel="stylesheet">
<script src="js/jquery-1.11.3.min.js"></script>
<script src="js/bootstrap/js/bootstrap.min.js"></script>


<style type="text/css">
</style>
<script type="text/javascript">
	
</script> -->

<link rel="stylesheet" type="text/css" href="css/normalize.css" />
<link rel="stylesheet" type="text/css" href="css/demo.css" />
<link rel="stylesheet" href="js/vendor/jgrowl/css/jquery.jgrowl.min.css">
<!--必要样式-->
<link rel="stylesheet" type="text/css" href="css/component.css" />
 
<style>
	input::-webkit-input-placeholder{
		color:rgba(0, 0, 0, 0.726);
	}
	input::-moz-placeholder{   /* Mozilla Firefox 19+ */
		color:rgba(0, 0, 0, 0.726);
	}
	input:-moz-placeholder{    /* Mozilla Firefox 4 to 18 */
		color:rgba(0, 0, 0, 0.726);
	}
	input:-ms-input-placeholder{  /* Internet Explorer 10-11 */ 
		color:rgba(0, 0, 0, 0.726);
	}
	.button {
  color: #666;
  background-color: #EEE;
  border-color: #EEE;
  font-weight: 300;
  font-size: 16px;
  font-family: "Helvetica Neue Light", "Helvetica Neue", Helvetica, Arial, "Lucida Grande", sans-serif;
  text-decoration: none;
  text-align: center;
  line-height: 40px;
  height: 40px;
  padding: 0 40px;
  margin: 0;
  display: inline-block;
  appearance: none;
  cursor: pointer;
  border: none;
  -webkit-box-sizing: border-box;
     -moz-box-sizing: border-box;
          box-sizing: border-box;
  -webkit-transition-property: all;
          transition-property: all;
  -webkit-transition-duration: .3s;
          transition-duration: .3s;
}
.button:visited {
    color: #666; }
  .button:hover, .button:focus {
    background-color: #f6f6f6;
    text-decoration: none;
    outline: none; }
  .button:active, .button.active, .button.is-active {
    text-shadow: 0 1px 0 rgba(255, 255, 255, 0.3);
    text-decoration: none;
    background-color: #eeeeee;
    border-color: #cfcfcf;
    color: #d4d4d4;
    -webkit-transition-duration: 0s;
            transition-duration: 0s;
    -webkit-box-shadow: inset 0 1px 3px rgba(0, 0, 0, 0.2);
            box-shadow: inset 0 1px 3px rgba(0, 0, 0, 0.2); }
  .button.disabled, .button.is-disabled, .button:disabled {
    top: 0 !important;
    background: #EEE !important;
    border: 1px solid #DDD !important;
    text-shadow: 0 1px 1px white !important;
    color: #CCC !important;
    cursor: default !important;
    appearance: none !important;
    -webkit-box-shadow: none !important;
            box-shadow: none !important;
    opacity: .8 !important; }
.button-glow {
  -webkit-animation-duration: 3s;
          animation-duration: 3s;
  -webkit-animation-iteration-count: infinite;
          animation-iteration-count: infinite;
  -webkit-animation-name: glowing;
          animation-name: glowing; }
  .button-glow:active, .button-glow.active, .button-glow.is-active {
    -webkit-animation-name: none;
            animation-name: none; }
.button-border, .button-border-thin, .button-border-thick {
  background: none;
  border-width: 2px;
  border-style: solid;
  line-height: 36px; }
  .button-border:hover, .button-border-thin:hover, .button-border-thick:hover {
    background-color: rgba(255, 255, 255, 0.9); }
  .button-border:active, .button-border-thin:active, .button-border-thick:active, .button-border.active, .active.button-border-thin, .active.button-border-thick, .button-border.is-active, .is-active.button-border-thin, .is-active.button-border-thick {
    -webkit-box-shadow: none;
            box-shadow: none;
    text-shadow: none;
    -webkit-transition-property: all;
            transition-property: all;
    -webkit-transition-duration: .3s;
            transition-duration: .3s; }
.button-rounded {
  border-radius: 4px; }
.button-primary,
.button-primary-flat {
  background-color: brown;
  border-color: brown;
  color: #FFF; }
  .button-primary:visited,
  .button-primary-flat:visited {
    color: #FFF; }
  .button-primary:hover, .button-primary:focus,
  .button-primary-flat:hover,
  .button-primary-flat:focus {
    background-color: #4cb0f9;
    border-color: #4cb0f9;
    color: #FFF; }
  .button-primary:active, .button-primary.active, .button-primary.is-active,
  .button-primary-flat:active,
  .button-primary-flat.active,
  .button-primary-flat.is-active {
    background-color: #2798eb;
    border-color: #2798eb;
    color: #0880d7; }
    .button-highlight,
.button-highlight-flat {
  background-color: #FEAE1B;
  border-color: #FEAE1B;
  color: #FFF; }
  .button-highlight:visited,
  .button-highlight-flat:visited {
    color: #FFF; }
  .button-highlight:hover, .button-highlight:focus,
  .button-highlight-flat:hover,
  .button-highlight-flat:focus {
    background-color: #fec04e;
    border-color: #fec04e;
    color: #FFF; }
  .button-highlight:active, .button-highlight.active, .button-highlight.is-active,
  .button-highlight-flat:active,
  .button-highlight-flat.active,
  .button-highlight-flat.is-active {
    background-color: #f3ab26;
    border-color: #f3ab26;
    color: #e59501; }
	
</style>
</head>
<body>
 
 <body>
 
	
		<div class="container demo-1">
			<div class="content">
				<div id="large-header" class="large-header">
					<canvas id="demo-canvas"></canvas>
					<div class="logo_box">
						<h3>物联网监控平台登录</h3>
						<form role="form"  action="UserServlet?action=login" name="f" method="post">
							<div class="用户名：">
								<span class="u_user"></span>
								<input id="username" name="username" class="text" style="color: #000000 !important" type="text" placeholder="请输入用户名">
							</div>
							<div class="密码：">
								<span class="us_uer"></span>
								<input id="password" name="password" class="text" style="color: #000000 !important; position:absolute; z-index:100;"value="" type="password" placeholder="请输入密码">
							</div>
							<br>
							 <br>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;	<div id="LOGIN" ><input type="submit" value="登录" class="button button-glow button-border button-rounded button-primary" style="color: #FFFFFF" >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;			
							 <a href="userRegister.jsp"><input type="button" value="注册" class="button button-glow button-border button-rounded button-primary" style="color: #FFFFFF" ></a></div>
 
			 
						</form>	 
						  <%
            String msg="";
           if(request.getAttribute("msg")!=null){
	         msg=request.getAttribute("msg").toString();
           }
          if(msg.length()>0){
          //显示提示信息
        %>
    <br>
    <div class="alert alert-warning" id="statusbar" role="alert"><%=msg %></div>
<% 
}
%>
						
					</div>
				</div>
			</div>
		</div><!-- /container -->
		<script src="js/TweenLite.min.js"></script>
		<script src="js/EasePack.min.js"></script>
		<script src="js/jquery.js"></script>
		<script src="js/rAF.js"></script>
		<script src="js/demo-1.js"></script>
		<script src="js/vendor/jgrowl/jquery.jgrowl.min.js"></script>
		<script src="js/Longin.js"></script>
		<div style="text-align:center;">
</div>
</body>
</html>
 
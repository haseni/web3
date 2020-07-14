$(document).ready(function(){
	$("#header").html($.ajax({url:"header_admin.jsp",async:false}).responseText);
	$("#footer").html($.ajax({url:"footer.jsp",async:false}).responseText);
	
	//左侧的新闻发布管理
	$("#newsadmin").click(function(){
		$("#useradmin").css("color","blue");
		$("#newsadmin").css("color","red");
		rowsel=0;
		$.ajax({ 
			type: "post", 
			url: "getAdminNews", 
			success: function(data) {
				$('#rtop').html(data);
				$('#rbottom').html("");
				newstypesel();
			} 
		});
	});
	
	//左侧的用户信息管理
	$("#useradmin").click(function(){
		$("#newsadmin").css("color","blue");
		$("#useradmin").css("color","red");
		rowsel=0;
		userlist();
	});

	//添加新闻纪录
	$("#adminNewsAdd").live('click',function(){
		if($("#adminNewsAdd").val()=="添加")
		{
			$("#adminNewsAdd").val("保存");
			$("#newstitle").val("");
			$("#newssource").val("");
			//获得新闻发布的时间
			var time2 = new Date().Format("yyyy-MM-dd hh:mm:ss");
			//alert(time2);
			$("#newstime").val(time2);
			$("#newshits").val("0");
			$("#newsemphsis").val("1");
			$("#newscontent").val("");
			//隐藏新闻评论
			$(".review").hide();
		}
		else
		{
			$("#adminNewsAdd").val("添加");
			$.ajax({ 
				type: "post", 
				url: "adminNewsAddUpdate", 
				data:"mode=1&newstype="+$('#sel_newstype').children('option:selected').val()+"&newstitle="+$('#newstitle').val()+"&newssource="+$('#newssource').val()+"&newstime="+$('#newstime').val()+"&newshits="+$('#newshits').val()+"&newsemphsis="+$('#newsemphsis').val()+"&newscontent="+$('#newscontent').val(),
				success: function(data) {
					//调用servlet adminNewsAddUpdate返回的是newsid,也是表中行的编号
					rowsel=data;
					newstypesel();
				} 
			});
		}
	});

	//更新新闻纪录
	$("#adminNewsUpdate").live('click',function(){
		$.ajax({ 
			type: "post", 
			url: "adminNewsAddUpdate", 
			data:"mode=2&newsid="+rowsel+"&newstype="+$('#sel_newstype').children('option:selected').val()+"&newstitle="+$('#newstitle').val()+"&newssource="+$('#newssource').val()+"&newstime="+$('#newstime').val()+"&newshits="+$('#newshits').val()+"&newsemphsis="+$('#newsemphsis').val()+"&newscontent="+$('#newscontent').val(),
			success: function(data) {
				newstypesel();
			} 
		});
	});

	//删除新闻纪录
	$("#adminNewsDel").live('click',function(){
		if(rowsel>0)
		{
			//删除表中的行
			$("#news"+rowsel).remove();
			//清空新闻的详细显示
			$("#newstitle").val("");
			$("#newssource").val("");
			$("#newstime").val("");
			$("#newshits").val("");
			$("#newsemphsis").val("");
			$("#newscontent").val("");
			//删除新闻记录
			$.ajax({ 
				type: "post", 
				url: "adminNewsDelete", 
				data:"newsid="+rowsel,
				success: function(data) {
					rowsel=0;
				} 
			});
		}
	});

	//查询按钮点击事件
	$("#admin_search_submit").live('click',function(){
		var searcon=$("#admin_search").val();
		$.ajax({ 
			type: "post", 
			url: "adminNewsSearch", 
			data:"searchcontent="+searcon,
			success: function(data) {
				$('#adminNewslist').html(data);
				$('#rbottom').html("");
			} 
		});
	});

	//查询文本框中输入字符事件
	$("#admin_search").live('keyup',function(){
		var searcon=$("#admin_search").val();
		$.ajax({ 
			type: "post", 
			url: "adminNewsSearch", 
			data:"searchcontent="+searcon,
			success: function(data) {
				$('#adminNewslist').html(data);
				$('#rbottom').html("");
			} 
		});
	});
	
	//选择新闻类型列表框的事件
	$('#sel_newstype').live('change',function(){
		newstypesel();
	});

	//添加用户记录
	$("#adminUserAdd").live('click',function(){
		if($("#adminUserAdd").val()=="添加")
		{
			$("#adminUserAdd").val("保存");
			//清空用户信息，部分初始化
			$("#useraccount").val("");
			$("#username").val("");
			$("#userpassword").val("");
			$("#useremail").val("");
			$("#usermobile").val("");
			$("#userqq").val("");
			$("#userprevilege").val("0");
		}
		else
		{
			$("#adminUserAdd").val("添加");
			$.ajax({ 
				type: "post", 
				url: "adminUserAddUpdate", 
				data:"mode=1&useraccount="+$('#useraccount').val()+"&username="+$('#username').val()+"&userpassword="+$('#userpassword').val()+"&useremail="+$('#useremail').val()+"&usermobile="+$('#usermobile').val()+"&userqq="+$('#userqq').val()+"&userprevilege="+$('#userprevilege').val(),
				success: function(data) {
					//调用servlet adminUserAddUpdate返回的是userid,也是表中行的编号
					rowsel=data;
					//更新用户列表信息
					userlist();
				} 
			});
		}
	});

	//更新用户记录
	$("#adminUserUpdate").live('click',function(){
		$.ajax({ 
			type: "post", 
			url: "adminUserAddUpdate", 
			data:"mode=2&userid="+rowsel+"&useraccount="+$('#useraccount').val()+"&username="+$('#username').val()+"&userpassword="+$('#userpassword').val()+"&useremail="+$('#useremail').val()+"&usermobile="+$('#usermobile').val()+"&userqq="+$('#userqq').val()+"&userprevilege="+$('#userprevilege').val(),
			success: function(data) {
				//更新用户列表信息
				userlist();
			} 
		});
	});

	//删除用户记录
	$("#adminUserDel").live('click',function(){
		//alert(rowsel);
		if(rowsel>0)
		{
			//删除表中的行
			$("#user"+rowsel).remove();
			//清空新闻的详细显示
			$("#useraccount").val("");
			$("#username").val("");
			$("#userpassword").val("");
			$("#useremail").val("");
			$("#usermobile").val("");
			$("#userqq").val("");
			$("#userprevilege").val("");
			//删除新闻记录
			$.ajax({ 
				type: "post", 
				url: "adminUserDelete", 
				data:"userid="+rowsel,
				success: function(data) {
					rowsel=0;
				} 
			});
		}
	});
});

//新闻类型选择（国内新闻，国际新闻，军事新闻，体育新闻，科技新闻，社会新闻）
function newstypesel()
{
	var inewstype=$('#sel_newstype').children('option:selected').val();
	var newstype=$('#sel_newstype').find("option:selected").text();
	$.ajax({ 
		type: "post", 
		url: "adminNewstypeSel", 
		//dataType:'json', 
		data:"indexNewstype="+inewstype+"&Newstype="+newstype,
		success: function(data) {
			$('#adminNewslist').html(data);
			if(rowsel>0)
			{
				$("#newslistall tr").css("background-color","white");
				$("#news"+rowsel).css("background-color","lightgreen");
			}
		} 
	});
}

//javascript中时间格式显示函数
Date.prototype.Format = function(fmt)   
{   
  var o = {   
    "M+" : this.getMonth()+1,                 //月份   
    "d+" : this.getDate(),                    //日   
    "h+" : this.getHours(),                   //小时   
    "m+" : this.getMinutes(),                 //分   
    "s+" : this.getSeconds(),                 //秒   
    "q+" : Math.floor((this.getMonth()+3)/3), //季度   
    "S"  : this.getMilliseconds()             //毫秒   
  };   
  if(/(y+)/.test(fmt))   
    fmt=fmt.replace(RegExp.$1, (this.getFullYear()+"").substr(4 - RegExp.$1.length));   
  for(var k in o)   
    if(new RegExp("("+ k +")").test(fmt))   
  fmt = fmt.replace(RegExp.$1, (RegExp.$1.length==1) ? (o[k]) : (("00"+ o[k]).substr((""+ o[k]).length)));   
  return fmt;   
}  

//选择新闻记录
function newsSelect(id)
{
	$("#newslistall tr").css("background-color","white");
	$("#news"+id).css("background-color","lightgreen");
	$('#rbottom').css("padding","20px 0 0 30px");
	$('#rbottom').css("height","auto");
	rowsel=id;
	
	$.ajax({ 
		type: "post", 
		url: "getNewsEditDetail", 
		//dataType:'json', 
		data:"newsid="+id,
		success: function(data) {
			$('#rbottom').html(data);
		} 
	});
}

//删除评论
function reviewDel(id)
{
	$('.review'+id).hide();
	$.ajax({type: "post",url: "reviewDel",data:"reviewid="+id});
}


//选择用户记录
function userSelect(id)
{
	$("#userlistall tr").css("background-color","white");
	$("#user"+id).css("background-color","lightgreen");
	$('#rbottom').css("padding","20px 0 0 30px");
	$('#rbottom').css("height","auto");
	rowsel=id;
	
	$.ajax({ 
		type: "post", 
		url: "getUserEditDetail", 
		//dataType:'json', 
		data:"userid="+id,
		success: function(data) {
			$('#rbottom').html(data);
		} 
	});
}

//显示用户列表
function userlist()
{
	$.ajax({ 
		type: "post", 
		url: "adminGetUserList", 
		success: function(data) {
			$('#rtop').html(data);
			$('#rbottom').html("");
			if(rowsel>0)
			{
				$("#userlistall tr").css("background-color","white");
				$("#user"+rowsel).css("background-color","lightgreen");
				userSelect(rowsel);
			}
		} 
	});
}

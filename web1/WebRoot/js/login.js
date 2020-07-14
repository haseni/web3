  	//window.onload = function()
  	//{	
  	//	var ousername = document.getElementById("username");	
  	//	ousername.focus();		
  	//}
  	
  	function PWEnter()
  	{
    	var keyCode = event.keyCode;    
    	if(keyCode == 13)
    		checkuser();     	
    }
  	
  	function checkuser()
  	{
  		var un_str = username.value;
  		var pw_str = password.value;
  		//alert('ok');
  		var msg_str = "";
  		if(un_str == '' || un_str == null)
  		{
  			msg_str = "璇疯緭鍏ョ敤鎴峰悕锛�";
			//鑾峰彇缃戦〉婊氬姩鐨刲eft鍊�
			var srlLeft=getScrollLeft();
			var LeftDiv=$("#username").offset().left;
			var Left=srlLeft+parseInt(LeftDiv);
			$("#hint").css("left",Left+"px");//璁剧疆鍒楄〃妗嗙殑left鍊�
			
			//鑾峰彇缃戦〉婊氬姩鐨則op鍊�
			var srlTop=getScrollTop();
			var TopDiv=$("#username").offset().top;
			var Top=srlTop+parseInt(TopDiv)+24;
			$("#hint").css("top",Top+"px");//璁剧疆鍒楄〃妗嗙殑top鍊�
			$("#hint").css("height","20px");
			$("#hint").css("width","120px");
			$("#hint").css("color","red");
			$("#hint").css({"background-color":"yellow"});
			$("#hint").css("position","absolute");
			$("#hint").show();
			$('#hint').html(msg_str);

			username.focus();
  			username.select();
  		}
  		else if(pw_str == '' || pw_str == null)
  		{
  			msg_str = "瀵嗙爜涓嶈兘涓虹┖锛�";
			//鑾峰彇缃戦〉婊氬姩鐨刲eft鍊�
			var srlLeft=getScrollLeft();
			var LeftDiv=$("#password").offset().left;
			var Left=srlLeft+parseInt(LeftDiv);
			$("#hint").css("left",Left+"px");//璁剧疆鍒楄〃妗嗙殑left鍊�
			
			//鑾峰彇缃戦〉婊氬姩鐨則op鍊�
			var srlTop=getScrollTop();
			var TopDiv=$("#password").offset().top;
			var Top=srlTop+parseInt(TopDiv)+24;
			$("#hint").css("top",Top+"px");//璁剧疆鍒楄〃妗嗙殑top鍊�
			$("#hint").css("height","20px");
			$("#hint").css("width","120px");
			$("#hint").css("color","red");
			$("#hint").css({"background-color":"yellow"});
			$("#hint").css("position","absolute");
			$("#hint").show();
			$('#hint').html(msg_str);

			password.focus();
  			password.select();
  		}
  		else
  		{
			$.ajax({ 
				type: "post", 
				url: "logincheck", 
				data: "username="+$('#username').val()+"&password="+$('#password').val(), 
				success: function(data) {
					if (data == "userwrong") { 
			  			msg_str = "鐢ㄦ埛鍚嶉敊璇紒";
						//鑾峰彇缃戦〉婊氬姩鐨刲eft鍊�
						var srlLeft=getScrollLeft();
						var LeftDiv=$("#username").offset().left;
						var Left=srlLeft+parseInt(LeftDiv);
						$("#hint").css("left",Left+"px");//璁剧疆鍒楄〃妗嗙殑left鍊�
						
						//鑾峰彇缃戦〉婊氬姩鐨則op鍊�
						var srlTop=getScrollTop();
						var TopDiv=$("#username").offset().top;
						var Top=srlTop+parseInt(TopDiv)+24;
						$("#hint").css("top",Top+"px");//璁剧疆鍒楄〃妗嗙殑top鍊�
						$("#hint").css("height","20px");
						$("#hint").css("width","120px");
						$("#hint").css("color","red");
						$("#hint").css({"background-color":"yellow"});
						$("#hint").css("position","absolute");
						$("#hint").show();
						$('#hint').html(msg_str);

						username.value='';
						password.value='';
						username.focus();
						username.select();
						//window.location.href="elecmap.html"; 
					} 
					else if (data == "passwordwrong") { 
						msg_str = "瀵嗙爜閿欒锛�";
						//鑾峰彇缃戦〉婊氬姩鐨刲eft鍊�
						var srlLeft=getScrollLeft();
						var LeftDiv=$("#password").offset().left;
						var Left=srlLeft+parseInt(LeftDiv);
						$("#hint").css("left",Left+"px");//璁剧疆鍒楄〃妗嗙殑left鍊�
						
						//鑾峰彇缃戦〉婊氬姩鐨則op鍊�
						var srlTop=getScrollTop();
						var TopDiv=$("#password").offset().top;
						var Top=srlTop+parseInt(TopDiv)+24;
						$("#hint").css("top",Top+"px");//璁剧疆鍒楄〃妗嗙殑top鍊�
						$("#hint").css("height","20px");
						$("#hint").css("width","120px");
						$("#hint").css("color","red");
						$("#hint").css({"background-color":"yellow"});
						$("#hint").css("position","absolute");
						$("#hint").show();
						$('#hint').html(msg_str);

						password.value='';
			  			password.focus();
			  			password.select();
					} 
					else
						$("#header").html($.ajax({url:"header_search.jsp",async:false}).responseText);
				} 
			});
		} 
  	}

<%@ page language="java" import="java.util.*,java.sql.*" 
         contentType="text/html; charset=utf-8"%>
<% String path = request.getContextPath();%>
<%
	request.setCharacterEncoding("utf-8");
	if (application.getAttribute("count") == null) {
	    application.setAttribute("count", new Integer(0));
	}
	Integer count = (Integer) application.getAttribute("count");
	application.setAttribute("count", new Integer(count.intValue() + 1));
	count = (Integer) application.getAttribute("count");
	
	String current_user = (String)session.getAttribute("current_user");
	String current_user_name = (String)session.getAttribute("current_user_name");
	if(current_user == null) response.sendRedirect("/15352237/Homepage/login.jsp");
	
	String msg ="";
	String connectString = "jdbc:mysql://172.18.187.234:53306/15352257"
				+ "?autoReconnect=true&useUnicode=true&characterEncoding=UTF-8&&useSSL=false";
    StringBuilder table=new StringBuilder("");
    String blog = "";
	try{	
		Class.forName("com.mysql.jdbc.Driver");
		Connection con=DriverManager.getConnection(connectString, 
		                 "user", "123");
		Statement stmt=con.createStatement();
		Statement stmt1=con.createStatement();
		Statement stmt2=con.createStatement();
		ResultSet rs=stmt.executeQuery("select * from bloginfo order by blogid desc limit 15");
		ResultSet rs_file=stmt1.executeQuery("select * from fileinfo");
		ResultSet rs_user=stmt2.executeQuery("select * from userinfo");
		table.append("<table border=\"0\">");	
		while(rs.next()) {
			rs_file=stmt1.executeQuery("select * from fileinfo where blogid = "+rs.getString("blogid")+";");
			rs_user=stmt2.executeQuery("select * from userinfo where userid = "+rs.getString("userid")+";");
			rs_user.next();

			table.append(String.format("<tr class=\"main_article\"><td class=\"main_articleUser\">%s</td><td class=\"main_articleIn\">%s</td><td class=\"main_articleLink\">", 
					rs_user.getString("username"),rs.getString("blogcontent")));
			while(rs_file.next()){
				String getfilename = rs_file.getString("filename");
				boolean b1=getfilename.endsWith("jpg");
				boolean b2=getfilename.endsWith("png");

				if(b1==true || b2==true){
					table.append(String.format("&emsp;&emsp;<img width=400px src=%s><br>", "/15352237/file/" + getfilename));
				}else{
					table.append(String.format("&emsp;&emsp;<a href=%s style=\"color:rgb(30,145,253)\">%s</a><br>", "/15352237/file/" + getfilename, getfilename));
				}
			}
			table.append(String.format("</td></tr>"));
		}
		table.append("</table>");			
		rs.close();
		stmt.close();
		con.close();
		rs_file.close();
		stmt1.close();
	}
	catch (Exception e){
	  msg = e.getMessage();
	}
%>
<!DOCTYPE  html>
<html lang="zh-cn">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
	<title>Anne的窝 - 嗨狗</title>
	<script type="text/javascript">
		var xhr = new XMLHttpRequest();
		function fileSelected() {
			var msg = "";
			var files = document.getElementById('fileName').files;
			for (var i = 0, file; file = files[i]; i++) {
				var fileSize = 0;
				if (file.size > 1024 * 1024)
					fileSize = (Math.round(file.size*100/(1024*1024))/100).toString()+'MB';
				else
					fileSize = (Math.round(file.size*100/1024)/100).toString()+'KB';
				msg = msg + file.name + ' ' + fileSize + ' ' + file.type + "<br>";
			}
			document.getElementById('msg').innerHTML = msg;
		}
		function uploadFile() {
			var fd = new FormData();
			fd.append("blog", document.getElementById('blog').value); //加入数据域memo
			var files = document.getElementById('fileName').files;
			for (var i = 0, f; f = files[i]; i++) {
				fd.append(f.name, f);
			}
			xhr.upload.addEventListener("progress", uploadProgress, false);
			xhr.addEventListener("load", uploadComplete, false);
			xhr.addEventListener("error", uploadFailed, false);
			//xhr.addEventListener("abort", uploadCanceled, false);
			xhr.open("POST", "fileupload.jsp");
			xhr.send(fd);
			setTimeout('window.location.reload();',500);
		}
		function cancleUploadFile() { xhr.abort();}
		function uploadProgress(evt) {
			if (evt.lengthComputable) {
				var percentComplete = Math.round(evt.loaded * 100 / evt.total);
				document.getElementById('progressNumber').innerHTML = percentComplete.toString()+ '%';
			} else {
				document.getElementById('progressNumber').innerHTML = 'unable to compute';
			}
		}
		function uploadComplete(evt) {alert(evt.target.responseText);}
		function uploadFailed(evt) {alert("上传失败"); }
		function uploadCanceled(evt) {alert("您取消了本次上传.");}	
	</script>

	<style>
		body{background-image: url(image/bg1.jpg);background-size: cover;background-attachment: fixed; overflow-x:hidden;}
		* { margin:0; padding:0;font-size:12px;font-family:微软雅黑;line-height:1.2em}
        a:link, a:visited, a:hover, a:active {text-decoration: none;}
		.wrapper {margin: 0 auto;width: 1000px; }
        li {list-style-type:none}
		
		#header{background: rgba(0,0,0,.8) repeat-x;height: 45px;}
		#h_outer { height: 45px; }
		#nav{position: relative;}
		#nav>li{float:left;padding: 10px 20px;width: 65px;}
		#nav li>a{padding: 10px; color:white;font-size: 18px;}
		#h_image{width: 30px;height: 30px;border-radius:2em/2em;}
		#_image{float:right;width: 15px;height: 15px;border-radius: 2em/2em; position: relative;top:-15px; }
		#h_outer #nav>li:hover{background-color: rgba(0,0,0,1); height: 25px;}
		#h_outer #nav>li:hover .subnav{background-color:rgba(0,0,0,.8); display: block;}
		#nav>li .subnav{position: relative;left: -20px;display:none;top:12px;width: 95px;padding: 5px;z-index: 1;}
		#h_outer #nav .subnav a{display: block; color:white; font-size: 15px;color:rgba(213,213,213,1.00);}
		#h_outer #nav .subnav a:hover{background-color:rgba(0,0,0,.8); }
				
		#main{position: relative;background:rgba(0,0,0,.1) repeat-y;padding: 20px;}
		
		.m_nav{width: 100px;position: fixed;left:16.5%;float: left;}
		.flt2>li a,.flt2>li span{display: block; padding: 20px 5px;color:white;text-align: center;}
		.tags_more_list{display:none;}
		.flt2>li:hover{background: rgba(0,0,0,.3) border-box; height: 50px;}
		
		
		
		#m_inf{width: 280px;height: 400px;background-color: rgba(255,255,255,1);border-radius:2px;position: relative;float: right;top: -10px;}
		#m_image{width: 150px; height: 150px;border-radius:25em/25em;margin: 20px 70px;}
		#m_intro{margin: 20px;}
		h1{color:rgba(0,0,0,1.00);font-size: 30px;font-family: STHeiti;text-align: center;position: relative;top: -20px;}
		#m_intro p{color:rgba(0,0,0,.5);font-size: 15px;text-indent: 2em;font-family: STHeiti;}
		#user a{margin: 15px;color:rgba(30,146,253,1.00);font-size: 15px;font-family: STHeiti;}
		
		#m_head{position: relative;left: 280px; top:400px;float: right;width: 270px; background-color: rgba(255,255,255,1);border-radius:2px;padding: 5px;}
		#m_head a{margin: 10px;color:rgba(30,146,253,1.00);font-size: 10px;font-family: STHeiti;position: relative; top:20px;}
		.write-btn button{width:100px;float: right; padding:3px; background-color:white; border-radius:10px;border: none;color: rgba(30,146,253,.8);font-size: 10px;font-family: STHeiti;position: relative; top:-15px;}
		.write-btn #m-image{position: relative;width: 30px; height: 30px;top: 8px;}
		#m_image2{width: 250px; height: 280px;margin: 10px;}
		
		.m_visitor{padding-left: 10px;}
		.m_allVisitor{padding-left: 0px;}
		
		#m_article2{}
		.widgetbox{background-color: white;border-radius:2px;position: relative;float:right;width:260px;margin: 10px;padding: 15px 10px;top:760px;left: 570px;}
		.title{padding: 10px;}
		.title h3{font-size: 15px;font-family: STHeiti;}
		.widgetbox .widgetoptions { padding: 10px; border: 1px solid #ddd; border-bottom: 0; background: #f7f7f7; position: relative;-moz-box-shadow: inset 0 1px 0 #fff; -webkit-box-shadow: inset 0 1px 0 #fff; box-shadow: inset 0 1px 0 #fff;height: 50px;}
		.widgetbox .widgetoptions a { padding: 5px 15px;margin: 10px; display: inline-block; border: 1px solid #ccc; background: #fff; font-weight: bold; font-size: 11px; color: #333; -moz-border-radius: 2px; -webkit-border-radius: 2px; border-radius: 2px; -moz-box-shadow: 0 1px 0 #fff; -webkit-box-shadow: 0 1px 0 #fff; box-shadow: 0 1px 0 #fff; line-height: 21px;float: left;}
		.widgetbox .widgetoptions a:hover { border: 1px solid #bbb; background-color: #f7f7f7; -moz-box-shadow: inset 0 1px 0 #fff; -webkit-box-shadow: inset 0 1px 0 #fff; box-shadow: inset 0 1px 0 #fff;}
		.userlistwidget { border: 1px solid #ddd; }
		.userlistwidget ul { list-style: none; }
		.userlistwidget ul li { font-size: 11px; line-height: 18px; border-bottom: 1px dashed #ddd; padding: 10px; }
		.userlistwidget ul li:last-child { border-bottom: 0; }
		.userlistwidget ul li .avatar { float: left; margin-right: 10px; padding: 2px; border: 1px solid #eee; }
		.userlistwidget ul li a { font-weight:  bold; }      
		.userlistwidget .more { display: block; text-align: center; background: #eee; color: rgba(30,146,253,1.00); padding: 5px 0; font-size: 10px; text-transform: uppercase; font-weight: bold; border-top: 1px solid #ddd; }
		.userlistwidget .more:hover { text-decoration: none; background: #e7e7e7; }
		
		#m_article3{background-color: white;border-radius:2px;position: relative;float:right;width:260px;margin: 10px;padding: 15px 10px;left:10px;top:750px;}
		.m3_title{padding: 10px;border-bottom: 1px solid #ddd;  }
		.m3_title h3{font-size: 15px;font-family: STHeiti;}
		.m3_nav li {margin: 20px 10px;}
		.m3_nav li a{color: #676666}
		
		#m_arti{background-color: white;border-radius:2px;position: absolute;width:570px;float: right;margin: 10px;padding: 5px 20px;top:-1px;left: 112px;}
		#container p {float: right;padding: 5px;}
		.subfile{background-color:rgba(183,237,244,.3);border: none;border-radius:2px;width:50px;height: 23px;font-family: STHeiti;}
		
		#m_article{border: none;position: relative;left: 90px;top:-260px;width: 570px;z-index: 0;}
		.main_article{display: block;background-color: white;border-radius:2px;border: none;padding: 20px;margin: 10px;width: 570px;}
		.main_article td{display: block;padding: 10px;}
		.main_articleUser{text-align: left;font-weight: bold;color:rgba(30,146,253,1.00);font-size: 15px;font-family: STHeiti;}
		.main_articleIn{text-indent: 2em;}
		.main_articleLink{padding: 5px; display: block ;border:2px solid white; overflow: hidden;}
		.main_articleLink>.m_image3{position: relative; width: 100px;height: 50px; display: block ;border:2px solid white;  }
		
		#footer{position: relative;margin:0 auto;width: 100%;bottom: 0px;height: 200px;background:rgba(255,255,255,1) repeat-y;}
		#footer p{color:black;font-size: 50px;font-family: STHeiti;position:relative;left:-35%;top:20px;}
		#end .copyright {padding: 10px;margin: 0px;color: black;font-size: 12px;text-align: center;word-spacing: 3px;position:relative; top:1550%;left:13%;}
		#end{width: 100%;height: 10px;background-color: rgb(255,255,255);}
    </style>
</head>
<body>
    <div id="container">
        <div id="header" >
        	<div id="h_outer" class="wrapper">
        		<ul id="nav">
            		<li><a href="main.html" class="nav_hover">首页</a></li>
            		<li><a href="#">问答</a></li>
            		<li><a href="logo.html" class="nav_hover">周边</a></li>
            		<li><a href="#">结伴</a></li>
            		<li><a href="#">小组</a></li>
            		<li><a href="#">积分</a></li>
            		<li><a href="#">更多&nbsp;<img id="_image" src="image/select.jpg"></a>
            			<ul class="subnav">
                    		<li><a href="#">照片PK</a></li>
                    		<li><a href="#">旅行电台</a></li>
                    		<li><a href="#">分歧终端机</a></li>
                    		<li><a href="#">VIP</a></li>
                    		<li><a href="logo.html">嗨狗</a></li>
                		</ul>
                	</li>
                	<li><a href="#">消息&nbsp;<img id="_image" src="image/select.jpg"></a>
            			<ul class="subnav">
                    		<li><a href="#">私信</a></li>
                    		<li><a href="#">文章消息</a></li>
                    		<li><a href="#">小组消息</a></li>
                    		<li><a href="#">问答消息</a></li>
                    		<li><a href="#">系统通知</a></li>
                		</ul>
                	</li>
                	<li><a href="#"><img id="h_image" src="image/1.jpg"></a>
            			<ul class="subnav">
                    		<li><a href="#">我的狗窝</a></li>
                    		<li><a href="#">我的关注</a></li>
                    		<li><a href="#">我的好友</a></li>
                    		<li><a href="#">我的问答</a></li>
                    		<li><a href="#">我的游记</a></li>
                    		<li><a href="#">我的足迹</a></li>
                    		<li><a href="#">我的收藏</a></li>
                    		<li><a href="#">我的订单</a></li>
                    		<li><a href="#">设置</a></li>
                    		<li><a href="login.jsp">退出</a></li>
                		</ul>
                	</li>
        		</ul>
    		</div>
            
        </div>
        
        <div id="main" class="wrapper">
        
        	<div class="m_nav">
				<ul class="flt2">
					<li class="on"><a class="tags_link" href="" title="我的窝">我的窝</a></li>
					<li><a class="tags_link" href="" title="我的游记">我的游记</a></li>
					<li><a class="tags_link" href="" title="我的问答">我的问答</a></li>
					<li id="_j_pathnav"><a class="tags_link" href="" title="我的足迹">我的足迹</a></li>
					<li><a class="tags_link" href="" title="我的点评">我的点评</a></li>
					<li><a class="tags_link" href="" title="我的结伴">我的结伴</a></li>
					<li class="more mygroup_tips">
						<span class="tags_link" role="button" title="更多" style="cursor:default">我喜欢你</span>
					</li>
				</ul>
    		</div>
        	
        	<div id="m_inf">
        		<a class="m_image" href="#"><img id="m_image" src="image/1.jpg"></a>
        		<div id="m_intro">
        			<h1 class="m_name" href="#"><%=current_user_name %></h1>
        			<p class="m_message" href="#">我是小仙女啊，又瘦又美宇宙无敌最可爱的不得了不得了的小宝贝，喜欢吃喜欢浪不喜欢打代码，喜欢看帅哥，没错我男朋友叫郑业成，不是第一眼帅哥但是越看越帅越看越帅，猫系男友！</p>
        		</div>
        		<div id="user">
        			<a class="m_visitor" href="#">最新访客</a>
        			<a class="m_allVisitor" href="#">累计访问：<%=count.intValue()%></a>
        		</div>
        	</div>
        	
        	<div id="m_head">
        		<p class="m_head" href="#"><img id="m_image2" src="image/7.jpg"></p>
        		<a class="m_head" href="#">0游记</a>
        		<a class="m_head" href="#">0阅读</a>
        		<a class="m_head" href="#">0访问</a>
        		<a class="write-btn" href="#">
                    <button><img id="m-image" src="image/write.jpg">写游记</button>
                </a>
        	</div>
        	
        	<div id="m_article2">        
    			<div class="widgetbox">
                	<div class="title">
                    	<h3>好友状态</h3>
                    </div>
					<div class="widgetoptions">
						<div class="right"><a href="#">查找用户</a></div>
						<a href="#">添加用户</a>
					</div>
					<div class="widgetcontent userlistwidget nopadding">
						<ul>
							<li>
								<div class="avatar"><img alt="" src="image/avatar1.png" /></div>
								<div class="info">
									<a href="">Squint</a> <br />
									Front-End Engineer <br /> 18 minutes ago
								</div><!--info-->
							 </li>
							 <li>
								<div class="avatar"><img alt="" src="image/avatar2.png" /></div>
								<div class="info">
									<a href="">Eunice</a> <br />
									Architectural Designer <br /> 18 minutes ago
								</div><!--info-->
							 </li>
							 <li>
								 <div class="avatar"><img alt="" src="image/avatar3.png" /></div>
								 <div class="info">
									<a href="">Captain Gutt</a> <br />
									Software Engineer <br /> 18 minutes ago
								</div><!--info-->
							 </li>
							 <li>
								<div class="avatar"><img alt="" src="image/avatar4.png" /></div>
								<div class="info">
									<a href="">Flynn</a> <br />
									Accounting Manager <br /> 18 minutes ago
								</div><!--info-->
							 </li>
						 </ul>
						 <a class="more" href="#">查看更多用户</a>
					 </div>
				</div>                     
			</div>
           
           <div id="m_article3">
				<div class="m3_title"><h3>热门话题</h3></div>
				<div class="m3_nav">
					<ul class="entrylist">
						<li><a href="#">#胡一天 新晋男神#</a></li>
						<li><a href="#">#江辰 陈小希#</a></li>
						<li><a href="#">#致我们单纯的小美好#</a></li>
						<li><a href="#">#木瓜炖雪梨#</a></li>
						<li><a href="#">#全都不如你#</a></li>
						<li><a href="#">#林杨 小太阳#</a></li>
					</ul>                        
				</div>
			</div>
        	
        	<div id="m_article">
            	<ul class="mm_nav">
                 	<%=table%>
                </ul>
            </div>
            
            <div id="m_arti">
        		<caption><a class="ma_image" ><img id="ma_image" src="image/form.jpg"></a></caption>
        		<form action="article.jsp" method="post" name="f">
					<p><textarea rows="7" cols="80" name="blog" id="blog"></textarea></p><br/>
					<p>
						<input class="choosefile" type="file" name="fileName" id="fileName" multiple onchange="fileSelected();" style="width: 200px" />
						<input class="subfile" type="submit" onclick="uploadFile()" value="上传" />
					</p>
				</form>
        	</div>

        </div>

        <div id="footer" class="wrapper">
            <p>Higo! 带你去看全世界</p>
            
        <div id="end">
			<div class="copyright">小组版权所有 COPYRIGHT©1999-2013 , Higo!</div>
		</div>
        </div>
        
    </div>
    <jsp:include page="chat.jsp"></jsp:include>
</body>
</html>




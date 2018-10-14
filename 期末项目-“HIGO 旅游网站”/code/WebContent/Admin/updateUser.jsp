<%@ page language="java" import="java.util.*,java.sql.*"
  contentType="text/html; charset=utf-8"%>
<% request.setCharacterEncoding("utf-8");
  String msg = "";
  String connectString = "jdbc:mysql://172.18.187.234:53306/15352257"
        + "?autoReconnect=true&useUnicode=true&characterEncoding=UTF-8&&useSSL=false";
  String user="user"; String pwd="123";
  String userid = request.getParameter("userid");
  String username = request.getParameter("username");
  String password = request.getParameter("password");
  if(username == null) username ="";
  if(password == null) password ="";
  if(request.getMethod().equalsIgnoreCase("post")){
    Class.forName("com.mysql.jdbc.Driver");
    Connection con = DriverManager.getConnection(connectString,user, pwd);
    Statement stmt = con.createStatement();
    try{ String fmt="UPDATE userinfo SET username = '%s', password = '%s' WHERE userid = '%s'";
      String sql = String.format(fmt,username,password,userid);
      int cnt = stmt.executeUpdate(sql);
      if(cnt>0) msg = "修改成功!";
      stmt.close(); con.close();
    }catch (Exception e){
      msg = e.getMessage();
    }
  }
%>
<!DOCTYPE html>
<html >
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>添加用户</title>
    <link rel="stylesheet" href="css/style.default.css" type="text/css" />
    <link rel="stylesheet" href="css/login.css" type="text/css" />
    <style>
    	#button1{
    	width:80px;
    	background-color:rgba(56,74,151,.8);
    	color:white;
    	font-size:18px;
    	height:45px;
    	display:inline-block;
    	border:none;
    	}
    	button{
    	width:80px;
    	background-color:rgba(56,74,151,.8);
    	color:white;
    	font-size:18px;
    	height:45px;
    	display:inline-block;
    	border:none;
    	}
    </style>
</head>
<body class="withvernav">
    <div class="bodywrapper">
        <div class="topheader">
            <div class="left">
                <h1 class="logo">Higo.<span>Admin</span></h1>
                
                <br clear="all" />
                
            </div>
            
            <div class="right">
                <div class="userinfo">
                	<img src="images/thumbs/avatar.png" alt="" />
                    <span>管理员</span>
                </div>
            </div>
        </div>
        
        <div class="header">
        	<ul class="headermenu">
            	<li class="current"><a href="console.html"><span class="icon icon-flatscreen"></span>首页</a></li>
                <li><a href=""><span class="icon icon-pencil"></span>博客管理</a></li>
                <li><a href=""><span class="icon icon-message"></span>查看消息</a></li>
                <li><a href=""><span class="icon icon-chart"></span>统计报表</a></li>
            </ul>
            
           <div class="headerwidget">
            	<div class="earnings">
                	<div class="one_half">
                    	<h4>访问总数</h4>
                        <h2>230,000,000</h2>
                    </div><!--one_half-->
                </div>
            </div>
            
        </div>
	</div>
    <div class="login-box" id="_j_login_box">
		    <div class="container">
			    <div class="inner">
			      <h1>修改用户记录</h1>
			      <form action="updateUser.jsp?userid=<%=userid%>" method="post" name="f">
			        	<input id="username" name="username" type="text" value="<%=username%>"><br/><br/>
			        	<input id="password" name="password" type="text" value="<%=password%>"><br/><br/>
			        	<input type="submit" name="sub" value="修改" id="button1"/>
			        	<input type="reset" name="rset" value="清空" id="button1"/>
			        	<a href='queryUser.jsp'><input type="button" name="return" value="返回" id="button1"></a>
			      </form>
			      <%=msg%>
			    </div>
		    </div>
    </div>

</body>
</html>
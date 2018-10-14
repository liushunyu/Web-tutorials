<%@ page language="java" import="java.util.*,java.sql.*"
  contentType="text/html; charset=utf-8"%>
<% request.setCharacterEncoding("utf-8");
  String msg = "";
  String connectString = "jdbc:mysql://172.18.187.234:53306/15352257"
        + "?autoReconnect=true&useUnicode=true&characterEncoding=UTF-8&&useSSL=false";
  String user="user"; String pwd="123";
  String blogid = request.getParameter("blogid");
  String userid = request.getParameter("userid");
  String herf_url = "";
  if(userid == null) herf_url = "queryBlog.jsp";
  else herf_url = "browseBlog.jsp?userid=" + userid;
  Class.forName("com.mysql.jdbc.Driver");
  Connection con = DriverManager.getConnection(connectString,user, pwd);
  Statement stmt = con.createStatement();
  try{ String fmt="DELETE FROM bloginfo WHERE blogid = '%s'";
    String sql = String.format(fmt,blogid);
    int cnt = stmt.executeUpdate(sql);
    stmt.close(); con.close();
    if(cnt>0) msg = "Delete Success!";
    else msg = "Delete Fail!";
  }catch (Exception e){
    msg = e.getMessage();
  }
  
%>
<!DOCTYPE html>
<html >
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>删除</title>
    <link rel="stylesheet" href="css/style.default.css" type="text/css" />
	<style type="text/css">
		.container{  
		 font-size:35px;
		 margin:100px auto; 
		 width:500px;  
		 text-align:center;  
		} 
		button{
			position: relative; 
			left:15px;
			margin-top:10px;
			margin-bottom: 20px;
			width:260px; 
			padding:8px; 
			background-color:rgba(56,74,151,.8); 
			border-radius:5px;
			border: none;
			color:white;
			font-size: 20px;
			font-weight: bolder;
		}
	</style>
</head>
<body class="withvernav">
    <div class="bodywrapper">
        <div class="topheader">
            <div class="left">
                <h1 class="logo">Higo.<span>Admin</span></h1>
                <span class="slogan">后台管理系统</span>
                
                <div class="search">
                	<form action="" method="post">
                    	<input type="text" name="keyword" id="keyword" value="请输入" />
                        <button class="submitbutton"></button>
                    </form>
                </div>
                
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
	<div class="container">
	  <div class="container">
	    <%=msg%>
	  </div>
		  <a href="queryBlog.jsp"><button>返 回</button></a>
	</div>
</html>




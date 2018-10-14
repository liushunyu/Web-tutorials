<%@ page language="java" import="java.util.*,java.sql.*"
	contentType="text/html; charset=utf-8"%>
<%
	request.setCharacterEncoding("utf-8");
	String msg = "";
	String userid = request.getParameter("userid");
	String username = "";
	String connectString = "jdbc:mysql://172.18.187.234:53306/15352257"
			+ "?autoReconnect=true&useUnicode=true&characterEncoding=UTF-8&&useSSL=false";
	String user = "user";
	String pwd = "123";
	StringBuilder table = new StringBuilder();
	try {
		Class.forName("com.mysql.jdbc.Driver");
		Connection con = DriverManager.getConnection(connectString, user, pwd);
		Statement stmt = con.createStatement();
		String sql = String.format("select * from bloginfo WHERE userid = '%s'", userid);
		ResultSet rs = stmt.executeQuery(sql);
		table.append("<table><tr><th style=\"width:50px;\">博客id</th><th>博客内容</th>" + "<th style=\"width:50px;\">-</th></tr>");
		while (rs.next()) {
			table.append(String.format("<tr><td>%s</td><td>%s</td><td>%s</td></tr>", rs.getString("blogid"),
					rs.getString("blogcontent"), "<a href='deleteBlog.jsp?blogid=" + rs.getString("blogid")
							+ "&userid=" + userid + "'>删除</a>"));
		}
		table.append("</table>");

		sql = String.format("select * from userinfo WHERE userid = '%s'", userid);
		rs = stmt.executeQuery(sql);
		rs.next();
		username = rs.getString("username");
		rs.close();
		stmt.close();
		con.close();
	} catch (Exception e) {
		msg = e.getMessage();
	}
%>
<!DOCTYPE html>
<html >
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>浏览博客</title>
    <link rel="stylesheet" href="css/style.default.css" type="text/css" />
	<style>
	  table{
	    border-collapse: collapse;
	    border: none;
	    width: 500px;
	  }
	  td,th{
	    border: solid grey 1px;
	    margin: 0 0 0 0;
	    padding: 5px 5px 5px 5px;
	  } 
	  a:link,a:visited {
	    color:blue
	  }
	  .container{
	    margin:0 auto;
	    width:500px;
	    text-align:center;
	  }
	  h1{
	  	margin:40px;
	  	height:60px;
	  }
		button{
			width:150px;
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
        <div class="inner">
			<div class="container">
				<h1><%=username%>博客
				</h1>
				<%=table%>
				<br>
				<div>
					<a href="queryUserBlog.jsp?userid=<%=userid%>"><button>查询</button></a>
					<a href="browseUser.jsp"><button>返回</button></a>
				</div>
				<br><br>
				<%=msg%>
				<br>
			</div>
        </div>
    </div>
</html>


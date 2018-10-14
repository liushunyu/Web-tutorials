<%@ page language="java" import="java.util.*,java.sql.*" 
         contentType="text/html; charset=utf-8"
%><%
  request.setCharacterEncoding("utf-8");
  String msg ="";
  Integer pgno = 0; //当前页号
  Integer pgcnt = 8; //每页行数
  String param = request.getParameter("pgno");
  if(param != null && !param.isEmpty()){
  pgno = Integer.parseInt(param);
  }
  param = request.getParameter("pgcnt");
  if(param != null && !param.isEmpty()){
  pgcnt = Integer.parseInt(param);
  }
  int pgprev = (pgno>0)?pgno-1:0;
  int pgnext = pgno+1;
  String connectString = "jdbc:mysql://172.18.187.234:53306/15352257"
        + "?autoReconnect=true&useUnicode=true&characterEncoding=UTF-8&&useSSL=false";
  String user="user";
  String pwd="123";
  StringBuilder table = new StringBuilder();
  try{
    Class.forName("com.mysql.jdbc.Driver");
    Connection con=DriverManager.getConnection(connectString, user, pwd);
    Statement stmt=con.createStatement();
    String sql=String.format("select * from userinfo limit %d,%d",
      pgno*pgcnt,pgcnt);
    ResultSet rs=stmt.executeQuery(sql);
    table.append("<table><tr><th>用户id</th><th>用户名</th><th>密码</th>"+
      "<th>操作</th></tr>");
    while(rs.next()) {
      table.append(String.format(
          "<tr><td>%s</td><td>%s</td><td>%s</td><td>%s %s %s</td></tr>",
          rs.getString("userid"),rs.getString("username"),rs.getString("password"),
          "<a href='updateUser.jsp?userid="+rs.getString("userid")
            +"&username="+rs.getString("username")
            +"&password="+rs.getString("password")
            +"'>修改</a>",
          "<a href='deleteUser.jsp?userid="+rs.getString("userid")+"'>删除</a>",
          "<a href='browseBlog.jsp?userid="+rs.getString("userid")+"'>博客</a>"
        )
      );
    }
    table.append("</table>");
    rs.close(); stmt.close(); con.close();
  }
  catch (Exception e){
    msg = e.getMessage();
  }
%>
<!DOCTYPE html>
<html >
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>浏览用户</title>
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
		    <h1>浏览用户名单</h1>
		    <%=table%>
		    <br><br> 
		    <div style="float:left">
		      <a href="addUser.jsp">新增</a>&nbsp;&nbsp;&nbsp;<a href="queryUser.jsp">查询用户</a>
		      &nbsp;&nbsp;&nbsp;<a href="queryBlog.jsp">查询博客</a>
		    </div>
		    <div style="float:right">
		      <a href="browseUser.jsp?pgno=<%=pgprev%>&pgcnt=<%=pgcnt%>">上一页</a>
		      <a href="browseUser.jsp?pgno=<%=pgnext%>&pgcnt=<%=pgcnt%>">下一页</a>
		      <a href="console.html">返回</a>
		    </div>
		    <br><br>
		    <%=msg%><br><br>
		    </div>
        </div>
    </div>
</html>
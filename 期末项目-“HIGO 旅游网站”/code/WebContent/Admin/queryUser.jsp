<%@ page language="java" import="java.util.*,java.sql.*" 
         contentType="text/html; charset=utf-8"
%><%
  request.setCharacterEncoding("utf-8");
  String msg ="";
  String connectString = "jdbc:mysql://172.18.187.234:53306/15352257"
        + "?autoReconnect=true&useUnicode=true&characterEncoding=UTF-8&&useSSL=false";
  StringBuilder table=new StringBuilder("");
  String query = request.getParameter("query");
  if(query==null) query = "";
  try{
    Class.forName("com.mysql.jdbc.Driver");
    Connection con=DriverManager.getConnection(connectString, 
                   "user", "123");
    Statement stmt=con.createStatement();
    ResultSet rs = stmt.executeQuery("select * from userinfo");

    if(request.getMethod().equalsIgnoreCase("post")){
      if(query.length() == 0){
        rs = stmt.executeQuery("select * from userinfo;");
      }else {
        rs = stmt.executeQuery("SELECT * FROM userinfo WHERE userid LIKE"
                + "\"%" + query + "%\" OR username LIKE"
                + "\"%" + query + "%\";");  
      }
    }

    table.append("<table><tr><th>用户id</th><th>用户名</th><th>密码</th>"+"<th>操作</th></tr>");
    while(rs.next()) {
       table.append(String.format(
          "<tr><td>%s</td><td>%s</td><td>%s</td><td>%s %s</td></tr>",
          rs.getString("userid"),rs.getString("username"),rs.getString("password"),
          "<a href='updateUser.jsp?userid="+rs.getString("userid")
            +"&username="+rs.getString("username")
            +"&password="+rs.getString("password")
            +"'>修改</a>",
          "<a href='deleteUser.jsp?userid="+rs.getString("userid")+"'>删除</a>")
      );  
    }
    table.append("</table>");
    rs.close();
    stmt.close();
    con.close();
  }
  catch (Exception e){
    msg = e.getMessage();
  }
%>


<!DOCTYPE html>
<html >
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>用户查询</title>
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
	          padding: 5px 5px 5px 5px 
	  }
	  .c1 {
	    width:100px
	  }
	  .c2 {
	    width:200px
	  }
	  a:link,a:visited {
	    color:blue
	  }
	
	.container{  
	 margin:100px auto; 
	 width:500px;  
	 text-align:center;  
	} 
	.container h1{
	 font-size:35px;
	 height:60px;
	 }
	.container input{
	border: 0; padding: 10px 8px 11px 8px; float: left; color: #4a5b78; -moz-border-radius: 2px 0 0 2px; margin: 0 auto;
	-webkit-border-radius: 2px 0 0 2px; border-radius: 2px 0 0 2px; border-bottom: 1px solid #445775; width: 300px; font-style: italic;
	-moz-box-shadow: inset 1px 1px 2px #2b384e; -webkit-box-shadow: inset 1px 1px 2px #2b384e; box-shadow: inset 1px 1px 2px #2b384e;
	}
	.container button{
		position: relative; 
		margin-top:-5px;
		margin-bottom: 20px;
		width:150px; 
		padding:8px; 
		background-color:rgba(56,74,151,.8); 
		border-radius:5px;
		border: none;
		color:white;
		font-size: 20px;
		font-weight: bolder;
		height:40px;
	}
	.container .button #1{
		float:left;
	}
	.container .button #2{
		float:right;
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
		   <h1>查询用户名单</h1> 
		 	<form action="queryUser.jsp" method="post" name="f">
		   		<input id="query" name="query" type="text" value="<%=query%>">
		   		<button class="submitbutton">查 询</button>
		   		<br/><br/>
		 	</form> 
		   <%=table%>
		   <%=msg%>
		   <br><br>  
		   <div id="button">
		   	  <a href="addUser.jsp"><button id="1">新增</button></a>
		      <a href="console.html"><button id="2">返回</button></a>
		   </div>   
		</div>
    </div>
</body>
</html>


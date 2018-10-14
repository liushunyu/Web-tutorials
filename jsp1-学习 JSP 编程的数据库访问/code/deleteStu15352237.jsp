<%@ page language="java" import="java.util.*,java.sql.*"
  contentType="text/html; charset=utf-8"%>
<% request.setCharacterEncoding("utf-8");
  String msg = "";
  String connectString = "jdbc:mysql://172.18.187.230:53306/teaching1"
        + "?autoReconnect=true&useUnicode=true&characterEncoding=UTF-8&&useSSL=false";
  String user="user"; String pwd="123";
  String pid = request.getParameter("pid");
  
  Class.forName("com.mysql.jdbc.Driver");
  Connection con = DriverManager.getConnection(connectString,user, pwd);
  Statement stmt = con.createStatement();
  try{ String fmt="DELETE FROM stu WHERE id = '%s'";
    String sql = String.format(fmt,pid);
    int cnt = stmt.executeUpdate(sql);
    stmt.close(); con.close();
    if(cnt>0) msg = "Delete Success!";
    else msg = "Delete Fail!";
  }catch (Exception e){
    msg = e.getMessage();
  }
  
%>
<!DOCTYPE HTML>
<head>
   <title>删除学生记录</title>
   <style>
     a:link,a:visited {color:blue}
     .container{  
      margin:0 auto; 
      width:500px;  
      text-align:center;  
     } 
   </style>
</head>
<body>
  <div class="container">
    <h1>删除学生记录</h1>
    <%=msg%>
    <br/><br/>
    <a href='browseStu215352237.jsp'>返回</a>
  </div>
</body>
</html>

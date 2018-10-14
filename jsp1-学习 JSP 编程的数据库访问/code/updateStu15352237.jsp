<%@ page language="java" import="java.util.*,java.sql.*"
  contentType="text/html; charset=utf-8"%>
<% request.setCharacterEncoding("utf-8");
  String msg = "";
  String connectString = "jdbc:mysql://172.18.187.230:53306/teaching1"
        + "?autoReconnect=true&useUnicode=true&characterEncoding=UTF-8&&useSSL=false";
  String user="user"; String pwd="123";
  String num = request.getParameter("num");
  String name = request.getParameter("name");
  String pid = request.getParameter("pid");
  if(request.getMethod().equalsIgnoreCase("post")){
    Class.forName("com.mysql.jdbc.Driver");
    Connection con = DriverManager.getConnection(connectString,user, pwd);
    Statement stmt = con.createStatement();
    try{ String fmt="UPDATE stu SET num = '%s', name = '%s' WHERE id = '%s'";
      String sql = String.format(fmt,num,name,pid);
      int cnt = stmt.executeUpdate(sql);
      if(cnt>0) msg = "修改成功!";
      stmt.close(); con.close();
    }catch (Exception e){
      msg = e.getMessage();
    }
  }
%>
<!DOCTYPE HTML>
<html>
  <head>
  <title>新增学生记录</title>
  <style> a:link,a:visited {color:blue;}
  .container{
    margin:0 auto;
    width:500px;
    text-align:center;
  }
  </style>
</head>
  <body>
    <div class="container">
      <h1>修改学生记录</h1>
      <form action="updateStu15352237.jsp?pid=<%=pid%>" method="post" name="f">
        学号:<input id="num" name="num" type="text" value="<%=num%>"><br/><br/>
        姓名:<input id="name" type="text" name="name" value="<%=name%>"><br/><br/>
        <input type="submit" name="sub" value="修改">
        <input type="reset" name="rset" value="清空"/><br/><br/>
      </form>
      <%=msg%>
      <a href='browseStu215352237.jsp'>返回</a>
    </div>
  </body>
</html>
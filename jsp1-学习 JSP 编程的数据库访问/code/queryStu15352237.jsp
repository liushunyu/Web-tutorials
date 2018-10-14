<%@ page language="java" import="java.util.*,java.sql.*" 
         contentType="text/html; charset=utf-8"
%><%
  request.setCharacterEncoding("utf-8");
  String msg ="";
  String connectString = "jdbc:mysql://172.18.187.230:53306/teaching1"
        + "?autoReconnect=true&useUnicode=true&characterEncoding=UTF-8&&useSSL=false";
  StringBuilder table=new StringBuilder("");
  String query = request.getParameter("query");
  if(query==null) query = "";
  try{
    Class.forName("com.mysql.jdbc.Driver");
    Connection con=DriverManager.getConnection(connectString, 
                   "user", "123");
    Statement stmt=con.createStatement();
    ResultSet rs = stmt.executeQuery("select * from stu");

    if(request.getMethod().equalsIgnoreCase("post")){
      if(query.length() == 0){
        rs = stmt.executeQuery("select * from stu");
      }else {
        rs = stmt.executeQuery("SELECT * FROM stu WHERE num LIKE"
          + "\"%" + query + "%\" OR name LIKE"
          + "\"%" + query + "%\";");  
      }
    }

    table.append("<table><tr><th>id</th><th>学号</th><th>姓名</th>"+"<th>-</th></tr>");
    while(rs.next()) {
       table.append(String.format(
          "<tr><td>%s</td><td>%s</td><td>%s</td><td>%s %s</td></tr>",
          rs.getString("id"),rs.getString("num"),rs.getString("name"),
          "<a href='updateStu15352237.jsp?pid="+rs.getString("id")
            +"&num="+rs.getString("num")
            +"&name="+rs.getString("name")
            +"'>修改</a>",
          "<a href='deleteStu15352237.jsp?pid="+rs.getString("id")+"'>删除</a>")
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

<!DOCTYPE HTML>
<html>
<head>
<title>查询学生名单</title>
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
    margin:0 auto;   
    width:500px;  
    text-align:center;  
  }  
  p {text-align:left;  }
</style>
</head>
<body>
  <div class="container">
    <h1>查询学生名单</h1> 
  <form action="queryStu15352237.jsp" method="post" name="f">
    输入查询:<input id="query" name="query" type="text" value="<%=query%>">
    <input type="submit" name="sub" value="查询">
    <br/><br/>
  </form> 
    <%=table%>
    <br><br>  
    <div style="float:left">
       <a href="addStu15352237.jsp">新增</a>&nbsp;&nbsp;<a href="browseStu215352237.jsp">返回</a>
    </div>
    <br><br>
    <br><br>     
  </div>
</body>
</html>


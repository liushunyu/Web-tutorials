<%@ page language="java" import="java.util.*,java.sql.*" 
         contentType="text/html; charset=utf-8"
%><%
	request.setCharacterEncoding("utf-8");
  String connectString = "jdbc:mysql://172.18.187.233:53306/teaching" + "?autoReconnect=true&useUnicode=true&characterEncoding=UTF-8&&useSSL=false";
  StringBuilder table=new StringBuilder("");
  try{
    Class.forName("com.mysql.jdbc.Driver");
    Connection con = DriverManager.getConnection(connectString, "user", "123");
    Statement stmt = con.createStatement();
    ResultSet rs = stmt.executeQuery(String.format("select * from stu where id = '%s'", request.getParameter("id")));
    if(rs.next()){
      out.println("id:" + rs.getString("id") + "<br>");
      out.println("num:" + rs.getString("num") + "<br>");
      out.println("name:" + rs.getString("name") + "<br>");
    }else{
      out.println("[无]");
    }
    rs.close();
    stmt.close();
    con.close();
  }
  catch (Exception e){
    System.out.println(e.getMessage());
  }
%>

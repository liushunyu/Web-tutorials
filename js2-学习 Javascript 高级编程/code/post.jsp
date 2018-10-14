<%@ page language="java" import="java.util.*,java.sql.*" 
         contentType="text/html; charset=utf-8"
%><%request.setCharacterEncoding("utf-8");
  String connectString = "jdbc:mysql://172.18.187.233:53306/teaching" + "?autoReconnect=true&useUnicode=true&characterEncoding=UTF-8&&useSSL=false";
  StringBuilder table=new StringBuilder("");
  try{
    Class.forName("com.mysql.jdbc.Driver");
    Connection con = DriverManager.getConnection(connectString, "user", "123");
    Statement stmt = con.createStatement();
    int rs = stmt.executeUpdate(String.format("UPDATE stu SET name = '%s' WHERE id = '%s'", request.getParameter("name"), request.getParameter("id")));
    if(rs>0) out.println("修改成功!");
    else out.println("修改失败!");
    stmt.close();
    con.close();
  }
  catch (Exception e){
    System.out.println(e.getMessage());
  }
%>




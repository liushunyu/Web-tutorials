<%@ page language="java" import="java.util.*,java.io.*" pageEncoding="utf-8" 
contentType="text/html;charset=utf-8"%>
<%
  String id= session.getId();
%>
<!DOCTYPE  html>
<html  lang="zh-cn">
<head>
<title>Session Y</title>
</head>
<body>
  <h1>Session Y</h1>
  <p>session ID：<%=id%></p> 
  <%
    Enumeration enums=session.getAttributeNames(); 
    while(enums.hasMoreElements()){
      String name=(String)enums.nextElement();
      out.println(name+"："+session.getAttribute(name)+"<br/>");
    }
  %>
  <p><a href="X.jsp">X.jsp</a></p>
  <p><a href="Z.jsp">Z.jsp</a></p>
</body>
</html>


<%@ page language="java" 
import="java.util.*,java.io.*" 
import="java.util.Date" 
import="java.text.*"
pageEncoding="utf-8" 
contentType="text/html;charset=utf-8"%>
<%
  String id= session.getId();
  session.setAttribute("course", "移动Web应用设计 --- " + new Date());
%>
<!DOCTYPE  html>
<html  lang="zh-cn">
<head>
<title>Session X</title>
</head>
<body>
  <h1>Session X</h1>  
  <p>session ID:<%=id%></p>
  <p><a href="Y.jsp">Y.jsp</a></p>
  <p><a href="Z.jsp">Z.jsp</a></p>
</body>
</html>


<%@ page language="java" import="java.util.*" 
         contentType="text/html; charset=utf-8"%>
<%request.setCharacterEncoding("utf-8");%>
<!DOCTYPE HTML>
<html>
  <head>
    <title>注册输入显示</title>
  </head>  
  <body>
    id: <%=request.getParameter("id")%><br>
    同学名: <%=request.getParameter("name")%><br>
    密码: <%=request.getParameter("password") %><br>
    校区: <%=request.getParameter("campus") %><br>
    社团: 
      <%   
        String[] groups=request.getParameterValues("club");
        out.print(Arrays.toString(groups));
      %><br>
    年级: <%=request.getParameter("grade") %><br>
    说明: <%=request.getParameter("demo") %><br>
    submit1:<%=request.getParameter("submit1") %><br>
    submit2:<%
      if(request.getParameter("submit2")!=null){
        response.sendRedirect("http://172.18.187.11/main.htm");
      } else{
        out.print("null");
      }
    %><br>
  </body>
</html>


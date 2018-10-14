<%@ page language="java" import="java.util.*" 
         contentType="text/html; charset=utf-8"%>
<%request.setCharacterEncoding("utf-8");
  String name="wang";
  String password="";
  String campus="";
  String grade="";
  String club="";
  String demo="";
  if(request.getMethod().equalsIgnoreCase("post")){
    name = request.getParameter("name") + "*";
    password = request.getParameter("password");
    campus = request.getParameter("campus");
    grade = request.getParameter("grade");
    club = Arrays.toString(request.getParameterValues("club"));
    demo = request.getParameter("demo") + "*";
  }
%>
<!DOCTYPE HTML>
<html>
  <head>
    <title>用户注册</title>
  </head>  
  <body>
    <form action="register3.jsp" method="post">
      <p><input style="visibility: hidden;" name="id" type="text" value="12345"></p>
      <p>同学名：<input name="name" type="text" value="<%=name%>"></p>
      <p>密码：<input name="password" type="password" value="<%=password%>"></p>
      <p>校区：
        南校区<input type="radio" name="campus" value="south" <%=campus.equals("south")?"checked":""%>>
        东校区<input type="radio" name="campus" value="east" <%=campus.equals("east")?"checked":""%>>
        北校区<input type="radio" name="campus" value="north" <%=campus.equals("north")?"checked":""%>>
        珠海校区<input type="radio" name="campus" value="zhuhai" <%=campus.equals("zhuhai")?"checked":""%>>
        深圳校区<input type="radio" name="campus" value="shenzhen" <%=campus.equals("shenzhen")?"checked":""%>></p>
      <p>年级：<select name="grade">
          <option value="freshman" <%=grade.equals("freshman")?"selected":""%>>大学一年级</option>
          <option value="sophomore" <%=grade.equals("sophomore")?"selected":""%>>大学二年级</option>
          <option value="junior" <%=grade.equals("junior")?"selected":""%>>大学三年级</option>
          <option value="senior" <%=grade.equals("senior")?"selected":""%>>大学四年级</option></p>
        </select>
      <p>社团：
        舞蹈队<input name="club" type="checkbox" value="dance" <%=club.indexOf("dance")>=0?"checked":""%>>
        摄影<input name="club" type="checkbox" value="photo" <%=club.indexOf("photo")>=0?"checked":""%>>
        篮球<input name="club" type="checkbox" value="basketball" <%=club.indexOf("basketball")>=0?"checked":""%>></p>
      <p><label style="vertical-align:top;">说明：</label>
        <textarea rows="6" cols="36" name="demo"><%=demo%></textarea></p>
      <p><input name="submit1" type="submit" value="保存">
      <input name="submit2" type="submit" value="退出"></p>
    </form>
  </body>
</html>
<%@ page language="java" import="java.util.*" 
         contentType="text/html; charset=utf-8"%>
<%request.setCharacterEncoding("utf-8");%>
<!DOCTYPE HTML>
<html>
  <head>
    <title>用户注册</title>
  </head>  
  <body>
    <form action="register2.jsp" method="post">
      <p><input style="visibility: hidden;" name="id" type="text" value="12345"></p>
      <p>同学名：<input name="name" type="text" value="张三"></p>
      <p>密码：<input name="password" type="password" value="12345678"></p>
      <p>校区：
        南校区<input type="radio" name="campus" value="south">
        东校区<input type="radio" name="campus" value="east" checked>
        北校区<input type="radio" name="campus" value="north">
        珠海校区<input type="radio" name="campus" value="zhuhai">
        深圳校区<input type="radio" name="campus" value="shenzhen "></p>
      <p>年级：<select name="grade">
          <option value="freshman">大学一年级</option>
          <option value="sophomore">大学二年级</option>
          <option value="junior" selected>大学三年级</option>
          <option value="senior">大学四年级</option></p>
        </select>
      <p>社团：
        舞蹈队<input name="club" type="checkbox" value="dance">
        摄影<input name="club" type="checkbox" value="photo" checked>
        篮球<input name="club" type="checkbox" value="basketball" checked></p>
      <p><label style="vertical-align:top;">说明：</label>
        <textarea rows="6" cols="36" name="demo">我学过Web程序设计</textarea></p>
      <p><input name="submit1" type="submit" value="保存">
      <input name="submit2" type="submit" value="退出"></p>
    </form>
  </body>
</html>


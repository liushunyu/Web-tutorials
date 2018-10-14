<%@page language="java" import="java.util.*" contentType="text/html; charset=utf-8"%>
<!DOCTYPEHTML>
<html>
  <head>
    <title>实现文件上传</title>
  </head>
  <body>
    <form name="fileupload" action="fileUpload15352237.jsp" method="POST" 
        enctype="multipart/form-data">
      <p>id：<input type="text" name="id" size=24 value="888"></p>
      <p>文件名：<input type="file" name="file" size=24></p>
      <p><input type=submit name="submit" value="OK"></p>
    </form>
  </body>
</html>


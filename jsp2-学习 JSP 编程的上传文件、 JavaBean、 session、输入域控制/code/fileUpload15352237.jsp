<%@page pageEncoding="utf-8" contentType="text/html; charset=utf-8"%>
<%@page import="java.io.*,java.util.*,org.apache.commons.io.*"%>
<%@page import="org.apache.commons.fileupload.*"%>
<%@page import="org.apache.commons.fileupload.disk.*"%>
<%@page import="org.apache.commons.fileupload.servlet.*"%>
<html><head><title>文件传输例子</title></head>
  <body><%request.setCharacterEncoding("utf-8");%>
    <%
      String name = "";
      boolean isMultipart = ServletFileUpload.isMultipartContent(request);
      if(isMultipart) {
        FileItemFactory factory = new DiskFileItemFactory();
        ServletFileUpload upload = new ServletFileUpload(factory);
        List items = upload.parseRequest(request);
        FileItem fi_id = (FileItem) items.get(0);
        FileItem fi = (FileItem) items.get(1);
        DiskFileItem dfi = (DiskFileItem) fi;
        if(!dfi.getName().trim().equals("")) {
          out.print("文件被上传到服务上的实际位置：");
          name = fi_id.getString("utf-8") + "_"
            + FilenameUtils.getName(dfi.getName());
          String fileName=application.getRealPath("/jsp2/files")//文件夹绝对路径
            + System.getProperty("file.separator")//获取操作系统文件分隔符
            + name;//文件名
          out.print(new File(fileName).getAbsolutePath());
          dfi.write(new File(fileName));
        }
      }
    %>
  <br>
  <a href='<%="/jsp2/files/"+name%>'><%=name%></a>
  </body>
</html>


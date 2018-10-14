<%@ page pageEncoding="utf-8" contentType="text/html; charset=utf-8"%>
<%@ page import="java.io.*"%> 
<%@ page import="java.util.*"%>
<%@ page import="org.apache.commons.io.*"%>
<%@ page import="java.util.*,java.sql.*"%>
<%@ page import="org.apache.commons.fileupload.*"%>
<%@ page import="org.apache.commons.fileupload.disk.*"%>
<%@ page import="org.apache.commons.fileupload.servlet.*"%>
<html>
<head><title>文件传输例子</title></head>
<body>
<% String path = request.getContextPath();%>
<%
	request.setCharacterEncoding("utf-8");
	out.println("输入域:");	
	String msg ="";
	String connectString = "jdbc:mysql://172.18.187.234:53306/15352257"
					+ "?autoReconnect=true&useUnicode=true&characterEncoding=UTF-8&&useSSL=false";
	try{
		Class.forName("com.mysql.jdbc.Driver");
		Connection con=DriverManager.getConnection(connectString, "user", "123");
		Statement stmt=con.createStatement();
		ResultSet rs = stmt.executeQuery("select * from userinfo;");
		boolean isMultipart = ServletFileUpload.isMultipartContent(request);//检查表单中是否包含文件	
		if (isMultipart) {
			FileItemFactory factory = new DiskFileItemFactory();
			ServletFileUpload upload = new ServletFileUpload(factory);
			List items = upload.parseRequest(request);	
			for (int i = 0; i < items.size(); i++) {
				FileItem fi = (FileItem) items.get(i);
				if (fi.isFormField()) {//如果是表单字段
					out.println("输入域:"+fi.getFieldName()+" 取值:"+fi.getString("utf-8"));	
					String userid= (String)session.getAttribute("current_user");
					String blog = fi.getString("utf-8");
					String fmt="insert into bloginfo(blogcontent,userid) values('%s', '%s')";
					String sql = String.format(fmt,blog,userid);
					int cnt = stmt.executeUpdate(sql);	
					
				}
				else {//如果是文件
					DiskFileItem dfi = (DiskFileItem) fi;
					if (!dfi.getName().trim().equals("")) {//getName()返回文件名称或空串
						out.println("文件被上传到服务上的实际位置： ");
						String fileName = application.getRealPath("/file")
										+ System.getProperty("file.separator")
										+ FilenameUtils.getName(dfi.getName());
						out.println(new File(fileName).getAbsolutePath());
						dfi.write(new File(fileName));

						rs=stmt.executeQuery("select max(blogid) from bloginfo;");	
						rs.next();
						String fmt="insert into fileinfo(blogid,filename) values('%s', '%s')";
						String sql = String.format(fmt,rs.getString("max(blogid)"),FilenameUtils.getName(dfi.getName()));
						int cnt = stmt.executeUpdate(sql);	
					}
				}
			} //for
		}//if
		rs.close();
		stmt.close();
		con.close();
	}catch (Exception e){
	  msg = e.getMessage();
	}	
%>
</body>
</html>
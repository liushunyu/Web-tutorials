<%@ page language="java" import="java.util.*,java.sql.*"
		 contentType="text/html; charset=utf-8"%>
<% request.setCharacterEncoding("utf-8");
String msg = "";
String connectString = "jdbc:mysql://172.18.187.234:53306/15352257"
				+ "?autoReconnect=true&useUnicode=true&characterEncoding=UTF-8&&useSSL=false";
String user="user"; String pwd="123";
String username = request.getParameter("username");
if(username==null) username="";
String password = request.getParameter("pass");
if(request.getMethod().equalsIgnoreCase("post")){
	Class.forName("com.mysql.jdbc.Driver");
	Connection con = DriverManager.getConnection(connectString,user, pwd);
	Statement stmt = con.createStatement();
	if(username=="") msg = "输入用户名为空，请重新输入！";
	else if(password=="") msg = "密码输入为空，请重新输入！";
	else{
		try{ String fmt="select * from userinfo where username='%s'";
			String sql = String.format(fmt,username);
			ResultSet rs=stmt.executeQuery(sql);
			if(rs.next()) {
			    if(rs.getString("password").equals(password)){
			    	session.setAttribute("current_user",rs.getString("userid"));
			    	session.setAttribute("current_user_name",rs.getString("username"));
			        if(username.equals("admin")) response.sendRedirect("/15352237/Admin/console.html");
			        else response.sendRedirect("/15352237/Homepage/main.html");
			    }
			    else msg = "密码输入错误，请重新输入！";	
			}
			else msg = "用户名不存在，请注册！";
			stmt.close(); con.close();
			}catch (Exception e){
			msg = e.getMessage();
			}	
	}
}
%>
<!DOCTYPE HTML><html><head><title>登录账号</title>
	<style> 
		body{background-image: url(image/bg5.jpg) ;background-size: cover;background-attachment: fixed; height:1000px;}
		h1{text-align: center;font-family: STHeiti;font-size: 80px;}
		h1 a{ text-decoration:none;color:rgba(255,255,255,0.95);}
		p{position: relative; top:5px;text-align: center;color:rgba(255,255,255,0.95);font-family: STHeiti;font-size: 30px;}
		
		.wrapper{margin: auto;width:300px; padding-top:26px; background-color:rgba(166,166,166,.8); border-radius:5px; 
				box-shadow:0 3px 3px rgba(0,0,0,.4);}
		input{position: relative; left:7px;margin:5px;width:250px; padding:10px; background-color:rgba(255,255,255,.8); border-radius:5px;}
		
		.form-link{position: relative; left:180px;}
		.form-link a{color:aquamarine;text-decoration:none;font-size: 5px;}
		.form-link span{color:white;text-decoration:none;font-size: 5px;}
		
		.submit-btn button{position: relative; left:15px;margin-top:10px;margin-bottom: -10px;width:270px; padding:8px; 
						background-color:rgba(146,250,212,.8); border-radius:5px;border: none;color:white;font-size: 20px;font-weight: bolder;}
		.form-wrong a{
			position: relative; left:50px;top:-20px;color:white;text-decoration:none;font-size: 15px;
		}	
		input:focus {border: 2px solid #B0E0E6; box-shadow: 0px 0px 2px #B0E0E6;}
		.submit-btn button:hover{cursor:pointer;}					
	</style>
</head>
<body>
	<h1><a href='main.html'>Higo</a></h1>
    <p>你好，未来路          --嗨狗</p>
    <div class="wrapper">
       <div class="container">
           <div class="signup-forms flip">
           		<div class="login-box" id="_j_login_box">
                   <div class="inner">
           
				<form action="login.jsp" method="post" name="f" enctype="application/x-www-form-urlencoded">
				<div class="form-field" >
					<input id="username" name="username" type="text" placeholder="您的帐号名称" value=<%=username%> >
				</div>
				
				<div class="form-field" type="hidden">
					<input name="pass" type="password" maxlength=10 placeholder="您的密码">
				</div>
				
				<div class="form-link">
					<a href="register.jsp"><font size="2">去注册</font></a>
					<span>|</span>
					<a href="main.html"><font size="2">回主页</font></a>
				</div>

				<div class="submit-btn" type="submit" name="sub" value="登录">
                	<button>登录</button>
                </div>
                
				<br></br>
			</form>
			<div class="form-wrong">
				<a><%=msg%></a>
			</div>
					</div>
               </div>
           </div>
       </div>
   </div>
</body>
</html>
import java.sql.*;
import java.util.*;
import java.io.*;  
import java.io.InputStreamReader;  

public class DeleteStu{
	static private Connection conn;
	static int cnt = 0;
	public static void main(String args[]) {
		System.out.println("输入学号或姓名（部分匹配）以删除记录，输入以-开头数字则按id删除，exit或空行退出.\n");
		int i = 1;
		while(true){
			System.out.print(i + "> ");
			i++;

			Scanner sc = new Scanner(System.in);
			String str = new String();
			str = sc.nextLine();
			if (connect()) {
				if(str.length() == 0 || str.equals("exit")){
					break;
				}
				else{
					boolean rs;
					if(str.charAt(0) == '-'){
						rs = executeUpdate("DELETE FROM stu WHERE id="
							+ str.substring(1,str.length()) + ";");
					}
					else{
						rs = executeUpdate("DELETE FROM stu WHERE num like \'%"
							+ str+"%\' OR name LIKE \'%" + str + "%\';");
					}	
				} 

				System.out.println();
			} 
			else System.out.println("Connect Error!");			
		}

	}
	private static boolean connect() {
		String connectString = "jdbc:mysql://172.18.187.230:53306/teaching13"
				+ "?autoReconnect=true&useUnicode=true&characterEncoding=UTF-8&&useSSL=false";
		try {
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(connectString, "user", "123");
			return true;
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return false;
	}
	
	private static boolean executeUpdate(String sqlSentence) {
		Statement stat;
		cnt=-1;
		try {
			stat = conn.createStatement(); // 根据连接获取一个执行sql语句的对象
			cnt = stat.executeUpdate(sqlSentence); //执行sql语句,返回所影响行记录的个数
		}
		catch (Exception e) {
			System.out.println(e.getMessage());
		}
		if(cnt >= 0) System.out.println(cnt+"个记录被删除.");
		else System.out.println("0个记录被删除.");
		return (cnt >= 0);
	}
}

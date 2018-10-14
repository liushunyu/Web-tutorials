import java.sql.*;
import java.util.*;
import java.io.*;  
import java.io.InputStreamReader;  

public class QueryStu {
	static private Connection conn;
	static int cnt = 0;
	public static void main(String args[]) {
		System.out.println("��ѯѧ�ź�����������ƥ�䣩����-��ͷ��ѯid��*������м�¼��exit������˳�.\n");

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
				else if(str.charAt(0) == '-'){
					ResultSet rs = executeQuery("SELECT * FROM stu WHERE id="
						+ str.substring(1, str.length()) + ";");		
					showStudents(rs);			
				} 
				else if(str.charAt(0) == '*'){
					ResultSet rs = executeQuery("SELECT * FROM stu;");	
					showStudents(rs);
				}
				else if(str.charAt(0) >= '0' && str.charAt(0) <= '9'){
					ResultSet rs = executeQuery("SELECT * FROM stu WHERE num LIKE"
						+ "\"%" + str + "%\";");	
					showStudents(rs);
				}
				else if((str.charAt(0) >= 'a' && str.charAt(0) <= 'z')|| (str.charAt(0) >= 'A' && str.charAt(0) <= 'Z')){
					ResultSet rs = executeQuery("SELECT * FROM stu WHERE name LIKE"
						+ "\"%" + str + "%\";");	
					showStudents(rs);
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
	
	static private ResultSet executeQuery(String sqlSentence) {
		Statement stat;
		ResultSet rs = null;
		    
		try {
			stat = conn.createStatement();      
			rs = stat.executeQuery(sqlSentence); 
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return rs;
	}

	private static void showStudents(ResultSet rs){
		try {
			int cnt = 0;
			while(rs.next()){
				System.out.println(rs.getString("id") + " "
					+ rs.getString("num") + " "
			 		+ rs.getString("name"));		
				cnt++;
			}
		 	System.out.println("[" + cnt + "����¼]");
		}
		catch (Exception e) {
			System.out.println(e.getMessage());
		}
	}
}
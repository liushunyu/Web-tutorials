import java.sql.*;
import java.util.*;
import java.io.*;  
import java.io.InputStreamReader;  

public class DeleteStu{
	static private Connection conn;
	static int cnt = 0;
	public static void main(String args[]) {
		System.out.println("����ѧ�Ż�����������ƥ�䣩��ɾ����¼��������-��ͷ������idɾ����exit������˳�.\n");
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
			stat = conn.createStatement(); // �������ӻ�ȡһ��ִ��sql���Ķ���
			cnt = stat.executeUpdate(sqlSentence); //ִ��sql���,������Ӱ���м�¼�ĸ���
		}
		catch (Exception e) {
			System.out.println(e.getMessage());
		}
		if(cnt >= 0) System.out.println(cnt+"����¼��ɾ��.");
		else System.out.println("0����¼��ɾ��.");
		return (cnt >= 0);
	}
}

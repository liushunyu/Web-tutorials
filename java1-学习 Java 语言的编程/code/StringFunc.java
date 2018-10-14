import java.util.Arrays;
import java.lang.*;
public class StringFunc{
    final static String s="�ⵣ������ʿ����û�бⵣ�����ⵣû�а�ʿ��ⵣҪ���ڰ����,���ƫ���ñⵣ���ڰ���ϡ�";
    public static void main(String args[]){
    	String tem_1 = s.substring(4,7);
    	System.out.println(tem_1);

    	int pos = s.indexOf("�ⵣ");
    	while(pos!=-1){
    		System.out.print(pos + " ");
    		pos = s.indexOf("�ⵣ",pos+1);
    	}
    	System.out.println();

    	String tem_2 ="";
    	long startTime=System.currentTimeMillis();
    	for(int i=0;i<10000;i++){
			tem_2 = tem_2+s;
    	}
    	long endTime=System.currentTimeMillis();
    	System.out.print("�ַ�����ӵ�ʱ�䣺"+(endTime-startTime)+"ms  ");
    	System.out.println("�ַ������ȣ�"+tem_2.length());

    	StringBuilder tem_3=new StringBuilder("");
    	startTime=System.currentTimeMillis();
    	for(int i=0;i<10000;i++){
			tem_3.append(s);
    	}
    	endTime=System.currentTimeMillis();
    	System.out.print("StringBuilder��ʱ�䣺"+(endTime-startTime)+"ms  ");
    	System.out.println("�ַ������ȣ�"+tem_3.length());
    }
}




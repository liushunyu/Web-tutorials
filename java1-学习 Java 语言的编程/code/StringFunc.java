import java.util.Arrays;
import java.lang.*;
public class StringFunc{
    final static String s="扁担长，板凳宽，板凳没有扁担长，扁担没有板凳宽。扁担要绑在板凳上,板凳偏不让扁担绑在板凳上。";
    public static void main(String args[]){
    	String tem_1 = s.substring(4,7);
    	System.out.println(tem_1);

    	int pos = s.indexOf("扁担");
    	while(pos!=-1){
    		System.out.print(pos + " ");
    		pos = s.indexOf("扁担",pos+1);
    	}
    	System.out.println();

    	String tem_2 ="";
    	long startTime=System.currentTimeMillis();
    	for(int i=0;i<10000;i++){
			tem_2 = tem_2+s;
    	}
    	long endTime=System.currentTimeMillis();
    	System.out.print("字符串相加的时间："+(endTime-startTime)+"ms  ");
    	System.out.println("字符串长度："+tem_2.length());

    	StringBuilder tem_3=new StringBuilder("");
    	startTime=System.currentTimeMillis();
    	for(int i=0;i<10000;i++){
			tem_3.append(s);
    	}
    	endTime=System.currentTimeMillis();
    	System.out.print("StringBuilder的时间："+(endTime-startTime)+"ms  ");
    	System.out.println("字符串长度："+tem_3.length());
    }
}




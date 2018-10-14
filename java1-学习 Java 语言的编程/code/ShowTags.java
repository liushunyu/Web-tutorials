import java.io.*;
import java.util.*;

class ShowTags{
  public static void main(String[] args)throws IOException{
     String content = readFile(".\\grassland.htm");
     int len = content.length();  
     HashMap<String, Integer> map = new HashMap<String, Integer>();
     for(int i = 0; i < len; i++){
     	if(content.charAt(i) == '<' && content.charAt(i+1) != ' '){
     		for(int j = i+2; j < len; j++){
     			if(content.charAt(j) == '>' || content.charAt(j) == ' '){
     				String sub_str = content.substring(i+1,j).toUpperCase();
 					Integer value = map.get(sub_str);
     				if (value==null){
     					map.put(sub_str, 1);
     				}else{
     					map.put(sub_str, value+1);
     				}
     				i = j;
     				break;
     			}else if(content.charAt(j) == '<'){
     				i = j - 1;
     				break;
     			}
     		}
     	}
     }
     int i = 0;
     for(String key:map.keySet()){
     	System.out.print("<"+key+">:"+map.get(key)+"	");
     	i++;
     	if(i == 3){
     		System.out.println();
     		i = 0;
     	}
     }
  }

  static String readFile(String fileName) throws IOException{
    	StringBuilder sb = new StringBuilder("");
	int c1;
	FileInputStream f1= new FileInputStream(fileName);		
	InputStreamReader in = new InputStreamReader(f1, "gbk");

	while ((c1 = in.read()) != -1) {
	  sb.append((char) c1);
	}        
        return sb.toString();
  }
}
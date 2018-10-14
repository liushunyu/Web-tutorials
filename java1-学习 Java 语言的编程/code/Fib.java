import java.util.*;

public class Fib{
    public static void main(String args[]){
        long fib0=0,fib1=1,fib2=1;
    	ArrayList<Long> fib = new ArrayList<Long>();
    	fib.add(fib0);
    	fib.add(fib1);

    	int i = 0;
    	long tem_fib = 0;
    	while(fib.get(i) < Long.MAX_VALUE / 2){
    		tem_fib = fib.get(i) + fib.get(i + 1);
    		fib.add(tem_fib);
    		i++;
    	}
    	System.out.println("max fib(Long):"+fib.get(fib.size()-1)+" count: " + fib.size());
    	
    	double ratios[] = new double[fib.size()];
    	ratios[0] = 0;
    	ratios[1] = 1;
    	i = 2;
    	Iterator<Long> it = fib.iterator();
    	it.next();
    	long tem1 = it.next();
    	while(it.hasNext()) {
    		long tem2 = it.next();
    		ratios[i] = (double)tem1 / (double)tem2;
    		tem1 = tem2;
    		i++;
    	}

    	i = 0;
    	for(double ratio:ratios){
    		System.out.print(ratio + "	");
    		i++;
    		if(i == 3){
    			System.out.println();
    			i = 0;
    		}
    	}
    }
}
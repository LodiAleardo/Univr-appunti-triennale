import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.List;
import java.util.StringTokenizer;

import org.apache.http.HttpResponse;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.impl.client.DefaultHttpClient;


public class RESTCall {

    public RESTCall() {

    }
    
    public Definition[] list_organisms(){
        StringBuffer buff= call("http://rest.kegg.jp/list/organism");
        
        List l= new ArrayList();
        
        StringTokenizer st= new StringTokenizer(buff.toString(),"\n");
        while(st.hasMoreElements()){
            Definition d= new Definition();
            String line = st.nextToken();
            StringTokenizer line_st= new StringTokenizer(line,"\t");
            d.setEntry_id(line_st.nextToken());
            d.setOrg(line_st.nextToken());
            d.setDefinition(line_st.nextToken());
            l.add(d);
        }
        
        Definition d[]= new Definition[l.size()];
        l.toArray(d);
        return d;
    }

    private StringBuffer call(String url) {
        StringBuffer buffer = new StringBuffer();
        String line="";
        
        DefaultHttpClient client = new DefaultHttpClient();
        HttpPost post = new HttpPost(url);
        // StringEntity input = new StringEntity("product");
        // post.setEntity(input);
        HttpResponse response;
        try {
            response = client.execute(post);
            
            BufferedReader rd = new BufferedReader(new InputStreamReader(response.getEntity().getContent()));
            while ((line = rd.readLine()) != null) {
                buffer.append(line);
                buffer.append("\n");
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        return buffer;

    }

    //http://rest.kegg.jp/list/ljo/ec:2.7.1.6
    public String[] get_genes_by_enzyme(String enzima, String entry_id) {
        System.out.println("http://rest.kegg.jp/link/"+entry_id+"/"+enzima);
        StringBuffer buff= call("http://rest.kegg.jp/link/"+entry_id+"/"+enzima);
        
        List l= new ArrayList();
        
        StringTokenizer st= new StringTokenizer(buff.toString(),"\n");
        while(st.hasMoreElements()){
            String line = st.nextToken();
                        String elem = line.substring(line.indexOf("\t")+1);
            l.add(elem);
        }
        
        
        String d[]= new String[l.size()];
        l.toArray(d);
        return d;
    }

    public String bget(String genoma) {
        System.out.println("http://rest.kegg.jp/get/"+genoma);
        StringBuffer buff= call("http://rest.kegg.jp/get/"+genoma);
    
        return buff.toString();
    }

}


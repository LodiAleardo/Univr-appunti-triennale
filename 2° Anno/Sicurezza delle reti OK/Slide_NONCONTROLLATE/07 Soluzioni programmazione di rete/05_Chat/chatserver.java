import java.net.*;
import java.io.*;
import java.util.Vector;

class ChatServer {
  public static void main(String args[]) throws Exception {
  
    ServerSocket connection = new ServerSocket( 1025 );

    while(true) new server(connection.accept());
  }  
}

class server implements Runnable {
  Socket s;
  static Vector outVector = new Vector();
 
  server(Socket s) { 
    this.s = s;
    new Thread(this).start();
  }

  public void run() {
    String from;
    BufferedReader in=null;
    PrintStream    out=null;

    try {
         in = new BufferedReader(
                 new InputStreamReader(s.getInputStream()));  
        out = new PrintStream(s.getOutputStream());
                    
         outVector.addElement(out);     

         System.out.println("Connected");     
         while( (from=in.readLine()) != null && !from.equals("")) {
           System.out.println( from );

           for(int i=0; i<outVector.size(); i++)    
             ((PrintStream)outVector.elementAt(i)).print(from + "\r\n");
         }
         s.close();                                 
     }
     catch(IOException e) {}
     System.out.println("Disconnected");
                    
     outVector.removeElement(out);  
   }
}

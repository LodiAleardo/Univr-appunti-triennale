import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.net.ServerSocket;
import java.net.Socket;

public class WebServer {

  public static void main (String args[]) {
    ServerSocket serverSocket;
		int count = 0;

    try {
      // creazione ServerSocket sulla porta 80
      serverSocket = new ServerSocket(8081);
    } catch (Exception e) {
      System.out.println("Error: " + e);
      return;
    }

		while(true){
    System.out.println("in attesa di connessione");
      try {
        Socket clientSocket = serverSocket.accept();
				// client connesso
        System.out.println("Client connesso, invio dati");
        PrintWriter outWriter = new PrintWriter(clientSocket.getOutputStream());


        // invio della risposta, header HTTP
        outWriter.println("HTTP/1.1 200 OK");
        outWriter.println("Content-Type: text/html");
        outWriter.println("Server: My Web Server");
        // questa linea bianca delimita la fine dell'header
        outWriter.println("");
        // invio del contenuto della pagina
        outWriter.println("<HTML><BODY><H1>Hello world!</H1><P>Page visited " + count + " times.</P></BODY></HTML>");
				count++;
        outWriter.flush();
        clientSocket.close();
      } catch (Exception e) {
        System.out.println("Error: " + e);
      }
		}
  }

}

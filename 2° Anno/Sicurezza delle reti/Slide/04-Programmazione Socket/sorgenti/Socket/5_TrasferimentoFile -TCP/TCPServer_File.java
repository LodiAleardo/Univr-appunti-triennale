//SERVER trasferimento file
import java.io.*;
import java.net.*;

class FileServer {
    public static void main(String args[]) {

        // sockets
        ServerSocket serverSocket = null;
        Socket clientSocket = null;

        // streams
        BufferedReader reader = null ;
        PrintStream outStream = null ;
        BufferedReader fileReader = null;

        try {
            System.err.println("Creazione ServerSocket");
            serverSocket = new ServerSocket(11111);

            System.out.println("Attesa connessione...");
            clientSocket = serverSocket.accept();
            System.out.println("Connessione da " + clientSocket);

            // apertura streams per lettura e invio della stringa verso il client
            reader = new BufferedReader(new InputStreamReader(clientSocket.getInputStream()));
            BufferedOutputStream outBuffer = new BufferedOutputStream(clientSocket.getOutputStream());
		    outStream = new PrintStream(outBuffer, true);

            // ricezione nome file dal client
            String fileName = new String(reader.readLine());
            System.out.println("File richiesto dal client: " + fileName);

            // invio del file al client
            fileReader  = new BufferedReader(new InputStreamReader(new FileInputStream(fileName)));

            String tmp = null;
            while ((tmp = fileReader.readLine()) != null)
                outStream.println(tmp);
            
            // chiusura streams
            serverSocket.close();
            clientSocket.close();
            reader.close();
            outStream.close();
            fileReader.close();
        } catch(IOException e){
              System.out.println("Errore: " + e);
        }
    }
}

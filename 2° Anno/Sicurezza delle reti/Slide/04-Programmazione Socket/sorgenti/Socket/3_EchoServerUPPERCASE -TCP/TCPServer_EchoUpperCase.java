// SERVER EchoServer Uppercase

import java.io.*;
import java.net.*;

class EchoServer {
    public static void main(String args[]) {

        // sockets
        ServerSocket serverSocket = null;
        Socket clientSocket = null;

        // streams
        BufferedReader reader = null;
        PrintWriter outWriter = null;
        
        try {
            System.out.print("Creazione ServerSocket...");
            serverSocket = new ServerSocket(11111);

            System.out.print("Attesa connessione...");
            clientSocket = serverSocket.accept();
            System.out.println("Conness. da " + clientSocket);

            // apertura streams
            reader = new BufferedReader(new InputStreamReader(clientSocket.getInputStream()));
            outWriter = new PrintWriter(clientSocket.getOutputStream());
            
            while(true)
            {
                // ricezione della stringa
                String text = new String(reader.readLine());
                System.out.println(text);
            
                // invio della nuova stringa in maiuscolo
                outWriter.println(text.toUpperCase());
                outWriter.flush();
                
                if (text.equals("stop"))
                    break;
            }
            
            // chiusura streams
            reader.close();
            outWriter.close();
            clientSocket.close();
            serverSocket.close();
        } catch (Exception e) {
            System.out.println("Errore: " + e);
        }
    }
}

//CLIENT EchoServer Uppercase

import java.io.*;
import java.net.*;

class EchoClient {
    public static void main(String args[]) {

        // socket
        Socket clientSocket = null;
        
        // streams
        BufferedReader reader = null;
        PrintWriter outWriter = null;

        try {
            clientSocket = new Socket("localhost", 11111); // IP e porta del server
            System.out.println("Socket creata: " + clientSocket);

            // apertura streams
            reader = new BufferedReader(new InputStreamReader(clientSocket.getInputStream()));
            outWriter = new PrintWriter(clientSocket.getOutputStream());
            BufferedReader inFromUser = new BufferedReader(new InputStreamReader(System.in));

            while(true)
            {
                String line = null;
                
                System.out.println("Inserisci il testo da inviare");
                line = inFromUser.readLine();
                
                // Invio messaggio
                outWriter.println(line);
                outWriter.flush();

                // ricezione risposta dal server
                line = reader.readLine();
                System.out.println("Ricevuto: " + line);
                if (line.equals("STOP"))
                    break;
            }
            
                        
            // chiusura streams
            clientSocket.close();
            outWriter.close();
            reader.close();
        } catch (IOException e) {
            System.err.println(e.getMessage());
        }
    }
}

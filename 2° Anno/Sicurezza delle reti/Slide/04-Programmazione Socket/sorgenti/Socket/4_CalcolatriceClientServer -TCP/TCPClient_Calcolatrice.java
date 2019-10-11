// CLIENT Calcolatrice Client/Server

import java.io.*;
import java.net.*;

class CalcClient {
    public static void main(String args[]) {
    try {
        // socket
        Socket clientSocket = null;

        // streams
        BufferedReader reader = null;
        PrintWriter outWriter = null;

        BufferedReader inFromUser = new BufferedReader(new InputStreamReader(System.in));
        clientSocket = new Socket("localhost", 11111); // IP e porta del server
        System.out.println("Socket creata: " + clientSocket);

        // creazione stream per lettura e invio della stringa verso il server
        reader = new BufferedReader(new InputStreamReader(clientSocket.getInputStream()));
        outWriter = new PrintWriter(clientSocket.getOutputStream());
        
        int val;
        
        do {
           System.out.println("Client: inserisci il valore (0 per terminare):");
           String val1 = inFromUser.readLine();
           outWriter.println(val1);
           outWriter.flush();
           val = Integer.parseInt(val1.trim());
        } while (val!=0);

        System.out.println("Attesa risposta...");
        String line = null;

        line = new String(reader.readLine());
        System.out.println("Msg dal server: " + line);

        // chiusura streams
        clientSocket.close();
        outWriter.close();
        reader.close();
    } catch (IOException e) {
            System.err.println(e.getMessage());
    }
    }
}

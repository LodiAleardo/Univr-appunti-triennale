// SERVER Calcolatrice Client/Server

import java.io.*;
import java.net.*;

class CalcServer {
    public static void main(String args[]) {

        // sockets
        ServerSocket serverSocket = null;
        Socket clientSocket = null;
        
        // streams
        BufferedReader reader = null;
        PrintWriter outWriter = null;
        
        try {
            System.err.println("Creazione ServerSocket");
            serverSocket = new ServerSocket(11111);

            System.out.println("Attesa connessione...");
            clientSocket = serverSocket.accept();
            System.out.println("Connessione da " + serverSocket);

            // apertura streams per lettura e invio della stringa verso il client
            reader = new BufferedReader(new InputStreamReader(clientSocket.getInputStream()));
            outWriter = new PrintWriter(clientSocket.getOutputStream());

            String line;
            int y, x = 0;
            do {
                line = new String(reader.readLine());
                y = Integer.parseInt(line);
                System.out.println("Value: " + y);
                x += y;
            } while (y != 0);

            outWriter.println("Somma = " + x);
            outWriter.flush();
            
            // chiusura streams
            outWriter.close();
            reader.close();
            clientSocket.close();
            serverSocket.close();
        } catch (Exception e) {
            System.out.println("Errore: " + e);
        }
    }
}

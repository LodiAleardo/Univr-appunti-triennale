//CLIENT trasferimento file

import java.io.*;
import java.net.*;

class FileClient {
    public static void main(String args[]) {

        // socket
        Socket clientSocket = null;

        // streams
        BufferedReader reader = null;
        PrintWriter outWriter = null;

        if (args.length == 0) {
            System.out.println("Missing file name");
            System.exit(-1);
        }

        try {
            clientSocket = new Socket("localhost", 11111); // IP e porta del server
            System.out.println("Socket creata: " + clientSocket);

            // apertura streams per lettura e invio della stringa verso il server
            reader = new BufferedReader(new InputStreamReader(clientSocket.getInputStream()));
            outWriter = new PrintWriter(clientSocket.getOutputStream());
        } catch(IOException e){
            e.printStackTrace();
        }

        // invio messaggio
        System.out.println("Invio richiesta per: " + args[0]);
        outWriter.println(args[0]);
        outWriter.flush();

        // stampa risposta del server
        System.out.println("Attesa risposta...");
        String line = null;

        try {
            while ((line = reader.readLine()) != null) {
                System.out.println("Messaggio: " + line);
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

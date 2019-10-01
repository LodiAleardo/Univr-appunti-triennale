//CLIENT

import java.io.*;
import java.net.*;

class EchoClient {
	public static void main(String args[]) {

		// socket
		Socket clientSocket = null;

		try {
			clientSocket = new Socket("localhost", 11111); // IP e porta del server
			System.out.println("Socket creata: " + clientSocket);

			// creazione del BufferedOutputStream e PrintWriter per
			// inviare la stringa al server
			BufferedOutputStream outBuffer = new BufferedOutputStream(clientSocket.getOutputStream());
			PrintWriter outWriter = new PrintWriter(outBuffer, true);

			// creazione del BufferedReader per leggere la risposta del server
			BufferedReader reader = new BufferedReader(new InputStreamReader(clientSocket.getInputStream()));

			// Invio messsaggio
			outWriter.println("echo up");

			// ricezione risposta dal server
			String line;
			while ((line = reader.readLine()) != null) {
				System.out.println("Ricevuto: " + line);
				if (line.equals("Stop"))
					break;
			}
			// chiudo il Socket (client)
			clientSocket.close();
			// chiudo PrintWriter
			outWriter.close();
			// chiudo BufferedReader
			reader.close();
		} catch (IOException e) {
			System.out.println("Error:" + e.getMessage());
		}
	}
}

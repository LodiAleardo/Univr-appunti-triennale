import java.io.*;
import java.net.*;

class EchoClient {
	public static void main(String args[]) {

		String indirizzo = "";
		String porta = "";
		String str = "";

		if (args.length == 3){
			indirizzo = args[0];
			porta = args[1];
			str = args[2];
		}else{
			System.out.println("Uso: java EchoClient <indirizzo> <porta> <stringa>");
			System.exit(-1);
		}

		// socket
		Socket clientSocket = null;

		try {
			clientSocket = new Socket(indirizzo, Integer.parseInt(porta)); // IP e porta del server
			System.out.println("Socket creata: " + clientSocket);

			// creazione del BufferedOutputStream e PrintWriter per
			// inviare la stringa al server
			BufferedOutputStream outBuffer = new BufferedOutputStream(clientSocket.getOutputStream());
			PrintWriter outWriter = new PrintWriter(outBuffer, true);

			// creazione del BufferedReader per leggere la risposta del server
			BufferedReader reader = new BufferedReader(new InputStreamReader(clientSocket.getInputStream()));

			// Invio messsaggio
			outWriter.println(str);

			// ricezione risposta dal server
			String line;
			while ((line = reader.readLine()) != null) {
				System.out.println("Ricevuto: " + line);
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

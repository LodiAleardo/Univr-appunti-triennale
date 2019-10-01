// CLIENT
import java.io.*;
import java.net.*;

class CalcClient {
	public static void main(String args[]) {

		String indirizzo = "";
		String porta = "";

		if (args.length > 2){
			indirizzo = args[0];
			porta = args[1];
		}else{
			System.out.println("Uso: java CalcClient <indirizzo> <porta>");
			System.exit(-1);
		}

		// socket
		Socket clientSocket = null;

		// streams
		BufferedReader reader = null;
		PrintStream outStream = null;

		try {
			clientSocket = new Socket(indirizzo, Integer.parseInt(porta)); // IP e porta del server
			System.out.println("Socket creata: " + clientSocket);
		} catch (IOException e) {
			System.err.println(e.getMessage());
			System.exit(1);
		}

		try {
		reader = new BufferedReader(new InputStreamReader(clientSocket.getInputStream()));
		outStream = new PrintStream(new BufferedOutputStream(clientSocket.getOutputStream()),true);
		} catch(IOException e){
			e.printStackTrace();
		}

		// invio valori al server (da linea comandi)
		for (int i = 2; i < args.length; i++) {
			System.out.println("Sending " + args[i]);
			outStream.println(args[i]);
		}

		outStream.println("0");
		System.out.println("Attesa risposta...");
		String line = null;

		try {
			line = new String(reader.readLine());
			System.out.println("Msg dal server: " + line);

			// chiusure
			reader.close();
			outStream.close();
			clientSocket.close();
		} catch (IOException e) {
			System.err.println(e.getMessage());
		}
	}
}

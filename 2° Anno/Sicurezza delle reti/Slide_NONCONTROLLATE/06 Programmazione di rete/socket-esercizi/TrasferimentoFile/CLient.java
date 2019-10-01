import java.io.*;
import java.net.*;

class Client {
	public static void main(String args[]) {

		// socket
		Socket clientSocket = null;

		// streams
		BufferedReader reader = null;
		PrintStream outStream = null;

		if (args.length == 0) {
			System.out.println("Missing file name");
			System.exit(-1);
		}

		try {
			clientSocket = new Socket("localhost", 11111); // IP e porta del server
		} catch (IOException e) {
			System.err.println(e.getMessage());
			System.exit(1);
		}

		System.out.println("Socket creata: " + clientSocket);

		try{
		reader = new BufferedReader(new InputStreamReader(clientSocket.getInputStream()));
		outStream = new PrintStream(new BufferedOutputStream(clientSocket.getOutputStream()), true);
		}catch(IOException e){
			e.printStackTrace();
		}

		// --- invio messaggio
		System.out.println("Invio richiesta per: " + args[0]);
		outStream.println(args[0]);

		// --- stampa risposta del server
		System.out.println("Attesa risposta...");
		String line = null;

		try {
			while ((line = reader.readLine()) != null) {
				System.out.println("Messaggio: " + line);
			}

			// chiusure
			clientSocket.close();
			outStream.close();
			reader.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
}

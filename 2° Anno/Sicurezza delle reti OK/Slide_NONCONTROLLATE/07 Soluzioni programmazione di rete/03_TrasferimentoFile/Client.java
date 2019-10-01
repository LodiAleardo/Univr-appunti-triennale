import java.io.*;
import java.net.*;

class Client {
	public static void main(String args[]) {

		String indirizzo = "";
		String porta = "";
		String fileName = "";
		if(args.length == 3){
			indirizzo = args[0];
			porta = args[1];
			fileName = args[2];
		}else{
			System.out.println("Use: java Client <indirizzo> <porta> <fileName>");
			System.exit(-1);
		}

		// socket
		Socket clientSocket = null;

		// streams
		BufferedReader reader = null;
		PrintStream outStream = null;

		try {
			clientSocket = new Socket(indirizzo, Integer.parseInt(porta)); // IP e porta del server
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
		System.out.println("Invio richiesta per: " + fileName);
		outStream.println(fileName);

		// --- stampa risposta del server
		System.out.println("Attesa risposta...");
		String line = null;

		try {
			File file = new File(fileName);
			PrintWriter fileWriter = new PrintWriter("./"+file.getName(), "UTF-8");
			while ((line = reader.readLine()) != null) {
				fileWriter.println(line);
			}
			fileWriter.close();
			
			System.out.println("Trasferimento concluso.");

			// chiusure
			clientSocket.close();
			outStream.close();
			reader.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
}

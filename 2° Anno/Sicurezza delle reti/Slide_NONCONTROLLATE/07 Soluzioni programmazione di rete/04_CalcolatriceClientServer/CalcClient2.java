// CLIENT
import java.io.*;
import java.net.*;

class CalcClient2 {
	public static void main(String args[]) {

		String indirizzo = "";
		String porta = "";
		String nPrimi = "";

		if (args.length == 3){
			indirizzo = args[0];
			porta = args[1];
			nPrimi = args[2];
		}else{
			System.out.println("Uso: java CalcClient2 <indirizzo> <porta> <nprimi>");
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

		System.out.println("Sending " + nPrimi);
		outStream.println(nPrimi);

		outStream.println("0");
		System.out.println("Attesa risposta...");
		String line = null;

		try {
			while((line = reader.readLine()) != null ){
				System.out.println("Msg dal server: " + line);
			}

			// chiusure
			reader.close();
			outStream.close();
			clientSocket.close();
		} catch (IOException e) {
			System.err.println(e.getMessage());
		}
	}
}

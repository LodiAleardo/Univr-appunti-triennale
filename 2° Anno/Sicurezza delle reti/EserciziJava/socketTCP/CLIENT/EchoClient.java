import java.io.*;
import java.net.*;
import java.util.Scanner;

class EchoClient {
	public static void main(String args[]) {

		String indirizzo = "";
		String porta = "";
		String str = "";

		if (args.length == 2){
			indirizzo = args[0];
			porta = args[1];
		}else{
			System.out.println("Uso: java EchoClient <indirizzo> <porta>");
			System.exit(-1);
		}

		// socket
		Socket clientSocket = null;

		try {
			//Apre una nuova socket specificando porta (193.21.1.1) e porta da cui inviare
			clientSocket = new Socket(indirizzo, Integer.parseInt(porta));
			System.out.println("Socket creata: " + clientSocket);
			
			// creazione del BufferedOutputStream e PrintWriter per inviare la stringa al server
			// *.getOutputStream() Ritorna un output stream per questa socket che è 
			BufferedOutputStream outBuffer = new BufferedOutputStream(clientSocket.getOutputStream());
			PrintWriter outWriter = new PrintWriter(outBuffer, true);

			// creazione del BufferedReader per leggere la risposta del server
			BufferedReader reader = new BufferedReader(new InputStreamReader(clientSocket.getInputStream()));

			Scanner readerTerminal = new Scanner(System.in);
			while( !str.equals("STOP") ){
				
				System.out.println("Cosa devo inviare: ");
				str = readerTerminal.nextLine();
				// Invio messsaggio
				if( !str.equals("invia") ){
					outWriter.append(str);
				}
				else{
					outWriter.println();
					
					// ricezione risposta dal server
					String line;
					if((line = reader.readLine()) != null) {
						System.out.println("Ricevuto: " + line);
					}

				}
			}
			System.out.println("END AND CLOSE!");
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

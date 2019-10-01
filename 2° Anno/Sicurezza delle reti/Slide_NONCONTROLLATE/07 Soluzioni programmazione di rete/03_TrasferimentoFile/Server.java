import java.io.*;
import java.net.*;

class Server {
	public static void main(String args[]) {

		String porta = "";
		if(args.length == 1){
			porta = args[0];
		}else{
			System.out.println("Uso: java Server <porta>");
			System.exit(-1);
		}

		// sockets
		ServerSocket serverSocket = null;
		Socket clientSocket = null;

		// streams
		BufferedReader reader = null ;
		PrintStream outStream = null ;
		BufferedReader fileReader = null;

		try {
			System.err.println("Creazione ServerSocket");
			serverSocket = new ServerSocket(Integer.parseInt(porta));
		} catch(Exception e){
			System.out.println("Impossibile creare ServerSocket");
			e.printStackTrace();
			System.exit(-1);
		}

				System.out.println("Attesa connessione...");
				try {
					clientSocket = serverSocket.accept();
				} catch (IOException e) {
					System.out.println("Connessione fallita");
					e.printStackTrace();
					System.exit(2);
				}

			System.out.println("Connessione da " + clientSocket);

			try {
				reader = new BufferedReader(new InputStreamReader(clientSocket.getInputStream()));
				BufferedOutputStream outBuffer = new BufferedOutputStream(clientSocket.getOutputStream());
				outStream = new PrintStream(outBuffer, true);

				// --- ricezione nome file dal client
				String fileName = new String(reader.readLine());
				System.out.println("File richiesto dal client: " + fileName);

				// --- invio del file al client
				fileReader  = new BufferedReader(new InputStreamReader(new FileInputStream(fileName)));

				String tmp = null;
				while ((tmp = fileReader.readLine()) != null) {
					outStream.println(tmp);
				}
				// chiusure
				try{
				serverSocket.close();
				clientSocket.close();
				reader.close();
				outStream.close();
				fileReader.close();
				}catch(IOException e){
					e.printStackTrace();
				}
			} catch (FileNotFoundException e) {
				System.out.println("File non trovato");
				outStream.println("File non trovato");
			} catch (Exception e) {
				System.out.println(e);
			} 		
	}
}

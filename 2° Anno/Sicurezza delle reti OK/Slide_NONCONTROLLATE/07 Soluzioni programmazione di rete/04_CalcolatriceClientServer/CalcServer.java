// SERVER
import java.io.*;
import java.net.*;

class CalcServer {
	public static void main(String args[]) {

		String porta = "";

		if (args.length == 1){
			porta = args[0];
		}else{
			System.out.println("Uso: java CalcServer <porta>");
			System.exit(-1);
		}

		// sockets
		ServerSocket serverSocket = null;
		Socket clientSocket = null;

		try {
			System.err.println("Creazione ServerSocket");
			serverSocket = new ServerSocket(Integer.parseInt(porta));
		} catch (IOException e) {
			System.err.println(e.getMessage());
			System.exit(1);
		}

			System.out.println("Attesa connessione...");

			try {
				clientSocket = serverSocket.accept();
			} catch (IOException e) {
				System.out.println("Connessione fallita");
				System.exit(2);
			}

			System.out.println("Connessione da " + serverSocket);

			try {
				BufferedReader reader = new BufferedReader(new InputStreamReader(clientSocket.getInputStream()));
				BufferedOutputStream outBuffer = new BufferedOutputStream(clientSocket.getOutputStream());
				PrintStream outStream = new PrintStream(outBuffer, true);

				String line;
				int y, x = 0;

				do {
					line = new String(reader.readLine());
					y = Integer.parseInt(line);
					System.out.println("Value: " + y);
					x += y;
				} while (y != 0);

				outStream.println("Somma = " + x);

				// chiusure
				outStream.close();
				reader.close();
				clientSocket.close();
				serverSocket.close();
			} catch (Exception e) {
				System.out.println("Errore: " + e);
				System.exit(3);
			}
	}
}

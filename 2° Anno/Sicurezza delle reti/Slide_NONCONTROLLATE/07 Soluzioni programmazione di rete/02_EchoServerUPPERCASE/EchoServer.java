import java.io.*;
import java.net.*;

class EchoServer {
	public static void main(String args[]) {

		String porta = "1111";
		if (args.length == 1){
			porta = args[0];
		}else{
			System.out.println("Uso: java EchoServer <porta>");
			System.exit(-1);
		}

		// sockets
		ServerSocket serverSocket = null;
		Socket clientSocket = null;


		try {
			System.out.print("Creazione ServerSocket...");
			serverSocket = new ServerSocket(Integer.parseInt(porta));

			System.out.print("Attesa connessione...");
			clientSocket = serverSocket.accept();
			System.out.println("Conness. da " + clientSocket);

			// creazione BufferReader per leggere stringa in arrivo
			BufferedReader reader = new BufferedReader(new InputStreamReader(clientSocket.getInputStream()));
			
			// creazione del BufferedOutputStream per inviare la stringa maiuscola
			BufferedOutputStream outBuffer = new BufferedOutputStream(clientSocket.getOutputStream());
			PrintWriter outWriter = new PrintWriter(outBuffer, true);
			
			// ricezione della stringa
			String text = new String(reader.readLine());
			System.out.println(text);
			
			// invio della nuova stringa in maiuscolo
			outWriter.println(text.toUpperCase());
			
			// chiudo BufferedReaser
			reader.close();
			// chiudo PrintWriter
			outWriter.close();
			// chiudo il Socket (client)
			clientSocket.close();
			// chiudo ServerSocket
			serverSocket.close();
		} catch (Exception e) {
			System.out.println("Errore: " + e);
			System.exit(3);
		}
	}
}

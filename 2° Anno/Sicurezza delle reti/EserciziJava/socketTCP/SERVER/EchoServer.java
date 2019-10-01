import java.io.*;
import java.net.*;
import java.lang.*;
class EchoServer {
	public static void main(String args[]) {

		String porta = "1111";
		InetAddress indirizzo = null ;
		if (args.length == 2){
			porta = args[0];
			try{
			indirizzo = InetAddress.getByName(args[1]);
			}
			catch(UnknownHostException e){
				System.out.println("Errore: " + e);
				System.exit(3);
			}

		}else{
			System.out.println("Uso: java EchoServer <porta> <indirizzo>");
			System.exit(-1);
		}

		// sockets
		ServerSocket serverSocket = null;
		Socket clientSocket = null;
		String str="";
	while(!str.equals("STOP")){
		try {
			System.out.println("Creazione ServerSocket...");
			serverSocket = new ServerSocket( Integer.parseInt(porta) , 500 , indirizzo);
			System.out.print("Nuova socket a:" + serverSocket.getInetAddress() );
			System.out.println(" .Porta:" + serverSocket.getLocalPort());
			
			System.out.println("Attesa connessione...");
			clientSocket = serverSocket.accept();
			System.out.println("Conness. da " + clientSocket);

			// creazione BufferReader per leggere stringa in arrivo
			BufferedReader reader = new BufferedReader(new InputStreamReader(clientSocket.getInputStream()));
			
			// creazione del BufferedOutputStream per inviare la stringa maiuscola
			BufferedOutputStream outBuffer = new BufferedOutputStream(clientSocket.getOutputStream());
			PrintWriter outWriter = new PrintWriter(outBuffer, true);
			
			String text = null;

			do{
				System.out.print("Attendo una nuova stringa:");
				// ricezione della stringa
				text = new String(reader.readLine());
				System.out.println(text);
				
				// invio della nuova stringa in maiuscolo
				if( !text.equals("STOP")){
					outWriter.println(text.toUpperCase());
					str=text.toUpperCase();
				}
			}while( !text.equals("STOP"));

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

	}//Fine while
	}
}

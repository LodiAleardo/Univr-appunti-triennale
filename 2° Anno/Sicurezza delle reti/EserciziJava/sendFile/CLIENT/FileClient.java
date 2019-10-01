import java.io.*;
import java.net.*;
import java.util.Scanner;

class FileClient {
	public static void main(String args[]) {
		
		String port = "";
		String address = "";
		String fileName = "";
		String input = "";
		Socket clientSocket = null;

		if( args.length != 2 ){
			System.out.println("Uso: java FileClien <address> <port>");
			System.exit(-1);
		}
		else{
			address = args[0];
			port = args[1];
		}
		
		try{
			clientSocket = new Socket(address , Integer.parseInt(port));
			System.out.println("Socket creata ...");
			
			//Questo mi serve per scrivere l'output
			BufferedOutputStream outStream = new BufferedOutputStream(clientSocket.getOutputStream());
			PrintWriter writer = new PrintWriter(outStream ,true);
			
			//Questo per leggere l'input che mi arriverà
			BufferedReader reader = new BufferedReader(new InputStreamReader(clientSocket.getInputStream()));
			
			do{

				writer.println(fileName);

				if( (input = reader.readLine()).equals("20") ){
					
					//Orra arriva il file linea per linea e lo devo salvare
					System.out.println("Messaggio:");
					while( (input = reader.readLine()) != null ){
						System.out.println(input);
					}
				fileName = "";
				}
				else{
					//Chiede un nuovo file da fare input
					Scanner read = new Scanner(System.in);
					System.out.println("Un nuovo file: ");
					fileName = read.nextLine();
				}

			}while( !fileName.isEmpty() );
		
		reader.close();
		writer.close();
		outStream.close();
		clientSocket.close();
		} catch (IOException e) {
			System.out.println("Errore: " + e.getMessage() );
			System.exit(-2);
		}

		
	}
}

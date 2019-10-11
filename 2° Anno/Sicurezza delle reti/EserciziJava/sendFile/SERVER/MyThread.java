import java.io.*;
import java.net.*;
import java.util.Scanner;

import java.io.File;
import java.io.FileNotFoundException;


public class MyThread extends Thread {
	private Socket connessioneArrivo;
	public MyThread( Socket s ){
		connessioneArrivo = s;
	}
	
	@Override
	public static void run(){
			String fileName = "";
			//Per leggere
			try{
			BufferedReader readerServer = new BufferedReader(new InputStreamReader(connessioneArrivo.getInputStream()));
			//Per scrivere
			BufferedOutputStream streamOut = new BufferedOutputStream(connessioneArrivo.getOutputStream());
			PrintWriter writer = new PrintWriter(streamOut,true);

			do{
				fileName = readerServer.readLine();
				if( !fileName.equals("ciaoKK.txt") )
					writer.println("NO");

			}while ( !fileName.equals("ciaoKK.txt") );
			//Per ora l'unico file è "ciaoKK.txt"
			
			writer.println("20");

			//Con estensione ricorda
			File file = new File(fileName);

			try {

				Scanner sc = new Scanner(file);

				while (sc.hasNextLine())
					writer.println( sc.nextLine() );
				
				sc.close();
			}
			catch (FileNotFoundException e) {
				e.printStackTrace();
			}

			//Chiudo tutto
			writer.close();
			streamOut.close();
			readerServer.close();
			connessioneArrivo.close();
			}catch(IOException e){
				System.out.println("Errore:"+e);
			}

	}
}

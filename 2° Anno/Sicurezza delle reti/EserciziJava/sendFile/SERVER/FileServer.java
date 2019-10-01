import java.io.*;
import java.net.*;
import java.util.Scanner;

import java.io.File;
import java.io.FileNotFoundException;

class FileServer{
	public static void main(String args[]) {
		String port = "";
		String address = "";
		String input = "";
		Socket clientSocket = null;

		if( args.length != 2 ){
			System.out.println("Uso: java FileServer <address> <port>");
			System.exit(-1);
		}
		else{
			address = args[0];
			port = args[1];
		}

		try{
			ServerSocket ss = new ServerSocket(Integer.parseInt(port) ,500 ,InetAddress.getByName(address));
			
			Socket connessioneArrivo = ss.accept();
			MyThread myThread = new MyThread(connessioneArrivo);
			myThread.start();
			
			ss.close();
		} catch (IOException e){
			System.out.println("Errore: " + e );
		}

	}
}

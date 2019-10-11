import java.io.*;
import java.net.*;

class server{
	public static void main(String args[]){

		try{
			DatagramSocket serverSocket = new DatagramSocket(9876);
			DatagramPacket receivePacket;
			DatagramPacket sendPacket;

			byte[] receiveData = new byte[1024];
			byte[] sendData = new byte[1024];

			receivePacket = new DatagramPacket( receiveData, receiveData.length ); 
			serverSocket.receive( receivePacket);		
		
			String frase = new String(receivePacket.getData());

			System.out.println("R: " + frase);
		
		}catch( Exception e){
			System.out.println("Errore2:"+e);
		}finally{
			//serverSocket.close();
		}

		return;
	}
}

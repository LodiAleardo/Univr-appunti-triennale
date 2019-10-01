import java.io.*;
import java.net.*;
import java.nio.*;


class client{
	public static void main(String args[]){
		if( args.length != 2){
			System.out.println("Argomenti <porta> <ip>");
			System.exit(2);
		}
			
			try{
			DatagramSocket darSock = new DatagramSocket();
			DatagramPacket datPackSend;
			DatagramPacket datPackRecv;
			
			byte[] sendData = new byte[1024];
			byte[] reciveData = new byte[1024];

			InetAddress IPAdd = InetAddress.getByName("localhost");

			String sentence = "1234";

			sendData = sentence.getBytes();;

			datPackSend = new DatagramPacket( sendData, sendData.length, IPAdd, 9876);

			darSock.send(datPackSend);
			darSock.setSoTimeout(98);
			datPackRecv = new DatagramPacket(reciveData,reciveData.length);
			darSock.receive(datPackRecv);


		}catch( Exception e){
			System.out.println("Errore: " + e);
		}finally{
			
		}

		return;
	}

}

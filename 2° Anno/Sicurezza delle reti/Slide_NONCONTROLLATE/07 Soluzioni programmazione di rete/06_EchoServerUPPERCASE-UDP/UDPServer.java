import java.io.*;
import java.net.*;

class UDPServer {
	public static void main(String args[]) {
		try {
			DatagramSocket serverSocket = new DatagramSocket(9876);
			while (true) {
			            byte[] receiveData = new byte[1024];

						DatagramPacket receivePacket = new DatagramPacket(receiveData, receiveData.length);
						serverSocket.receive(receivePacket);
                        System.out.println("got it");
                        
						String sentence = new String(receivePacket.getData());
						System.out.println("RECEIVED: " + sentence);	
					    String capitalizedSentence = sentence.toUpperCase();
						
                        byte[] sendData = new byte[1024];                        						
						InetAddress IPAddress = receivePacket.getAddress();
						int port = receivePacket.getPort();
						sendData = capitalizedSentence.getBytes();

						DatagramPacket sendPacket = new DatagramPacket(sendData,
								sendData.length, IPAddress, port);
						serverSocket.send(sendPacket);
			}
		} catch (Exception e) {
				System.err.println("Server: errore "+e);
		}
	}
}

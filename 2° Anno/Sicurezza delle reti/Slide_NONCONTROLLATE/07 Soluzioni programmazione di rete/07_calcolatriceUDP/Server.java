import java.io.*;
import java.net.*;
import java.nio.ByteBuffer;

class Server {
	public static void main(String args[]) {
		try {
			DatagramSocket serverSocket = new DatagramSocket(9876);
			DatagramPacket receivePacket;
			int val;
			int somma = 0;
			
			do {
				    // riceviamo il numero e facciamo la somma
				    byte[] receiveData = new byte[1024];
					receivePacket = new DatagramPacket(receiveData, receiveData.length);
					System.out.println("Server: attesa valore");
					serverSocket.receive(receivePacket);
					String str1 = new String(receivePacket.getData());
					val = Integer.parseInt(str1.trim());
					System.out.println("Server: ricevuto " + val );
                    somma += val;
			} while(val!=0);
			
			// rispondiamo al client con la somma
			System.out.println("Server: somma " + somma );
		    InetAddress IPAddress = receivePacket.getAddress();
			int port = receivePacket.getPort();
			byte[] sendSomma = new byte[1024];
			sendSomma = (Integer.toString(somma)).getBytes();
			DatagramPacket sendPacket = new DatagramPacket(sendSomma,sendSomma.length, IPAddress, port);
			serverSocket.send(sendPacket);
		} catch (Exception e) {
				System.err.println("Server: errore "+e);
		}
	}

}

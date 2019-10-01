import java.io.*;
import java.net.*;

class Client {
	public static void main(String args[]) {
		try {
			BufferedReader inFromUser = new BufferedReader(
					new InputStreamReader(System.in));
			DatagramSocket clientSocket = new DatagramSocket();
			InetAddress IPAddress = InetAddress.getByName("localhost");// IP
			int val;
			byte[] sendData = new byte[1024];
			byte[] receiveData = new byte[1024];
			
			do {
			     System.out.println("Client: inserisci il valore (0 per terminare):");
			     String val1 = inFromUser.readLine();
			     sendData = val1.getBytes();
			     DatagramPacket sendPacket = new DatagramPacket(sendData,
					sendData.length, IPAddress, 9876); // IP e PORTA
			     clientSocket.send(sendPacket);
			     val = Integer.parseInt(val1.trim());
            } while (val!=0);

			DatagramPacket receivePacket = new DatagramPacket(receiveData,receiveData.length);
			clientSocket.receive(receivePacket);
			String somma = new String(receivePacket.getData());
			System.out.println("Client: somma ricevuta dal server " + somma);
			
		} catch (Exception e) {
				System.err.println("Client: errore "+e);
		}
	}
	
}

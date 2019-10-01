import java.io.*;
import java.net.*;

class UDPClient {
    public static void main(String args[]) {
        try {
            BufferedReader inFromUser = new BufferedReader(
                    new InputStreamReader(System.in));
            DatagramSocket clientSocket = new DatagramSocket();
            InetAddress IPAddress = InetAddress.getByName("localhost");
            
            byte[] sendData = new byte[1024];
            byte[] receiveData = new byte[1024];
            System.out.println("Inserisci il messaggio per il server\n");
            String sentence = inFromUser.readLine();
            sendData = sentence.getBytes();
            DatagramPacket sendPacket = new DatagramPacket(sendData,
                    sendData.length, IPAddress, 9876); // IP e PORTA
            clientSocket.send(sendPacket);
            DatagramPacket receivePacket = new DatagramPacket(receiveData,
                    receiveData.length);
            clientSocket.receive(receivePacket);
            String modifiedSentence = new String(receivePacket.getData());
            System.out.println("FROM SERVER:" + modifiedSentence);
        } catch (Exception e) {
                System.err.println("Client: errore "+e);
        }
    }
}

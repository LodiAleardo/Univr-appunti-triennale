// CLIENT UDP Echo UpperCase
import java.io.*;
import java.net.*;

class UDPClient {
    public static void main(String args[]) throws Exception {
        try {
            DatagramSocket clientSocket = new DatagramSocket();
            DatagramPacket receivePacket;
            DatagramPacket sendPacket;
            
            byte[] sendData = new byte[1024];
            byte[] receiveData = new byte[1024];
            
            BufferedReader inFromUser = new BufferedReader(new InputStreamReader(System.in));
            InetAddress IPAddress = InetAddress.getByName("localhost");// IP dst
             
            System.out.println("Inserisci il messaggio per il server\n");
            String sentence = inFromUser.readLine();
            sendData = sentence.getBytes();
            sendPacket = new DatagramPacket(sendData,sendData.length, IPAddress, 9876); // IP e PORTA dst
            clientSocket.send(sendPacket);
            
            receivePacket = new DatagramPacket(receiveData,receiveData.length);
            clientSocket.receive(receivePacket);
            
            String modifiedSentence = new String(receivePacket.getData());
            System.out.println("FROM SERVER:" + modifiedSentence);
            
            clientSocket.close();
        } catch (Exception e) {
                    System.err.println("Client: errore "+e);
        }
    }
}


// CLIENT UDP Calcolatrice Client/Server

import java.io.*;
import java.net.*;

class Client {
    public static void main(String args[]) {
        try {
            DatagramSocket clientSocket = new DatagramSocket();
            DatagramPacket sendPacket;
            DatagramPacket receivePacket;
            
            byte[] sendData = new byte[1024];
            byte[] receiveData = new byte[1024];
            
            int val;
            
            BufferedReader inFromUser = new BufferedReader(new InputStreamReader(System.in));
            InetAddress IPAddress = InetAddress.getByName("localhost");// IP
            do {
                 System.out.println("Client: inserisci il valore (0 per terminare):");
                 String val1 = inFromUser.readLine();
                 sendData = val1.getBytes();
                
                 sendPacket = new DatagramPacket(sendData,sendData.length, IPAddress, 9876); // IP e PORTA
                 clientSocket.send(sendPacket);
                 val = Integer.parseInt(val1.trim());
            } while (val!=0);

            receivePacket = new DatagramPacket(receiveData,receiveData.length);
            clientSocket.receive(receivePacket);
            
            String somma = new String(receivePacket.getData());
            System.out.println("Client: somma ricevuta dal server " + somma);
            
            clientSocket.close();
        } catch (Exception e) {
                System.err.println("Client: errore "+e);
        }
    }
}

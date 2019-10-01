// SERVER UDP Calcolatrice Client/Server

import java.io.*;
import java.net.*;
import java.nio.ByteBuffer;

class Server {
    public static void main(String args[]) {
        try {
            DatagramSocket serverSocket = new DatagramSocket(9876);
            DatagramPacket receivePacket;
            DatagramPacket sendPacket;
            
            byte[] sendSomma = new byte[1024];
            
            int val;
            int somma = 0;
            
            System.out.println("Attesa client...");
            
            do {
                    byte[] receiveData = new byte[1024];
                    // riceviamo il numero e facciamo la somma
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
            sendSomma = (Integer.toString(somma)).getBytes();
            sendPacket = new DatagramPacket(sendSomma,sendSomma.length, IPAddress, port);
            serverSocket.send(sendPacket);
        } catch (Exception e) {
                System.err.println("Server: errore "+e);
        }
    }

}

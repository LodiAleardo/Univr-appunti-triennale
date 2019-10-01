// SERVER UDP Echo UpperCase

import java.io.*;
import java.net.*;

class UDPServer {
    public static void main(String args[]) throws Exception {
        try {
            DatagramSocket serverSocket = new DatagramSocket(9876);
            DatagramPacket receivePacket;
            DatagramPacket sendPacket;

            System.out.print("Attesa client...");

            while (true) {
                try {
                    byte[] receiveData = new byte[1024];
                    byte[] sendData = new byte[1024];
                    
                    receivePacket = new DatagramPacket(receiveData, receiveData.length);
                    serverSocket.receive(receivePacket);
                    String sentence = new String(receivePacket.getData());
                    System.out.println("RECEIVED: " + sentence);
                    InetAddress IPAddress = receivePacket.getAddress();
                    int port = receivePacket.getPort();
                    String capitalizedSentence = sentence.toUpperCase();
                    sendData = capitalizedSentence.getBytes();

                    sendPacket = new DatagramPacket(sendData,sendData.length, IPAddress, port);
                    serverSocket.send(sendPacket);
                } catch (UnknownHostException ue) {
                    System.out.println("Errore: " + ue.getMessage());
                }
            }
        } catch (java.net.BindException b) {
            System.err.println("Impossibile avviare il server.");
        }
    }
}


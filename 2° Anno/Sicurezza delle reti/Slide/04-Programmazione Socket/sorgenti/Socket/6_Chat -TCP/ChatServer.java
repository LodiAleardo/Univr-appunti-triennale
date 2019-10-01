import java.net.*;
import java.io.*;

class ChatServer {
    public static void main(String args[]) throws Exception {
        ServerSocket conn = new ServerSocket(1025);
        new Server(conn.accept()).run();
    }
}

class Server {

    Socket socket;

    public Server(Socket s) {
        this.socket = s;
    }

    public void run() {
        String from;
        BufferedReader reader = null;
        PrintStream outStream = null;

        try {
            reader = new BufferedReader(new InputStreamReader(socket.getInputStream()));
            outStream = new PrintStream(socket.getOutputStream());

            System.out.println("Connected");
            while ((from = reader.readLine()) != null && !from.equals("")) {
                System.out.println(from);
                outStream.print(from + "\r\n");
            }
            socket.close();
        } catch (IOException e) {
            System.out.println(e);
        }
        System.out.println("Disconnected");
    }
}

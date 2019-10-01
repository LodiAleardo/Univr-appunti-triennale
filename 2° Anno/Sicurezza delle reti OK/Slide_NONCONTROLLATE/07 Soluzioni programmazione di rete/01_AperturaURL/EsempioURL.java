import java.io.*; 
import java.net.*;

class EsempioURL 
{
    public static void main(String args[])
    {
        String indirizzo; 

        if (args.length > 0) 
        { 
            indirizzo = args[0]; 
        } 
        else 
        { 
            System.out.println("Uso: java EsempioURL <URL>"); 
            System.exit(-1);
        }

        URL url = null;
        try 
        { 
            url = new URL(indirizzo);
            System.out.println("URL aperto: " + url);
        }
        catch (MalformedURLException e) 
        {
            System.out.println("URL errato: " + url);
        }

        URLConnection connection = null;
        DataInputStream istream = null;

        try 
        {
            System.out.print("Connessione in corso...");
                connection = url.openConnection();
                connection.connect();
                System.out.println("ok.");
								BufferedReader reader = new BufferedReader(new InputStreamReader(connection.getInputStream()));
                System.out.println("Lettura dei dati...");
                String str;
                while( (str = reader.readLine()) != null )
                    System.out.println(str); 
            }
            catch (IOException e) 
            {
                System.out.println(e.getMessage());
            }
        }
}

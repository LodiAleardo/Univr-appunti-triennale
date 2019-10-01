public class KeggEsDBGET {
    public static void main(String[] args) {
        RESTCall serv= new RESTCall();
        String result = serv.bget(args[0]);
        System.out.println(result);
    }
}

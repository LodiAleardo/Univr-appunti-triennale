public class GetGenesByEnzyme {
    public static void main(String[] args) {
    // come sopra
    RESTCall serv= new RESTCall();
    String[] result;
    // recuperiamo il numero di geni dato l'organismo
    result = serv.get_genes_by_enzyme("ec:2.7.1.6","ljo");
    System.out.println(result[0]);                 
    } 
}

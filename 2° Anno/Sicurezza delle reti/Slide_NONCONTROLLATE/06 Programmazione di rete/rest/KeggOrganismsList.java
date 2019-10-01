public class KeggOrganismsList {
        
    public static void main(String[] args) throws Exception {
        // creazione di un oggetto RESTCall che effettua le chiamate al KEGG
        RESTCall rest= new RESTCall();
        // richiediamo la lista degli organismi presenti in KEGG
        Definition[] def = rest.list_organisms();
        // tramite un ciclo for stampiamo la lista degli organismi
        for (int i = 0; i < def.length; i++) {
            System.out.println(i+")"+def[i].getDefinition());
        }
    }
}

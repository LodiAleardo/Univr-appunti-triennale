/* 	Programma JAVA che, dopo aver chiesto una marca X, visualizzi il risultato
	della query dell'esercizio 2 	*/

//SQLException per ovvie ragioni. ClassNotFoundException perche' il Class.forName potrebbe non trovare la classe

public static void main(String[] args) throws SQLException, ClassNotFoundException {

	Scanner in = new Scanner(System.in);

	//caricamento drivers
	Class.forName("org.postgresql.Driver")

	// creazione connessione
	try(Connection conn = DriverManager.getConnection("jdbc://dbserver.scienze.univr.it:5342/id402mee", "username", "passwd")) {

		String iteration = '';
		do {

			// Inserimento e controllo dell'input utente
			String marca = '';
			System.out.print("Inserisci la marca: ");
			marca = in.nextLine();

			// Controllo se la marca esiste nel database (superfluo, ma ok)
			try(PreparedStatement pst = conn.prepareStatement("SELECT COUNT(*) FROM auto WHERE marca=?")) {
				pst.setString(1, marca)

				ResultSet rs = pst.executeQuery();
				rs.next();

				if (rs.getInt(1) <= 0) {
					System.out.print("La marca inserita non esiste. Riprovare");
					continue;
				}

			}catch(SQLException e){
				System.out.println("Errore nel controllo di validita' input: " + e.getMessage());
			}

			// Marca valida, eseguo la query
			try (PreparedStatement pst = conn.prepareStatement(	"SELECT c.nome, c.cognome, c.paeseProvenienza "+
																"FROM cliente c "+
																"WHERE c.nPatente NOT IN( "+:
																	"SELECT c.nPatente AS idCliente "+
																	"FROM 	cliente c JOIN noleggio n ON n.cliente = c.nPatente "+
																			"JOIN auto a ON n.auto = a.targa "+
																	"WHERE 	a.marca = ?)")) {
				pst.setString(1,marca);

				// display dei risultati
				ResultSet rs = pst.executeQuery();

				System.out.println("Lista di persone che hanno noleggiato " + marca + ":");
				while(rs.next()){
					System.out.println(String.format("%20s %20s %20s"), rs.getString(1), rs.getString(2), rs.getString(3));
				}

			}catch(SQLException e) {
				System.out.println("Errore nella query principale: " + e.getMessage());
			}

			System.out.println("Inserire un'altra entry? [y/n] ");
			iteration = in.nextLine();

		} while(iteration == 'y')

	}catch(SQLException e) {
		System.out.println("Errore nella creazione connessione: " + e.getMessage());
	}
}
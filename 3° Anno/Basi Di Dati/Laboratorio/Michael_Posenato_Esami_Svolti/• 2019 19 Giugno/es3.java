/*	programma java che leggendo il codice di una sezione da console, visualizzi
	il risultato della query 2a. Se il codice non esiste, il programma deve
	richiedere nuovamente il dato	*/

public static void main(String[] args) throws SQLException, ClassNotFoundException {

	Scanner 	in = new Scanner(System.in);
	String 		sezione = '';
	ResultSet 	rs = null;
	preparedStatement pst = null;

	try(Class.forName("org.posrgresql.Driver");
		Connection conn = DriverManager.getConnection("jdbc:postgresql://server_name:port/database", user, password)){

		// richiesta e controllo sull'user input
		do {
			System.out.print("Codice sezione: ");
			sezione = in.nextLine();

			try (pst = conn.prepareStatement("SELECT COUNT(*) FROM sezione WHERE codice=?")) {
				pst.setString(1, sezione);

				rs = pst.executeQuery();
				rs.next();

				if (rs.getInt(1) != 1) {
					System.out.print("Codice sezione inserito non valido, riprovare.");
					continue;
				}
			}catch(SQLException e){
				System.out.print("Errore nel controllo input utente: " e.getMessage());
			}

		}while(false)

		// codice sezione valido, eseguo la query
		try (pst = conn.executeQuery("<CODICE QUERY ES2A> AND s.codice=?")) {
			pst.setString(1, sezione);
			rs = pst.executeQuery();

			// display del risultato
			while(rs.next()) {
				System.out.println(String.format("%20s %20s %20s %20s %d", rs.getString(1), rs.getString(2), rs.getString(3), rs.getString(4), rs.getInt(5)));
			}
		}catch(SQLException e) {
			System.out.print("Errore nel fetch del risultato: " + e.getMessage());
		}

	}catch(SQLException e){
		System.out.print("Errore nella creazione della connessione: " + e.getMessage());
	}catch(ClassNotFoundException e){
		System.out.print("Errore nel fetch dei driver: " + e.getMessage());
	}
}
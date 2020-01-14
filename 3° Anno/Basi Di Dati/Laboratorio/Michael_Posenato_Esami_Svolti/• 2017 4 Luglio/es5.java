// 'SELECT idRisorsa, dataInizio, durata FROM prestito WHERE idUtente=%s AND idBiblioteca=%s', (idUtente, idBiblioteca))

public static void main(String[] args) throws Exception {
	class.forName("org.postgresql.Driver");
	String codiceFiscale = args[0];
	String idBiblio = args[1]

	try(Connection conn = DriverManager.getConnection("jdbc:postgresql://localhost:5432/X", "user", "passwd")) {

		//di norma ci vanno i controlli sulla validita', ma per che per questo
		//specifico esame non siano richiesti 
		
		// [INIZIO CODICE ESAME]

		PreparedStatement pst = conn.prepareStatement(""+
			"SELECT idRisorsa, dataInizio, durata"+
			"FROM prestito"+
			"WHERE idUtente=? AND idBiblioteca=?");

		pst.setString(1, codiceFiscale);
		pst.setString(2, idBiblio);

		ResultSet rs = pst.executeQuery();

		// [FINE CODICE ESAME]

		while(rs.next()) {
			System.out.println(String.format("| %20s | %20s | %20s |", 
				rs.getString(idRisorsa), 
					sdf.format(rs.getDate("dataInizio")), 
						((PGInterval).rs.getObject("durata")).getValue()) );
		}
	}catch (SQLException e) {
		// exception handling
	}
}
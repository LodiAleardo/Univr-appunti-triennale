# trovo per ogni utente che abbia fatto prestiti in almeno 2 biblioteche
# il numero di prestiti terminati a oggi presso ogni biblioteca, e la loro durata
# totale (sempre per ogni biblioteca). Riporto CFutente, idBiblioteca, conteggi.

# isolo gli utenti che hanno prestiti in almeno 2 biblioteche
CREATE TEMP VIEW utenti_2_biblioteche AS 
SELECT 	p.idUtente AS codicefiscale
FROM 	prestito p
GROUP BY p.idUtente
HAVING COUNT(DISTINCT p.idBiblioteca) >= 2;

SELECT 	u.codicefiscale AS cf_Utente,
		p.idBiblioteca AS id_Biblioteca,
		COUNT(*) AS prestiti_terminati,
		SUM(p.durata) AS durata_Tot
FROM 	utenti_2_biblioteche u 
		JOIN prestito p ON p.idUtente = u.codicefiscale
WHERE 	(p.dataInizio + p.durata) > CURRENT_TIMESTAMP
GROUP BY 	cf_Utente, id_Biblioteca
ORDER BY 	cf_Utente;

# trovo per ogni biblioteca(id) l'utente con il maggior numero di prestiti e 
# quello con la durata complessiva maggiore. Riporto idBiblioteca, cfUtente,
# e conteggi. Se i 2 utenti coincidono, si stampi una sola riga.

# dovrei vedere BBB (numprestiti) e EEE (durata) per santa marta
# dovrei visualizzare solo AAA per la civica,
# per la frinzi dovrei vedere AAA per durata e BBB per numero (2)
SELECT  DISTINCT p.idBiblioteca AS biblio, 
		p.idUtente AS utente, 
		COUNT(*) AS n_prestiti, 
		SUM(p.durata) AS durata_tot 
FROM 	prestito p
GROUP BY 	p.idBiblioteca, p.idUtente
HAVING 		COUNT(*) >= ALL(
						SELECT 	COUNT(*)
						FROM 	prestito p2
						WHERE 	p.idBiblioteca = p2.idBiblioteca
								AND p.idUtente <> p2.idUtente)
			OR SUM(p.durata) >= ALL(
						SELECT 	SUM(p3.durata)
						FROM 	prestito p3
						WHERE 	p.idBiblioteca = p3.idBiblioteca
								AND p.idUtente <> p3.idUtente)
ORDER BY 	p.idBiblioteca DESC;

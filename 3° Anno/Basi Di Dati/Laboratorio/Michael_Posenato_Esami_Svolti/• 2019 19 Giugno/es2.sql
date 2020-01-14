# tra i progetti aventi responsabili della stessa sezione, trovo quello/i con
# la massima durata. mostro codice del progetto, cfResp, nome sezione e durata
# in giorni
SELECT 	p.codice AS codProgetto,
		p.codRespProg AS codRespProg,
		s.nome AS nomeSezione,
		(p.dataFine - p.dataInizio) AS giorniDurata
FROM 	progetto p 	
		JOIN ricercatore r ON p.codRespProg = r.codiceFiscale
		JOIN sezione s ON r.sezApp = s.codice
WHERE 	(p.dataFine - p.dataInizio) >= (SELECT 	MAX(p.dataFine - p.dataInizio) 
										FROM 	progetto p
												JOIN ricercatore r3 ON p.codRespProg = r3.codiceFiscale
										WHERE 	r3.sezApp = r.sezApp)
		AND p.codice IN (SELECT codice 
						FROM 	progetto p
								JOIN ricercatore r2 ON p.codRespProg = r2.codiceFiscale
						WHERE 	r2.sezApp = r.sezApp);


# trovo i progetti che coinvolgano tutte le sezioni, cioe' i progetti in cui 
# partecipa almeno 1 ricercatore da ogni sezione. Riporto codice progetto,
# e numero totale di ricercatori che vi lavorano.

# il progetto PROG_A coinvolge tutte le sezioni

SELECT 	par.progetto, COUNT(par.ricercatore) AS numRicercatori
FROM 	partecipa par 
		JOIN ricercatore r ON r.codiceFiscale = par.ricercatore
GROUP BY par.progetto
HAVING 	COUNT(DISTINCT r.sezApp) = (SELECT COUNT(*) FROM sezione)

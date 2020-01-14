# trovo per ogni contratto iniziato a Gennaio 2007 il numero di telefonate
# e la durata totale delle telefonate eseguite nel mese di Maggio 2007 dal cliente
# del contratto. Riporto la data di inizio del contratto, id_contratto e conteggi

# Creo una vista dei clienti che hanno aperto un contratto a Gennaio 2007,
# e relativo contratto
CREATE VIEW e4a AS
SELECT 	c.codice, co.contratto, co.dataInizio
FROM 	cliente c 
		JOIN contratto co ON co.cliente = c.codice
WHERE 	EXTRACT(month FROM co.dataInizio) = 1
		AND EXTRACT(year FROM co.dataInizio) = 2007

# per i contratti della vista, trovo le telefonate di maggio 2007
SELECT 	v.contratto, 
		v.dataInizio, 
		COUNT(*) AS telefonate, 
		SUM(t.durata) AS durataTot
FROM 	e4a v 
		JOIN telefonata t ON t.contratto = v.contratto 
WHERE 	EXTRACT(month FROM t.istanteInizio) = 5
		AND EXTRACT(year FROM t.istanteInizio) = 2007
GROUP BY v.contratto, v.dataInizio;

# trovo per ogni contratto il mese in cui ha effettuato il maggior numero
# di telefonate nel 2016. Riporto numero contratto, mese e numero telefonate

# vista che associa a ogni contratto, per ogni mese, il numero di telefonate
CREATE VIEW e2b AS
SELECT 	co.contratto AS idContratto, 
		EXTRACT(month FROM co.dataInizio) AS meseInizio,
		COUNT(*) AS numTelefonate
FROM 	contratto co 
		JOIN telefonata t ON t.contratto = co.contratto
WHERE 	EXTRACT(year FROM co.dataInizio) = 2016
GROUP BY idContratto, meseInizio


SELECT 	idContratto, meseInizio, numTelefonate
FROM 	e2b v 
WHERE 	numTelefonate >= ALL (
			SELECT 	COUNT(*)
			FROM 	contratto co 
					JOIN telefonata t ON t.contratto = co.contratto 	
			WHERE 	EXTRACT(year FROM co.dataInizio) = 2016
					AND EXTRACT(month FROM co.dataInizio) = v.meseInizio)
			);
# trovo cognome, nome e indirizzo dei clienti di Padova che IERI hanno fatto 
# telefonate, ma non tra le 10 e le 17

SELECT 	c.cognome, c.nome, c.indirizzo
FROM 	cliente c 
		JOIN contratto co ON co.cliente = c.codice
		JOIN telefonata t ON co.contratto = t.contratto
WHERE 	c.citta = 'Padova'
		AND t.istanteInizio >= CURRENT_DATE-1 
		AND t.istanteInizio < CURRENT_DATE 
EXCEPT
SELECT 	c.cognome, c.nome, c.indirizzo
FROM 	cliente c 
		JOIN contratto co ON co.cliente = c.codice
		JOIN telefonata t ON co.contratto = t.contratto
WHERE 	c.citta = 'Padova' 
		AND t.istanteInizio >= CURRENT_DATE-1+TIME'10:00'
		AND t.istanteInizio <= CURRENT_DATE-1+TIME'17:00'; 
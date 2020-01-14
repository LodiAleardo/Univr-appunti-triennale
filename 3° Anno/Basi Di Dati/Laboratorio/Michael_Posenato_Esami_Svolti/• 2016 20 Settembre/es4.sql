# trovo per ogni autostrada che raggiunga almeno 2 comuni (non ho cazzi di fare
# 1000 insert in popolazione.sql), il numero totale di comuni che raggiunge e il
# numero totale di caselli. Riporto codiceAutostrada, lunghezza e conteggi
SELECT 	a.codice, 
		a.lunghezza, 
		COUNT(DISTINCT c.codiceISTAT) AS nComuni,
		SUM(r.numeroCaselli) AS numCaselli
FROM 	autostrada a 
		JOIN raggiunge r ON r.autostrada = a.codice
		JOIN comune c ON c.codiceISTAT = r.comune 	
GROUP BY a.codice, a.lunghezza
HAVING COUNT(r.comune) >= 2;


# selezioni le autostrade che hanno "potenziale di utenti diretti" medio rispetto
# al numero di caselli dell'autostrada stessa SUPERIORE alla media degli utenti
# per casello di tutte le autostrade. Riporto codice autostrada, numero totale 
# utenti, media utenti per casello
CREATE VIEW utenti_diretti_autostrade AS 
SELECT 	r.autostrada AS codiceAutostrada, 
		SUM(c.abitanti) AS numUtenti
		SUM(r.numeroCaselli) AS numCaselli
FROM 	raggiunge r 
		JOIN comune c ON r.comune = c.codiceISTAT
GROUP BY codiceAutostrada

SELECT 	v.codiceAutostrada, v.numUtenti, v.numUtenti/v.numCaselli
FROM 	utenti_diretti_autostrade v
WHERE 	v.numUtenti/v.numCaselli >= ALL(SELECT AVG(numUtenti/numCaselli)
										FROM 	utenti_diretti_autostrade);
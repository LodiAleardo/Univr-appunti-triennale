# trovo i comuni che non sono raggiunti da autostrade del gestore 'X', riportando
# codice, nome e abitanti del comune
# per il test, X='Gestione regionale' e i risultati devono essere 3 
SELECT 	c.codiceISTAT, c.nome, c.numeroAbitanti
FROM 	comune c 
WHERE 	c.codiceISTAT NOT IN(
			SELECT 	c.codiceISTAT
			FROM 	comune c 
					JOIN raggiunge r ON c.codiceISTAT = r.comune
					JOIN autostrada a ON a.codice = r.autostrada
			WHERE 	a.gestore = 'Gestione regionale');
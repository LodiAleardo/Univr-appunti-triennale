# non ci sono ulteriori indici da dichiarare

SELECT 	*
FROM 	comune c JOIN raggiunge r ON c.codiceISTAT = r.comune
WHERE 	autostrada = 'A1';
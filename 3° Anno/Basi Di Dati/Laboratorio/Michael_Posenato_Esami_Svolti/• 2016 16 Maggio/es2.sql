# trovo i clienti che non hanno mai noleggiato auto della marca 'X'
# riporto nome, cognome e provenienza del cliente

# trovo i clienti che hanno noleggiato auto di marca X
CREATE VIEW e2 AS
SELECT 	c.nPatente AS idCliente
FROM 	cliente c 
		JOIN noleggio n ON n.cliente = c.nPatente
		JOIN auto a ON n.auto = a.targa
WHERE 	a.marca = 'X'

# tolgo tali clienti dal totale
SELECT 	c.nome, c.cognome, c.paeseProvenienza
FROM 	cliente c 
WHERE 	c.nPatete NOT IN (SELECT idCliente FROM e2)

# alternativamente, piu compatta:
SELECT 	c.nome, c.cognome, c.paeseProvenienza
FROM 	cliente c 
WHERE 	c.nPatente NOT IN (
			SELECT 	c.nPatente AS idCliente
			FROM 	cliente c 
					JOIN noleggio n ON n.cliente = c.nPatente
					JOIN auto a ON n.targa = a.targa
			WHERE 	a.marca = 'BMW');
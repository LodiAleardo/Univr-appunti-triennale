# a. Trovo per ogni convegno il numero totale e la durata degli interventi per
# ciascuna sessione del convegno. Mostro nome convegno, giorno e conteggi
SELECT 	iic.nomeConvegno AS convegno, 
		s.data AS giorno, 
		COUNT(i.idIntervento) AS numInterventi,
		SUM(i.durata) AS durataTot
FROM 	intervento_in_convegno iic 
		JOIN intervento i ON i.id = iic.idIntervento
		JOIN sessione s ON s.nomeConvegno = c.nome
GROUP BY convegno, giorno;


# b. trovo per ogni convegno distribuito su almeno 3 giorni il numero totale
# di interventi e la durata degli interventi per ogni giorno di convegno.
# mostro nome convegno, giorno e conteggi
CREATE VIEW e2b AS
SELECT 	c.nome AS nomeCon
		s.data AS giornoCon
FROM 	convegno c 
		JOIN sessione s ON c.nome = s.nomeConvegno
GROUP BY c.nome
HAVING COUNT(*) >= 3;

SELECT 	v.nomeCon AS convegno,
		v.giornoCon AS giorno,
		COUNT(iic.idIntervento) AS numInterventi,
		SUM(i.durata) AS durataTot
FROM 	e2b v 
		JOIN intervento_in_convegno iic ON v.nomeCon = iic.nomeConvegno
		JOIN intervento i ON i.id = iic.idIntervento
WHERE 
GROUP BY convegno, giorno;
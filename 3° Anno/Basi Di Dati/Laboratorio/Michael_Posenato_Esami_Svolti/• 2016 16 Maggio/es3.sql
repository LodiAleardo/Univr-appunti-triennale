# trovo per ogni marca d'auto che ha avuto almeno un noleggio: 
# il numero totale di auto di quella marca, il numero di noleggi in cui e' stata
# usata un'auto di quella marca, e numero complessivo di ore di noleggio per
# auto di quella marca. Riporto marca e conteggi

SELECT 	a.marca, 
		COUNT(DISTINCT a.targa) AS numAuto, 
		COUNT(n.targa) AS numNoleggi,  
		SUM(EXTRACT(days FROM(n.fine - n.inizio))*24) AS oreNoleggio
FROM 	auto a 
		LEFT JOIN noleggio n ON n.targa=a.targa 
GROUP BY a.marca; 


# trovo la marca con il massimo numero di ore di noleggio e il numero di ore di
# noleggio
SELECT 	a.marca AS marcaAuto,
		SUM(EXTRACT(epoch FROM (n.fine - n.inizio)))/3600 AS oreNoleggio
FROM  	noleggio n
		JOIN auto a ON n.targa = a.targa
GROUP BY a.marca 
HAVING 	SUM(n.fine - n.inizio) >= ALL (
				SELECT 	SUM(n.fine - n.inizio)
				FROM 	noleggio n 
						JOIN auto a2 ON a2.targa = n.targa 
				WHERE 	a2.marca <> a.marca
				);





# trovo per ogni ricetta la quantita' totale di proteine e di grassi, riportando
# anche il nome della ricetta
SELECT 	r.nome AS ricetta,
		ROUND(SUM(i.proteine/100 * c.quantita),1) AS proteine,
		ROUND(SUM(i.grassi/100 * c.quantita),1) AS grassi
FROM 	ricetta r 
		JOIN composizione c ON r.id = c.ricetta
		JOIN ingrediente i ON i.id = c.ingrediente
GROUP BY r.nome;


# trovo le ricette che hanno massima quantita' di grassi per porzione, riportando
# il nome della ricetta, e la sua quantita di grasso totale
SELECT 	r.nome AS ricetta,
		ROUND(SUM(i.grassi/100 * c.quantita/r.porzioni),1) AS grassiTotali
FROM 	ricetta r 
		JOIN composizione c ON r.id = c.ricetta 
		JOIN ingrediente i ON i.id = c.ingrediente
GROUP BY r.nome
HAVING 	SUM(i.grassi/100 * c.quantita/r.porzioni)  >= ALL (
		SELECT 	SUM(i.grassi/100 * c.quantita/r.porzioni)
		FROM 	ricetta r 
				JOIN composizione c ON r.id = c.ricetta 
				JOIN ingrediente i ON i.id = c.ingrediente 	
		GROUP BY r.nome
		);


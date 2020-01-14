# trovo nome e tempo di preparazione delle ricette venete che contengono
# almeno un ingrediente con piu' del 40% di carboidrati

SELECT 	DISTINCT r.nome, r.tempoPreparazione
FROM 	ricetta r 
		JOIN composizione c ON c.ricetta = r.id 
		JOIN ingrediente i ON c.ingrediente = i.id
WHERE 	r.regione = 'Veneto'
		AND i.carboidrati > 40;


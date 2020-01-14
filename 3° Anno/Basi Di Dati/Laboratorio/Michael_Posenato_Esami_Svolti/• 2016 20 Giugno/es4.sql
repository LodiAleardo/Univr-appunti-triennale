# Query di partenza:
SELECT 	(...)
FROM 	ricetta r
		JOIN composizione c ON c.ricetta = r.id
		JOIN ingrediente i ON c.ingrediente = i.id 
WHERE 	r.regione = 'Veneto'
		AND i.carboidrati > 40

CREATE INDEX idx_ricetta_regione ON ricetta(regione);
CREATE INDEX idx_ingrediente_carbs ON ingrediente(carboidrati);
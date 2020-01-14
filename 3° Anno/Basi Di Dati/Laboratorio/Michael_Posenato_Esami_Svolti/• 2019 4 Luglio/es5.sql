# testo della query
SELECT 	i.nomeins
FROM 	docenza d 
		JOIN inserogato ie ON d.id_inserogato = ie.id 
		JOIN insegn i ON ie.id_inserogato = i.id
WHERE 	ie.annoaccademico>'2010/2011'
GROUP BY i.nomeins
HAVING COUNT(DISTINCT d.id_persona) > 2

# codice creazione indici
CREATE INDEX i1 ON inserogato(annoaccademico varchar_pattern_ops)

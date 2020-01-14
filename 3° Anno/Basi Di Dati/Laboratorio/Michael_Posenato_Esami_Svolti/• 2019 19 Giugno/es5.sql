# testo della query
EXPLAIN
SELECT 	i.nomeins
FROM 	insegn i 
		JOIN inserogato ie ON ie.id_insegn = i.id 
WHERE 	ie.annoaccademico>'2010/2011'
GROUP BY i.nomeins;

# indici creati
CREATE INDEX inserogato_annoaccademico_idx1 ON inserogato(annoaccademico varchar_pattern_ops);

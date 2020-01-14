# testo della query
SELECT 	#cols
FROM 	insegn i 
		JOIN inserogato ie ON ie.id_insegn = i.id 
WHERE 	ie.annoaccademico = '2006/2007'
		AND ie.id_corsostudi = 4;

# indici creati
CREATE INDEX i1 ON insegn(id); 	-- idx su chiavi primarie vengono creati 
								-- in automatico da PG
CREATE INDEX i2 ON inserogato(annoaccademico varchar_pattern_ops, id_corsostudi);

# si passa da ~6430 accessi a disco a ~360.
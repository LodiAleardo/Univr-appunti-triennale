# codice creazione indici:
CREATE INDEX ins_aa ON inserogato(annoaccademico, crediti, modulo)

# per capire se conviene creare altri indici, provo a risalire al testo query
SELECT 	(...)
FROM 	insegn i 
		JOIN inserogato ie ON i.id = ie.id_insegn
		JOIN discriminante d ON d.id = ie.id_discriminante
WHERE 	ie.annoaccademico = '2009/2010' 
		AND ie.crediti IN (3, 5, 12)
		AND ie.modulo = 0
GROUP BY i.nomeins, d.descrizione

# Non e' possibile migliorare le prestazioni della query utilizzando altri indici
# dato il convegno 'X', scrivo una query che ne visualizzi il programma. I.e. un elenco ordinato per giorno e ora degli interventi:
# riporto sessione, titoloIntervento, relatore e orario di inizio intervento.
SELECT 	iic.nomeSessione, i.nome, i.relatore, iic.orarioInizio
FROM 	intervento_in_convegno iic 
		JOIN intervento i ON i.id = iic.idIntervento
		JOIN convegno c ON c.nome = iic.nomeConvegno
		JOIN sessione s ON c.nome = s.nomeConvegno
WHERE 	iic.nomeConvegno='X'
ORDER BY s.data, iic.orarioInizio
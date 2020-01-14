# Codice POSTGRES per trovare tutti gli id e nomi degli ospedali dove sono stati
# ricoverati almeno 1 volta pazienti nati in svizzera

SELECT 	DISTINCT o.id, o.nome
FROM 	ospedale o 
		JOIN divisione d ON o.id = d.idOspedale
		JOIN ricovero r ON r.divisione = d.id 
		JOIN paziente p ON r.paziente = p.codiceFiscale
WHERE 	p.nazione = 'SVI';
# trovo il nome delle regioni aventi pazienti ricoverati che non hanno mai avuto
# ricoveri a CARDIOCHIRURGIA all'ospedale BORGO TRENTO
SELECT 	DISTINCT p.regione 
FROM 	paziente p 
		JOIN ricovero r ON r.paziente = p.codiceFiscale
		JOIN divisione d ON r.divisione = d.id 
		JOIN ospedale o ON d.idOspedale = o.id 
WHERE 	o.nome<>'BORGO TRENTO'
		AND d.nome<>'CARDIOCHIRURGIA'
		AND r.dataDimissione < CURRENT_DATE;

# considerate solo le divisioni di CARDIOLOGIA E CARDIOCHIRURGIA di BORGO TRENTO,
# trovo le regioni con il numeri di ricoveri non urgenti numericamente maggiori
# dei ricoveri urgenti relative alla stessa regione. Riporto regione,
# numero ricoveri non urgenti e durata.
SELECT 	p.regione, COUNT(*) AS ricoveri, (r.dataDimissione-r.dataAmmissione) AS durata
FROM 	paziente p 
		JOIN ricovero r ON p.codiceFiscale = r.paziente
		JOIN divisione d ON d.id = r.divisione
		JOIN ospedale o ON d.idOspedale = o.id
WHERE 	((d.nome = 'cardiologia' OR d.nome = 'cardiochirurgia') AND o.nome='Ospedale Borgo Trento')
		AND r.urgenza <> 'urgente'
GROUP BY regione, durata
HAVING 	COUNT(*) > (
			SELECT  COUNT(*)
			FROM 	ricovero r2 
					JOIN paziente p2 ON r2.paziente = p2.codiceFiscale
					JOIN divisione d2 ON d2.id = r2.divisione
					JOIN ospedale o2 ON o2.id = d2.idOspedale
			WHERE 	((d2.nome = 'cardiochirurgia' OR d2.nome = 'cardiologia') AND o2.nome='Ospedale Borgo Trento')
					AND r2.urgenza = 'urgente'
					AND p.regione = p2.regione
			);

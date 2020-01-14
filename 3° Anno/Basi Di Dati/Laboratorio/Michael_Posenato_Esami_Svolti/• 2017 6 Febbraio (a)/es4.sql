# trovo per ogni programma distribuito su almeno 3 giorni (TOTAL_BODY e TOTAL_LEGS)
# il num totale di esercizi da svolgere e il tempo totale in minuti per ogni giorno
# di allenamento. Mostro nome programma, giorno e conteggi per ciascun giorno

#creo una vista che isoli i programmi interessati
CREATE VIEW programmi_3_giorni AS 
SELECT 	nomeProgramma
FROM 	esercizio_in_programma eip 
GROUP BY nomeProgramma
HAVING 	COUNT(DISTINCT giorno) >= 3

SELECT 	eip.nomeProgramma AS programma,
		eip.giorno AS giorno,
		COUNT(*) AS num_esercizi,
		SUM(((((t.ecc_mov + t.ecc_pos + t.conc_mov + t.conc_pos)*eip.ripetizioni + eip.riposo)*eip.serie)))/60 AS minutiDurata
FROM 	esercizio_in_programma eip 
		JOIN programma p ON eip.nomeProgramma = p.nome
		JOIN TEMPO_T t ON t.id = eip.TUT 
WHERE 	eip.nomeProgramma IN (SELECT nomeProgramma FROM programmi_3_giorni)
GROUP BY  	programma, giorno
ORDER BY 	eip.nomeProgramma, eip.giorno;


# trovo tutti i programmi di allenamento (nome e livello) che contiene esercizi
# di livello principiante per gambe, dura almeno 45 minuti per ogni giorno,
# e non contiene esercizi di petto (SOLO TOTAL_LEGS)

# creo una vista che a ogni programma di allenamento associa la durata in minuti
# per ogni esercizio, gli esercizi, il loro gruppo muscolare e il loro livello

# non sono mica tanto sicuro che sia ok, ma e' meglio di un calcio negli stinchi

CREATE VIEW programmi_e_dati AS
SELECT 	eip.nomeProgramma AS programma,
		eip.giorno AS giorno,
		eip.nomeEsercizio AS esercizio,
		e.gruppoMuscolare AS gruppoMusc,
		e.livello AS livelloEs,
		SUM(((((t.ecc_mov + t.ecc_pos + t.conc_mov + t.conc_pos)*eip.ripetizioni + eip.riposo)*eip.serie)))/60 AS durataEs
FROM 	esercizio_in_programma eip 
		JOIN esercizio e ON e.nome = eip.nomeEsercizio
		JOIN TEMPO_T t ON t.id = eip.TUT 
GROUP BY programma, giorno, esercizio, gruppoMusc, livelloEs
ORDER BY programma;

SELECT 	DISTINCT programma
FROM 	programmi_e_dati
WHERE 	gruppoMusc <> 'petto'
GROUP BY programma, giorno 
HAVING 	SUM(durataEs) > 45
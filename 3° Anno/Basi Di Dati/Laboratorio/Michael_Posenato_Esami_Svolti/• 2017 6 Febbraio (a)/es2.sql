# dato il nome X di un programma, visualizzo gli esercizi da fare (con tutti
# i dati necessari per l'esecuzione) ordinati per giorno di allenamento e
# ordine di esecuzione. Visualizzo anche il gruppo muscoalare
# X = TOTAL_BODY per la prova

SELECT 	e.nome, e.gruppoMuscolare, eip.serie, eip.ripetizioni, eip.TUT, eip.riposo
FROM 	programma p 
		JOIN esercizio_in_programma eip ON eip.nomeProgramma = p.nome 
		JOIN esercizio e ON eip.nomeEsercizio = e.nome
WHERE 	p.nome = 'TOTAL_BODY'
ORDER BY eip.giorno, eip.ordine;

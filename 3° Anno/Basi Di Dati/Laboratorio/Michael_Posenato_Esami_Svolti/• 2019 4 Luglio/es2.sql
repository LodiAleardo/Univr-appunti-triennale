# scrivo le seguenti query SENZA USARE il data binding, e con il minor
# numero possibile di JOIN

# 2a per ogni citta', determino i prodotti con prezzo maggiore (nella citta),
# indicando nomeCitta, negozio, poi codice, nome e prezzo del prodotto

# vista che a ogni citta associa i prodotti in vendita e il loro prezzo
CREATE VIEW citta_e_prodotti AS 
SELECT 	n.citta AS nomeCitta,
		l.prodotto AS idProdotto,
		p.nome AS nomeProdotto,
		l.prezzo AS prezzoProdotto
FROM 	listino l 
		JOIN negozio n ON l.negozio = n.codice 	
		JOIN prodotto p ON l.prodotto = p.codice;

# query che funziona, ma utilizza data-binding
SELECT 	nomeCitta, idProdotto, nomeProdotto, prezzoProdotto
FROM 	citta_e_prodotti v
WHERE 	prezzoProdotto >= ALL (
			SELECT prezzoProdotto 
			FROM citta_e_prodotti v2 
			WHERE v.nomeCitta = v2.nomeCitta) 	

# tentativo senza databinding...
# vista che a ogni citta associa il prezzo del prodotto piu costoso
CREATE VIEW citta_prezzo_max AS 
SELECT 	DISTINCT n.citta AS nomeCitta, MAX(l.prezzo) AS prezzoMax
FROM 	listino l 
		JOIN negozio n ON l.negozio = n.codice
GROUP BY n.citta;

SELECT 	v.nomecitta, n.codice, p.codice, p.nome, v.prezzoMax
FROM 	citta_prezzo_max v 
		JOIN negozio n ON n.citta = v.nomecitta 
		JOIN listino l ON l.negozio = n.codice 
		JOIN prodotto p ON p.codice = l.prodotto 
WHERE v.prezzomax = l.prezzo;

# 2b. trovo i prodotti che vengono venduti in 1 sola citta. Mostro codice e 
# nome prodotto e nome citta', ordinati per nome citta

# vista con i prodotti venduti in piu di una citta
CREATE VIEW prodotti_piu_citta AS
SELECT 	l.prodotto AS idProdotto, 
		p.nome AS nomeProdotto
FROM 	listino l 
		JOIN negozio n ON l.negozio = n.codice
		JOIN prodotto p ON l.prodotto = p.codice
GROUP BY l.prodotto, p.nome
HAVING COUNT(distinct n.citta) > 1;

SELECT 	DISTINCT p.codice, p.nome, n.citta
FROM 	prodotto p 
		JOIN listino l ON l.prodotto = p.codice
		JOIN negozio n ON l.negozio = n.codice
WHERE 	p.codice NOT IN (SELECT idProdotto FROM prodotti_piu_citta);


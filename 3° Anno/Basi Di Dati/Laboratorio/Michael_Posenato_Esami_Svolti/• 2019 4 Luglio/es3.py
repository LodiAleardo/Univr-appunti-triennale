# programma py che leggendo un prodotto da console, visualizza la citta
# risultato della query 2b (adattata al fatto che si fornisce un codice prodotto).

# se il prodotto non e' venduto o se e' venduto in piu' citta', il programma deve
# segnalare la cosa.

# se il prodotto non esiste, il programma deve segnalare l'errore e richiedere
# nuovamente il dato

import psycopg2
from myConfig import myHost, myDB, myUsr, myPsw

# connessione al db
with psycopg2.connect(host=myHost, database=myDB, user=myUsr, password=myPsw) as conn:
	with conn.cursor() as cur:

		# acquisizione id prodotto e relativo controllo
		idProdotto = ''
		checking = True

		while(checking):
			idProdotto = input('Inserisci ID prodotto: ')

			cur.execute('SELECT COUNT(*) FROM prodotto WHERE codice=%s', (idProdotto,))
			status = cur.fetchone()

			if status == None or status[0] != 1:
				print('l\'ID inserito non corrisponde a nessun prodotto. Ripetere inserimento')
				continue

			checking = False

		# prodotto valido: eseguo la query
		cur.execute(''' 
			SELECT 	DISTINCT n.citta
			FROM 	prodotto p 
					JOIN listino l ON l.prodotto = p.codice
					JOIN negozio n ON l.negozio = n.codice
			WHERE 	p.codice NOT IN (SELECT idProdotto FROM prodotti_piu_citta)
			AND p.codice=%s;''', (idProdotto, ))
		results = list(cur)

		# se la lista e' vuota, il prodotto esiste ma non e' una esclusiva, oppure
		# non e' in vendita presso nessun negozio
		if !results:
			print('Il prodotto non e\' una esclusiva oppure non e\' in vendita')

		else:
			print('il prodotto e\' in vendita esclusiva presso', cur.fetchone()[0]);



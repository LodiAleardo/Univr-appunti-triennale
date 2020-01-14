# programma py che leggendo i dati da console inserisca una o piu tuple in 
# ESERCIZIO_IN_PROGRAMMA, controllando le dipendenze (solo quelle verso altre
# tabelle, non i domini, senno ciaone finisco domani).
# Per il resto solita consegna

import psycopg2
from myConfig import myH, myD, myU, myP

nomeProgramma=''
nomeEsercizio=''
giorno=''
ordine=''
serie=''
ripetizioni=''
TUT=''
riposo=''
iteration='s'
rowCount=0

with psycopg2.connect(host=myH, database=myD, user=myU, password=myP) as conn:
	with conn.cursor() as cur:
		while(iteration == 's'):

			# richiesta e controllo sul programma
			checking=True
			while(checking):
				nomeProgramma=input('Nome programma [str]: ')
				cur.execute('SELECT COUNT(*) FROM programma WHERE nome=%s',(nomeProgramma,))
				status=cur.fetchone()

				if status == None or status[0]!=1:
					print('Nome programma non valido. Ripetere inserimento')
					continue
				else:
					checking=False

			# richiesta e controllo sull'esercizio
			checking=True
			while(checking):
				nomeEsercizio=input('Nome esercizio [str]: ')
				cur.execute('SELECT COUNT(*) FROM esercizio WHERE nome=%s',(nomeEsercizio,))
				status=cur.fetchone()

				if status == None or status[0]!=1:
					print('Nome esercizio non valido. Ripetere inserimento')
					continue
				else:
					checking=False

			# richiesta degli altri campi, su cui non eseguo controlli
			giorno=input('giorno [LUN/MAR...]: ')
			ordine=input('ordine [1,2,3...]: ')
			serie=input('numero serie [int]: ')
			ripetizioni=input('numero reps [int]: ')
			TUT=input('tempo [1-0-0-1]: ')
			riposo=input('riposo [int, in secondi]: ')

			# esecuzione inserimento
			cur.execute(''' 
				INSERT INTO esercizio_in_programma(nomeProgramma, nomeEsercizio, 
							giorno, ordine, serie, ripetizioni, TUT, riposo) VALUES
				(%s,%s,%s,%s,%s,%s,%s,%s)
				''',(nomeProgramma, nomeEsercizio, giorno, ordine, serie,
						ripetizioni, TUT, riposo))

			print('esito inserimento: ' + cur.statusmessage)
			rowCount += cur.rowCount

			# altra iterazione?
			iteration = input('inserire altro esercizio? [s/n]')

print(rowCount + ' esercizi inseriti in questa sessione. Salutoni bois')
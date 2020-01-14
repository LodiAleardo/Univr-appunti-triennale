''' Solito programma python che riceve in inoput i dati da inserire nella tabella
ricovero(divisione, paziente, descrizione, urgenza, dataAmmissione, dataDimissione).
Il programma visualizzi l'esito di ogni insert.'''

import psycopg2
from myConfig import myH, myD, myU, myP
from datetime import date

with psycopg2.connect(host=myH, database=myD, user=myU, password=myP) as conn:
	with conn.cursor() as cur:

		iteration = 's'
		while(iteration == 's'):

			# richiesta e check divisione
			checking = True
			divisione = ''

			while(checking):
				divisione = input('Divisione [stringa]: ')
				cur.execute('SELECT COUNT(*) FROM divisione WHERE id=%s',(divisione,))
				status=cur.fetchone()

				if status == None or status[0] != 1:
					print('divisione non esistente. Ripetere inserimento')
					continue
				else:
					checking = False

			# richiesta e check paziente
			checking = True
			paziente = ''

			while(checking):
				paziente = input('Paziente [codice fiscale]: ')
				cur.execute('SELECT COUNT(*) FROM paziente WHERE codiceFiscale=%s',(paziente,))
				status = cur.fetchone()

				if status == None or status[0] != 1:
					print('Paziente non valido. Ripetere inserimento')
					continue
				else:
					checking = False

			# richiesta altri parametri:
			descrizione = input('Descrizione [stringa]: ')
			urgenza = input('urgenza [stringa]: ')
			dataAmmissione = input('data Ammissione [aaaa-mm-gg]: ')
			dataDimissione = input('data Dimissione [aaaa-mm-gg]? ')

			### possibile check su dataDimissione ###

			# conversione tipi per le date:
			dataAmmissione = datetime.strptime(dataAmmissione, '%Y-%m-%d').date()
			dataDimissione = datetime.strptime(dataDimissione, '%Y-%m-%d').date()

			# controlli fatti. Eseguo INSERT
			cur.execute('''
				INSERT INTO 
				ricovero(divisione,paziente,descrizione,urgenza,dataAmmissione,dataDimissione) 
				VALUES
				(%s,%s,%s,%s,%s,%s)
				''',(divisione,paziente,descrizione,urgenza,dataAmmissione,dataDimissione))

			print('Esito insert: ', cur.statusmessage)

		iteration = input('Continuare? [s/n]')
